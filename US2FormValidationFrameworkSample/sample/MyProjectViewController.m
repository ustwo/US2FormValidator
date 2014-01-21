//
//  MyProjectViewController.m
//  US2FormValidator
//
//  Copyright (C) 2012 ustwo™
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//  

//
//  A simple test view controller which creates a test view with some
//  sample validation text fields on it.
//  This controller sets the properties of all created validator text fields.
//  When text inputs are violating the configured conditions (US2Condition)
//  the delegate instance will receive this information.
//

#import "US2FormValidator.h"

#import "MyProjectViewController.h"
#import "US2ValidatableDelegate.h"
#import "US2Validatable.h"


@interface MyProjectViewController () <US2ValidatorTextFieldDelegate,
                                       US2ValidatorTextViewDelegate>
{
    NSMutableArray *_typeStringCollection;
    BOOL           _didSubmit;
    
    id<US2Validatable> _tooltipConnectedValidatable;
    
    US2ValidatorForm *_form;
}
@end


@implementation MyProjectViewController


#pragma mark - View setter and getter

- (void)setMyProjectView:(MyProjectView *)view
{
    self.view = view;
}

- (MyProjectView *)myProjectView
{
    return (MyProjectView *)self.view;
}


#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    [self buildView];
}

/**
 Build custom view with test validator text fields added
*/
- (void)buildView
{
    self.myProjectView = [[MyProjectView alloc] initWithFrame:self.view.frame];
}

/**
 Initialize the UI components after view did load
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self US2_initData];
    [self US2_initUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self US2_updateUserInterface];
}


#pragma mark - Initialize data

- (void)US2_initData
{
    // Flag whether 'submit' button was touched to validate every text UI
    _didSubmit = NO;
    
    [self createForm];
}

- (void)createForm
{
    _form = [[US2ValidatorForm alloc] init];
    
    typeof(self) __weak weakSelf = self;
    [_form setDidChangeValidState:^(BOOL isValid) {
        
        typeof(self) __strong strongSelf = weakSelf;
        if (!strongSelf) return;
        
        [strongSelf US2_updateUserInterface];
        NSLog(@"form's state changed to: %@", (isValid ? @"YES" : @"NO"));
    }];
}


#pragma mark - Initialize user interface

- (void)US2_initUserInterface
{
    // Set text fields which will be used in form
    [self US2_initAboutValidator];
    [self US2_initEmailValidator];
    [self US2_initUKPostcodeValidator];
    [self US2_initSubmitButton];
}

- (void)US2_initAboutValidator
{
    US2ValidatorPresent *validator = [[US2ValidatorPresent alloc] init];
    
    self.myProjectView.aboutTextField.validator               = validator;
    self.myProjectView.aboutTextField.delegate                = self;
    self.myProjectView.aboutTextField.validateOnFocusLossOnly = YES;
    self.myProjectView.aboutTextField.placeholder             = @"At least something about you";
    [_form addValidatable:self.myProjectView.aboutTextField];
}

- (void)US2_initEmailValidator
{
    US2Validator *compositeValidator = [[US2Validator alloc] init];
    US2ConditionPresent *presentCondition = [US2ConditionPresent condition];
    US2ConditionEmail *emailCondition = [US2ConditionEmail condition];
    [compositeValidator addCondition:presentCondition];
    [compositeValidator addCondition:emailCondition];
    
    self.myProjectView.emailTextField.validator               = compositeValidator;
    self.myProjectView.emailTextField.delegate                = self;
    self.myProjectView.emailTextField.validateOnFocusLossOnly = YES;
    self.myProjectView.emailTextField.placeholder             = @"piglet@ustwo.co.uk";
    [_form addValidatable:self.myProjectView.emailTextField];
}

- (void)US2_initUKPostcodeValidator
{
    US2Validator *compositeValidator = [[US2Validator alloc] init];
    US2ConditionPresent *presentCondition = [US2ConditionPresent condition];
    US2ConditionPostcodeUK *ukPostcodeCondition = [US2ConditionPostcodeUK condition];
    [compositeValidator addCondition:presentCondition];
    [compositeValidator addCondition:ukPostcodeCondition];
    
    self.myProjectView.ukPostcodeTextField.validator               = compositeValidator;
    self.myProjectView.ukPostcodeTextField.delegate                = self;
    self.myProjectView.ukPostcodeTextField.validateOnFocusLossOnly = YES;
    self.myProjectView.ukPostcodeTextField.placeholder             = @"Postcode";
    [_form addValidatable:self.myProjectView.ukPostcodeTextField];
}

- (void)US2_initSubmitButton
{
    [self.myProjectView.submitButton addTarget:self
                                        action:@selector(US2_submitButtonTouched:)
                              forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Update user interface

- (void)US2_updateUserInterface
{
    [self US2_updateSubmitButton];
}

- (void)US2_updateSubmitButton
{
    self.myProjectView.submitButton.enabled = _form.isValid;
}


#pragma mark - Validator text field protocol

/**
 Called for every valid or violated state change
 React to this information by showing up warnings or disabling a 'submit' button e.g.
*/
- (void)validatable:(id<US2Validatable>)validatable changedValidState:(BOOL)isValid
{
    NSLog(@"validatorUI changedValidState: %d", isValid);
    
    if (validatable == self.myProjectView.aboutTextField)
    {
        self.myProjectView.aboutErrorLabel.text = @"";
    }
    else if (validatable == self.myProjectView.emailTextField)
    {
        self.myProjectView.emailErrorLabel.text = @"";
    }
    else if (validatable == self.myProjectView.ukPostcodeTextField)
    {
        self.myProjectView.ukPostcodeErrorLabel.text = @"";
    }
}

/**
 Called on every violation of the highest prioritised validator condition.
 Update UI like showing alert messages or disabling buttons.
*/
- (void)validatable:(id<US2Validatable>)validatable violatedConditions:(US2ConditionCollection *)conditions
{
    NSLog(@"validatorUI violatedConditions: \n%@", conditions);
    
    US2Condition *condition = [conditions conditionAtIndex:0];
    if (validatable == self.myProjectView.aboutTextField)
    {
        self.myProjectView.aboutErrorLabel.text = condition.localizedViolationString;
    }
    else if (validatable == self.myProjectView.emailTextField)
    {
        self.myProjectView.emailErrorLabel.text = condition.localizedViolationString;
    }
    else if (validatable == self.myProjectView.ukPostcodeTextField)
    {
        self.myProjectView.ukPostcodeErrorLabel.text = condition.localizedViolationString;
    }
}


#pragma mark - Submit button

- (void)US2_submitButtonTouched:(UIButton *)button
{
    // Set flag to YES
    _didSubmit = YES;
}


@end
