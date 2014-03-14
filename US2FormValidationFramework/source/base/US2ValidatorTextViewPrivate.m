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


@interface US2ValidatorTextViewPrivate () <UITextViewDelegate>

@property (nonatomic) BOOL didEndEditing;
@property (nonatomic) US2Condition *lastHighestPriorityCondition;

@end


@implementation US2ValidatorTextViewPrivate


#pragma mark - Text view delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
    {
        return [_delegate textViewShouldBeginEditing:_validatorTextView];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewShouldEndEditing:)])
    {
        return [_delegate textViewShouldEndEditing:_validatorTextView];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
    {
        [_delegate textViewDidBeginEditing:_validatorTextView];
    }
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
    {
        [_delegate textViewDidEndEditing:_validatorTextView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *futureString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    US2ConditionCollection *conditions = [_validatorTextView.validator violatedConditionsUsingString:futureString];
    BOOL isValid = conditions == nil;
    
    // Inform text field about valid state change
    if (isValid)
    {
        [_validatorTextView validatorTextViewDelegateSuccededConditions:self];
    }
    else
    {
        [_validatorTextView validatorTextViewDelegate:self violatedConditions:conditions];
    }
    
    // If any condition does not allow violation check for invalidities and do not allow to change the text field
    // Making sure that the last character can be deleted although
    BOOL anyInvalidConditionDoesNotAllowViolation = [self anyConditionDoesNotAllowViolation:conditions];
    if (!_validatorTextView.validateOnFocusLossOnly
        && anyInvalidConditionDoesNotAllowViolation)
    {
        return isValid;
    }
    
    // Ask delegate whether should change characters in range
    if ([_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
    {
        return [_delegate textView:_validatorTextView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (BOOL)anyConditionDoesNotAllowViolation:(US2ConditionCollection *)conditions
{
    for (US2Condition *condition in conditions)
    {
        if (condition.shouldAllowViolation == NO)
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    // Validate according to 'validateOnFocusLossOnly' while editing first time or after focus loss
    if (!_validatorTextView.validateOnFocusLossOnly
        || (_validatorTextView.validateOnFocusLossOnly
            && _didEndEditing))
    {
        US2ConditionCollection *conditions = [_validatorTextView.validator violatedConditionsUsingString:_validatorTextView.text];
        BOOL isValid = conditions == nil;
        
        // Check only if the state changed to invalid
        US2Condition *highestPriorityCondition = [conditions conditionAtIndex:0];
        if (_lastHighestPriorityCondition != highestPriorityCondition)
        {
            _lastHighestPriorityCondition = highestPriorityCondition;
            
            // Inform text field about valid state change
            if (isValid)
                [_validatorTextView validatorTextViewDelegateSuccededConditions:self];
            else
                [_validatorTextView validatorTextViewDelegate:self violatedConditions:conditions];
            
            // Inform delegate about valid state change
            if ([_delegate respondsToSelector:@selector(validatable:changedValidState:)])
                [_delegate validatable:_validatorTextView changedValidState:isValid];
            
            // Inform delegate about violation
            if (!isValid)
            {
                if ([_delegate respondsToSelector:@selector(validatable:violatedConditions:)])
                    [_delegate validatable:_validatorTextView violatedConditions:conditions];
            }
        }
    }
    
    // Inform delegate about changes
    if ([_delegate respondsToSelector:@selector(validatorUIDidChange:)])
    {
        [_delegate validatableDidChange:_validatorTextView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewDidChangeSelection:)])
    {
        [_delegate textViewDidChangeSelection:_validatorTextView];
    }
}

@end
