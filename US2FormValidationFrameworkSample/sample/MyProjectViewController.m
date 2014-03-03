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
    US2ValidatorForm *_form;
}
@end


@implementation MyProjectViewController

/**
 Initialize the UI components after view did load
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self us2_initData];
    [self us2_initKeyboardListeners];
    [self us2_initUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self us2_updateUserInterface];
}


#pragma mark - Initialize data

- (void)us2_initData
{
    [self createForm];
}

- (void)createForm
{
    _form = [[US2ValidatorForm alloc] init];
    
    typeof(self) __weak weakSelf = self;
    [_form setDidChangeValidState:^(BOOL isValid) {
        
        typeof(self) __strong strongSelf = weakSelf;
        if (!strongSelf) return;
        
        [strongSelf us2_updateUserInterface];
        NSLog(@"form's state changed to: %@", (isValid ? @"YES" : @"NO"));
    }];
}


#pragma mark - Initialize user interface

- (void)us2_initUserInterface
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // Set text fields which will be used in form
    [self us2_initAboutValidator];
    [self us2_initEmailValidator];
    [self us2_initUKPostcodeValidator];
    [self us2_initSubmitButton];
}

- (void)us2_initAboutValidator
{
    US2ValidatorPresent *validator = [[US2ValidatorPresent alloc] init];
    
    self.myProjectView.aboutTextField.validator               = validator;
    self.myProjectView.aboutTextField.delegate                = self;
    self.myProjectView.aboutTextField.validateOnFocusLossOnly = YES;
    self.myProjectView.aboutTextField.placeholder             = @"At least something about you";
    [_form addValidatable:self.myProjectView.aboutTextField];
}

- (void)us2_initEmailValidator
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

- (void)us2_initUKPostcodeValidator
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

- (void)us2_initSubmitButton
{
    [self.myProjectView.submitButton addTarget:self
                                        action:@selector(us2_submitButtonTouched:)
                              forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Update user interface

- (void)us2_updateUserInterface
{
    [self us2_updateSubmitButton];
}

- (void)us2_updateSubmitButton
{
    self.myProjectView.submitButton.enabled = _form.isValid;
}


#pragma mark - Keyboard

- (void)us2_initKeyboardListeners
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    self.myProjectView.keyboardConstraint.constant = height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.myProjectView layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.myProjectView.keyboardConstraint.constant = 0.0;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.myProjectView layoutIfNeeded];
    }];
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

- (void)us2_submitButtonTouched:(UIButton *)button
{
    [self.myProjectView.aboutTextField resignFirstResponder];
    [self.myProjectView.emailTextField resignFirstResponder];
    [self.myProjectView.ukPostcodeTextField resignFirstResponder];
}

@end
