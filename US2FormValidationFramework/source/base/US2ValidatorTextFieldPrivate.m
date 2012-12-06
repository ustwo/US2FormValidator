//
//  US2ValidatorTextFieldPrivate.m
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

#import "US2ValidatorTextFieldPrivate.h"
#import "US2ConditionCollection.h"
#import "US2ValidatorTextField.h"
#import "US2Validator.h"

@implementation US2ValidatorTextFieldPrivate


@synthesize delegate           = _delegate;
@synthesize validatorTextField = _validatorTextField;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _lastIsValid = -1;
    }
    
    return self;
}


#pragma mark - Text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *futureString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    US2ConditionCollection *conditions = [_validatorTextField.validator checkConditions:futureString];
    
    // Inform text field about valid state change
    if (conditions == nil)
        [_validatorTextField validatorTextFieldPrivateSuccededConditions:self];
    else
        [_validatorTextField validatorTextFieldPrivate:self violatedConditions:conditions];
    
    // If condition is NULL no condition failed
    if (!_validatorTextField.validateOnFocusLossOnly
        && (NO == _validatorTextField.shouldAllowViolations
            || NO == [conditions conditionAtIndex:0].shouldAllowViolation)
        && range.location != 0)
    {
        return [conditions conditionAtIndex:0] == nil;
    }
    
    // Ask delegate whether should change characters in range
    if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [_delegate textField:_validatorTextField shouldChangeCharactersInRange:range replacementString:string];
    
    return YES;
}

- (void)textFieldDidChange:(NSNotification *)notification
{
    // Only validate if violations are allowed
    if (_validatorTextField.shouldAllowViolations)
    {
        // Validate according to 'validateOnFocusLossOnly' while editing first time or after focus loss
        if (!_validatorTextField.validateOnFocusLossOnly
            || (_validatorTextField.validateOnFocusLossOnly
                && _didEndEditing))
        {
            US2ConditionCollection *conditions = [_validatorTextField.validator checkConditions:_validatorTextField.text];
            BOOL isValid = conditions == nil;
            if (_lastIsValid != isValid)
            {
                _lastIsValid = isValid;
                
                // Inform text field about valid state change
                if (isValid)
                    [_validatorTextField validatorTextFieldPrivateSuccededConditions:self];
                else
                    [_validatorTextField validatorTextFieldPrivate:self violatedConditions:conditions];
                
                // Inform delegate about valid state change
                if ([_delegate respondsToSelector:@selector(validatorUI:changedValidState:)])
                    [_delegate validatorUI:_validatorTextField changedValidState:isValid];
                
                // Inform delegate about violation
                if (!isValid)
                {                
                    if ([_delegate respondsToSelector:@selector(validatorUI:violatedConditions:)])
                        [_delegate validatorUI:_validatorTextField violatedConditions:conditions];
                }
            }
        }
    }
    
    // Inform delegate about changes
    if ([_delegate respondsToSelector:@selector(validatorUIDidChange:)])
        [_delegate validatorUIDidChange:_validatorTextField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Ask delegate whether should begin editing
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [_delegate textFieldShouldBeginEditing:_validatorTextField];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [_delegate textFieldDidBeginEditing:_validatorTextField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    // Ask delegate whether should end editing
    if ([_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [_delegate textFieldShouldEndEditing:_validatorTextField];
    
    return YES;
}

/**
 * According to the feature of validating the text field after first focus loss we need to remember when
 * text field stopped editing.
 * After editing and focus loss try to validate the text field.
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // Remember focus loss
    _didEndEditing = YES;
    
    // Try to validate the text field after focus loss
    [self textFieldDidChange:nil];
    
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [_delegate textFieldDidEndEditing:_validatorTextField];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    // Ask delegate whether should clear
    if ([_delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [_delegate textFieldShouldClear:_validatorTextField];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Ask delegate whether should return
    if ([_delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [_delegate textFieldShouldReturn:_validatorTextField];
    
    return YES;
}


@end
