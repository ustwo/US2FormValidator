//
//  US2ValidatorUIProtocol.h
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol US2ValidatorUIDelegate;

@class US2Validator;

/**
 A text user interface element must conform to US2ValidatorUIProtocol protocol methods.
 At the moment the framework supports UITextField and UITextView by using US2ValidatorTextField
 and US2ValidatorTextView.
*/
@protocol US2ValidatorUIProtocol <UIAppearance, UIAppearanceContainer>

@required

/**
 @param validatorUIDelegate The validator UI delegate conforming US2ValidatorUIDelegate
 */
- (void)setValidatorUIDelegate:(id <US2ValidatorUIDelegate>)validatorUIDelegate;

/**
 Return the delegate
 
 @return Returns the validator UI delegate
 */
- (id <US2ValidatorUIDelegate>)validatorUIDelegate;

/**
 @param validator Validator to check the text of text UI conforming US2ValidatorUIProtocol
*/
- (void)setValidator:(US2Validator *)validator;

/**
 Set validator
*/
- (US2Validator *)validator;

/**
 Determines whether text inputs can be made either by violating the conditions.
 Is this parameter NO it overrides the 'shouldAllowViolation' parameter of 
 the conditions added to the validator. If set to YES the 'shouldAllowViolation'
 parameters of the conditions considered.
 
 @param shouldAllowViolation Boolean value
*/
- (void)setShouldAllowViolations:(BOOL)shouldAllowViolation;

/**
 Set boolean value
*/
- (BOOL)shouldAllowViolations;

/**
 Return whether the text is valid.
 
 @return Returns the valid state of the text field
*/
- (BOOL)isValid;

/**
 Determines whether the text has to be validated after leaving the text field
 or while editing. After a violation appeared after leaving the text field
 the text field will from now on validate while editing. Because the user
 knows now that a violation occurrs when using this text field.
 
 @param validateOnFocusLossOnly Boolean value
*/
- (void)setValidateOnFocusLossOnly:(BOOL)validateOnFocusLossOnly;

/**
 Set boolean value
*/
- (BOOL)validateOnFocusLossOnly;

/**
 @param text String to set as text to text UI
*/
- (void)setText:(NSString *)text;

/**
 Set string value
*/
- (NSString *)text;

/**
 @param frame Boundary to set as frame to text UI
*/
- (void)setFrame:(CGRect)frame;

/**
 Set CGRect value
*/
- (CGRect)frame;


@end
