//
//  US2ValidatorTextFieldPrivate.h
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
#import "US2ValidatorDelegate.h"
#import "US2ValidatorUIProtocol.h"

@class US2ValidatorTextField;


#pragma mark - Validator private text field interface

/**
 US2ValidatorTextFieldPrivate is a private class within US2ValidatorTextField
 and calls the set validator. The result of the validator will be checked and
 forwarded to the origin delegate and US2ValidatorTextField.
 This private class is needed because the US2ValidatorTextField should not listen
 for itself.
*/
@interface US2ValidatorTextFieldPrivate : NSObject <UITextFieldDelegate>
{
    BOOL _lastCheckWasValid;
    BOOL _didEndEditing;
}

/**
 Origin delegate which was set through US2ValidatorTextField and will
 be served by this private class US2ValidatorTextFieldPrivate.
*/
@property (nonatomic, weak) id <US2ValidatorDelegate, UITextFieldDelegate> delegate;

/**
 Represents the main validation text field which wants to know what went
 wrong when validating in this private class US2ValidatorTextFieldPrivate.
 Thus the validation text field is able to change its appearance e.g..
*/
@property (nonatomic, weak) US2ValidatorTextField *validatorTextField;


@end
