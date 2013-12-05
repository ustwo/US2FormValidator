//
//  US2ValidatableDelegate.h
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

@protocol US2Validatable;

@class US2ConditionCollection;


#pragma mark - Validator UI delegate

/**
 The main delegate protocol which serves the interested instance with information about changed validation states.
 The delegate inherits from UITextViewDelegate.
 */
@protocol US2ValidatableDelegate
@optional

/**
 Will be called when the text in the text field changes. Has its origin in listening for UITextFieldTextDidChangeNotification.
 
 @param validatorUI Instance of the sending validator text UI of type US2ValidatorTextField
 */
- (void)validatableDidChange:(id<US2Validatable>)validatable;

/**
 Will be called when a status changes from true to false or false to true.
 
 @param validatorTextView Instance of the sending validator text field of type US2ValidatorTextView
 @param isValid Returns the status of the validation check
 */
- (void)validatable:(id<US2Validatable>)validatable changedValidState:(BOOL)isValid;

/**
 Will be called if the text field check failed.
 
 @param validatorTextView Instance of the sending validator text field of type US2ValidatorTextView
 @param conditions Collection of type US2ConditionCollection listing all violated conditions.
 */
- (void)validatable:(id<US2Validatable>)validatable violatedConditions:(US2ConditionCollection *)conditions;


@end
