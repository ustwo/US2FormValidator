//
//  US2ValidatorTextViewPrivate.m
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

#import "US2ValidatorTextViewPrivate.h"
#import "US2ConditionCollection.h"
#import "US2ValidatorTextView.h"
#import "US2Validator.h"


@implementation US2ValidatorTextViewPrivate


@synthesize delegate          = _delegate;
@synthesize validatorTextView = _validatorTextView;


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


#pragma mark - Text view delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        return [_delegate textViewShouldBeginEditing:_validatorTextView];
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewShouldEndEditing:)])
        return [_delegate textViewShouldEndEditing:_validatorTextView];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [_delegate textViewDidBeginEditing:_validatorTextView];
}

/**
 According to the feature of validating the text field after first focus loss we need to remember when
 text field stopped editing.
 After editing and focus loss try to validate the text field.
 */
- (void)textViewDidEndEditing:(UITextView *)textView
{
    // Remember focus loss
    _didEndEditing = YES;
    
    // Try to validate the text field after focus loss
    [self textViewDidChange:nil];
    
    if ([_delegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [_delegate textViewDidEndEditing:_validatorTextView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *futureString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    US2ConditionCollection *conditions = [_validatorTextView.validator checkConditions:futureString];
    
    // Inform text field about valid state change
    if (conditions == nil)
        [_validatorTextView validatorTextViewDelegateSuccededConditions:self];
    else
        [_validatorTextView validatorTextViewDelegate:self violatedConditions:conditions];
    
    // If condition is NULL no condition failed
    if (!_validatorTextView.validateOnFocusLossOnly && (NO == _validatorTextView.shouldAllowViolations
        || NO == [conditions conditionAtIndex:0].shouldAllowViolation))
    {
        return [conditions conditionAtIndex:0] == nil;
    }
    
    // Ask delegate whether should change characters in range
    if ([_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        return [_delegate textView:_validatorTextView shouldChangeTextInRange:range replacementText:text];
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (YES == _validatorTextView.shouldAllowViolations)
    {
        // Validate according to 'validateOnFocusLossOnly' while editing first time or after focus loss
        if (!_validatorTextView.validateOnFocusLossOnly
            || (_validatorTextView.validateOnFocusLossOnly
                && _didEndEditing))
        {
            US2ConditionCollection *conditions = [_validatorTextView.validator checkConditions:_validatorTextView.text];
            BOOL isValid = conditions == nil;
            if (_lastIsValid != isValid)
            {
                _lastIsValid = isValid;
                
                // Inform text field about valid state change
                if (isValid)
                    [_validatorTextView validatorTextViewDelegateSuccededConditions:self];
                else
                    [_validatorTextView validatorTextViewDelegate:self violatedConditions:conditions];
                
                // Inform delegate about valid state change
                if ([_delegate respondsToSelector:@selector(validatorUI:changedValidState:)])
                    [_delegate validatorUI:_validatorTextView changedValidState:isValid];
                
                // Inform delegate about violation
                if (!isValid)
                {
                    if ([_delegate respondsToSelector:@selector(validatorUI:violatedConditions:)])
                        [_delegate validatorUI:_validatorTextView violatedConditions:conditions];
                }
            }
        }
    }
    
    // Inform delegate about changes
    if ([_delegate respondsToSelector:@selector(validatorUIChange:)])
        [_delegate validatorUIDidChange:_validatorTextView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewDidChangeSelection:)])
        [_delegate textViewDidChangeSelection:_validatorTextView];
}

@end
