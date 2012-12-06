//
//  US2ValidatorTextView.h
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

#import <Foundation/Foundation.h>
#import "US2ValidatorTextViewPrivateDelegate.h"
#import "US2ValidatorUIDelegate.h"
#import "US2ValidatorUIProtocol.h"
#import "US2Validatable.h"

@protocol US2ValidatorUIDelegate;

@class US2Validator;
@class US2ValidatorTextViewPrivate;


#pragma mark - Validator text view interface

/**
 The validator text view is the central object to use. It inherits UITextView and listens internally
 to all own changes. After every change it validates the changed text material. When a validator, which
 was added to the validator text view, reports a violation the validatorTextViewDelegate will be 
 served with this information. The validatorTextViewDelegate is of type US2ValidatorTextViewDelegate
 and returns what went wrong and in which status the validation text field is at the moment.
*/
@interface US2ValidatorTextView : UITextView <US2ValidatorUIProtocol, US2ValidatorTextViewPrivateDelegate, US2Validatable>
{
@private
    id <US2ValidatorUIDelegate, UITextViewDelegate> _validatorUIDelegate;
    US2Validator                                    *_validator;
    US2ValidatorTextViewPrivate                     *_validatorTextViewPrivate;
    BOOL                                            _shouldAllowViolation;
    BOOL                                            _validateOnFocusLossOnly;
}

/**
 Set delegate implementing US2ValidatorUIDelegate
 */
@property (nonatomic, assign) id <US2ValidatorUIDelegate, UITextViewDelegate> validatorUIDelegate;

/**
 Set the validator to check the text of the text field with
*/
@property (nonatomic, retain) US2Validator *validator;

/**
 Determines whether text inputs can be made either by violating the conditions.
 Is this parameter NO it overrides the 'shouldAllowViolation' parameter of 
 the conditions added to the validator. If set to YES the 'shouldAllowViolation'
 parameters of the conditions considered.
*/
@property (nonatomic, assign) BOOL shouldAllowViolations;

/**
 Return whether the text is valid.
 *
 @return Returns the valid state of the text field
*/
@property (nonatomic, assign, readonly) BOOL isValid;

/**
 Determines whether the text has to be validated after leaving the text field
 or while editing. After a violation appeared after leaving the text field
 the text field will from now on validate while editing. Because the user
 knows now that a violation occurrs when using this text field.
*/
@property (nonatomic, assign) BOOL validateOnFocusLossOnly;

/**
 Text for validation
 */
- (NSString *) validatableText;

@end
