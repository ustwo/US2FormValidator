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
    
    [self us2_buildUserInterface];
}


#pragma mark - Build user interface

- (void)us2_buildUserInterface
{
    [self us2_buildAboutSection];
    [self us2_buildEmailSection];
    [self us2_buildUKPostcodeSection];
    [self us2_buildSubmitButton];
    [self us2_buildLayout];
}


#pragma mark - About

- (void)us2_buildAboutSection
{
    [self us2_buildAboutHeadlineLabel];
    [self us2_buildAboutTextField];
    [self us2_buildAboutErrorLabel];
}

- (void)us2_buildAboutHeadlineLabel
{
    _aboutHeadlineLabel = [self us2_headlineLabel];
    _aboutHeadlineLabel.text = @"* About";
    [self.containerView addSubview:_aboutHeadlineLabel];
}

- (void)us2_buildAboutTextField
{
    _aboutTextField = [self us2_textField];
    _aboutTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    [self.containerView addSubview:_aboutTextField];
}

- (void)us2_buildAboutErrorLabel
{
    _aboutErrorLabel = [self us2_errorLabel];
    [self.containerView addSubview:_aboutErrorLabel];
}


#pragma mark - Email

- (void)us2_buildEmailSection
{
    [self us2_buildEmailHeadlineLabel];
    [self us2_buildEmailTextField];
    [self us2_buildEmailErrorLabel];
}

- (void)us2_buildEmailHeadlineLabel
{
    _emailHeadlineLabel = [self us2_headlineLabel];
    _emailHeadlineLabel.text = @"* Email";
    [self.containerView addSubview:_emailHeadlineLabel];
}

- (void)us2_buildEmailTextField
{
    _emailTextField = [self us2_textField];
    _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.containerView addSubview:_emailTextField];
}

- (void)us2_buildEmailErrorLabel
{
    _emailErrorLabel = [self us2_errorLabel];
    [self.containerView addSubview:_emailErrorLabel];
}


#pragma mark - UK Postcode

- (void)us2_buildUKPostcodeSection
{
    [self us2_buildUKPostcodeHeadlineLabel];
    [self us2_buildUKPostcodeTextField];
    [self us2_buildUKPostcodeErrorLabel];
}

- (void)us2_buildUKPostcodeHeadlineLabel
{
    _ukPostcodeHeadlineLabel = [self us2_headlineLabel];
    _ukPostcodeHeadlineLabel.text = @"* UK Postcode (e.g. E1 6JJ)";
    [self.containerView addSubview:_ukPostcodeHeadlineLabel];
}

- (void)us2_buildUKPostcodeTextField
{
    _ukPostcodeTextField = [self us2_textField];
    _ukPostcodeTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    _ukPostcodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.containerView addSubview:_ukPostcodeTextField];
}

- (void)us2_buildUKPostcodeErrorLabel
{
    _ukPostcodeErrorLabel = [self us2_errorLabel];
    [self.containerView addSubview:_ukPostcodeErrorLabel];
}


#pragma mark - Creators

- (UILabel *)us2_headlineLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
    label.textColor = [UIColor blackColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    return label;
}

- (MyProjectTextField *)us2_textField
{
    MyProjectTextField *textField = [[MyProjectTextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    return textField;
}

- (UILabel *)us2_errorLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = [UIColor redColor];
    label.numberOfLines = 0;
    
    return label;
}


#pragma mark - Submit button

- (void)us2_buildSubmitButton
{
    _submitButton = [MyProjectButton button];
    _submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:_submitButton];
}


@end
