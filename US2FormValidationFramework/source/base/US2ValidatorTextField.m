//
//  US2ValidatorTextField.m
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

#import "US2ValidatorTextField.h"
#import "US2ValidatorTextFieldPrivate.h"
#import "US2Condition.h"
#import "US2Validator.h"


@interface US2ValidatorTextField (private)
- (void)_startUp;
@end


@implementation US2ValidatorTextField


@synthesize validatorUIDelegate     = _validatorUIDelegate;
@synthesize validator               = _validator;
@synthesize shouldAllowViolations   = _shouldAllowViolations;
@synthesize validateOnFocusLossOnly = _validateOnFocusLossOnly;
@dynamic    isValid;


#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self != nil)
	{
        [self _startUp];
	}
    
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _startUp];
    }
    
    return self;
}


#pragma mark - Deinitialization

- (void)dealloc
{
    // Remove notification observers
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:_validatorTextFieldPrivate name:UITextFieldTextDidChangeNotification object:self];
    [notificationCenter removeObserver:_validatorTextFieldPrivate name:UITextFieldTextDidEndEditingNotification object:self];
    
    [_validator release];
    [_validatorTextFieldPrivate release];
    
    [super dealloc];
}


#pragma mark - Start up

- (void)_startUp
{
    // Allows violation initially
    _shouldAllowViolations = YES;
    
    // Validate immediately
    _validateOnFocusLossOnly = NO;
    
    // Create listening instance 
    _validatorTextFieldPrivate = [[US2ValidatorTextFieldPrivate alloc] init];
    _validatorTextFieldPrivate.validatorTextField = self;
    super.delegate = (id)_validatorTextFieldPrivate;
    
    // Listen for update of inherited UITextField
    [[NSNotificationCenter defaultCenter] addObserver:_validatorTextFieldPrivate selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    
    // Listen for end of editing
    [[NSNotificationCenter defaultCenter] addObserver:_validatorTextFieldPrivate selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
}


#pragma mark - Delegate

- (void)setValidatorUIDelegate:(id <US2ValidatorUIDelegate, UITextFieldDelegate>)validatorUIDelegate
{
    _validatorTextFieldPrivate.delegate = validatorUIDelegate;
}

- (id <US2ValidatorUIDelegate>)setValidatorUIDelegate
{
    return _validatorTextFieldPrivate.delegate;
}


#pragma mark - Set validator

- (void)setValidator:(US2Validator *)validator
{
    [_validator release];
    _validator = [validator retain];
}


#pragma mark - Is valid

- (BOOL)isValid
{
    return [_validator checkConditions:self.text] == nil;
}

- (NSString *) validatableText {
    return self.text;
}

#pragma mark - 

/**
 After occurring violations the UI will be changed.
*/
- (void)validatorTextFieldPrivate:(US2ValidatorTextFieldPrivate *)textFieldPrivate violatedConditions:(US2ConditionCollection *)conditions
{
}

/**
 After the text of the text field turns into valid the UI will be changed back.
*/
- (void)validatorTextFieldPrivateSuccededConditions:(US2ValidatorTextFieldPrivate *)textFieldPrivate
{
}


@end
