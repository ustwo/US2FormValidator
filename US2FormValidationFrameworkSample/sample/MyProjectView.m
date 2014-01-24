//
//  MyProjectView.m
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
//  A simple test view containing sample validator text fields.
//  The kind validator of validator is set in the controller. 
//

#import "MyProjectView.h"
#import "MyProjectView_Private.h"
#import "MyProjectView+Layout.h"


@implementation MyProjectView


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self US2_buildUserInterface];
}


#pragma mark - Build user interface

- (void)US2_buildUserInterface
{
    [self US2_buildAboutSection];
    [self US2_buildEmailSection];
    [self US2_buildUKPostcodeSection];
    [self US2_buildSubmitButton];
    [self US2_buildLayout];
}


#pragma mark - About

- (void)US2_buildAboutSection
{
    [self US2_buildAboutHeadlineLabel];
    [self US2_buildAboutTextField];
    [self US2_buildAboutErrorLabel];
}

- (void)US2_buildAboutHeadlineLabel
{
    _aboutHeadlineLabel = [self US2_headlineLabel];
    _aboutHeadlineLabel.text = @"* About";
    [self.containerView addSubview:_aboutHeadlineLabel];
}

- (void)US2_buildAboutTextField
{
    _aboutTextField = [self US2_textField];
    _aboutTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    [self.containerView addSubview:_aboutTextField];
}

- (void)US2_buildAboutErrorLabel
{
    _aboutErrorLabel = [self US2_errorLabel];
    [self.containerView addSubview:_aboutErrorLabel];
}


#pragma mark - Email

- (void)US2_buildEmailSection
{
    [self US2_buildEmailHeadlineLabel];
    [self US2_buildEmailTextField];
    [self US2_buildEmailErrorLabel];
}

- (void)US2_buildEmailHeadlineLabel
{
    _emailHeadlineLabel = [self US2_headlineLabel];
    _emailHeadlineLabel.text = @"* Email";
    [self.containerView addSubview:_emailHeadlineLabel];
}

- (void)US2_buildEmailTextField
{
    _emailTextField = [self US2_textField];
    _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.containerView addSubview:_emailTextField];
}

- (void)US2_buildEmailErrorLabel
{
    _emailErrorLabel = [self US2_errorLabel];
    [self.containerView addSubview:_emailErrorLabel];
}


#pragma mark - UK Postcode

- (void)US2_buildUKPostcodeSection
{
    [self US2_buildUKPostcodeHeadlineLabel];
    [self US2_buildUKPostcodeTextField];
    [self US2_buildUKPostcodeErrorLabel];
}

- (void)US2_buildUKPostcodeHeadlineLabel
{
    _ukPostcodeHeadlineLabel = [self US2_headlineLabel];
    _ukPostcodeHeadlineLabel.text = @"* UK Postcode (e.g. E1 6JJ)";
    [self.containerView addSubview:_ukPostcodeHeadlineLabel];
}

- (void)US2_buildUKPostcodeTextField
{
    _ukPostcodeTextField = [self US2_textField];
    _ukPostcodeTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    _ukPostcodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.containerView addSubview:_ukPostcodeTextField];
}

- (void)US2_buildUKPostcodeErrorLabel
{
    _ukPostcodeErrorLabel = [self US2_errorLabel];
    [self.containerView addSubview:_ukPostcodeErrorLabel];
}


#pragma mark - Creators

- (UILabel *)US2_headlineLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
    label.textColor = [UIColor blackColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    return label;
}

- (MyProjectTextField *)US2_textField
{
    MyProjectTextField *textField = [[MyProjectTextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    return textField;
}

- (UILabel *)US2_errorLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = [UIColor redColor];
    label.numberOfLines = 0;
    
    return label;
}


#pragma mark - Submit button

- (void)US2_buildSubmitButton
{
    _submitButton = [MyProjectButton button];
    _submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:_submitButton];
}


@end
