//
//  MyProjectView+Layout.m
//  US2FormValidationFrameworkSample
//
//  Created by Martin on 14/01/2014.
//
//

#import "MyProjectView+Layout.h"
#import "MyProjectView_Private.h"

static const CGFloat kDefaultHeadlineLabelHeight    = 22.0;
static const CGFloat kDefaultErrorLabelHeight       = 22.0;
static const CGFloat kDefaultTextFieldHeight        = 44.0;
static const CGFloat kDefaultButtonHeight           = 44.0;
static const CGFloat kDefaultMargin                 = 12.0;


@implementation MyProjectView (Layout)

- (void)us2_buildLayout
{
    [self us2_buildAboutHeadlineLabelLayout];
    [self us2_buildAboutTextFieldLayout];
    [self us2_buildAboutErrorLabelLayout];

    [self us2_buildEmailHeadlineLabelLayout];
    [self us2_buildEmailTextFieldLayout];
    [self us2_buildEmailErrorLabelLayout];

    [self us2_buildUKPostcodeHeadlineLabelLayout];
    [self us2_buildUKPostcodeTextFieldLayout];
    [self us2_buildUKPostcodeErrorLabelLayout];

    [self us2_buildSubmitButtonLayout];
}


#pragma mark - About

- (void)us2_buildAboutHeadlineLabelLayout
{
    self.aboutHeadlineLabel.backgroundColor = [UIColor yellowColor];
    self.aboutTextField.backgroundColor = [UIColor redColor];
    self.aboutErrorLabel.backgroundColor = [UIColor greenColor];
    
    [self us2_setToFullWidth:self.aboutHeadlineLabel];
    [self us2_setView:self.aboutHeadlineLabel toExactHeight:kDefaultHeadlineLabelHeight];
    [self us2_setViewToTop:self.aboutHeadlineLabel];
}

- (void)us2_buildAboutTextFieldLayout
{
    [self us2_setToFullWidth:self.aboutTextField];
    [self us2_setView:self.aboutTextField toExactHeight:kDefaultTextFieldHeight];
    [self us2_setView:self.aboutTextField underView:self.aboutHeadlineLabel withMargin:0.0];
}

- (void)us2_buildAboutErrorLabelLayout
{
    [self us2_setToFullWidth:self.aboutErrorLabel];
    [self us2_setView:self.aboutErrorLabel toMaximumHeight:kDefaultErrorLabelHeight];
    [self us2_setView:self.aboutErrorLabel underView:self.aboutTextField withMargin:0.0];
}


#pragma mark - Email

- (void)us2_buildEmailHeadlineLabelLayout
{
    self.emailHeadlineLabel.backgroundColor = [UIColor yellowColor];
    self.emailTextField.backgroundColor = [UIColor redColor];
    self.emailErrorLabel.backgroundColor = [UIColor greenColor];
    
    [self us2_setToFullWidth:self.emailHeadlineLabel];
    [self us2_setView:self.emailHeadlineLabel toExactHeight:kDefaultHeadlineLabelHeight];
    [self us2_setView:self.emailHeadlineLabel underView:self.aboutErrorLabel withMargin:kDefaultMargin];
}

- (void)us2_buildEmailTextFieldLayout
{
    [self us2_setToFullWidth:self.emailTextField];
    [self us2_setView:self.emailTextField toExactHeight:kDefaultTextFieldHeight];
    [self us2_setView:self.emailTextField underView:self.emailHeadlineLabel withMargin:0.0];
}

- (void)us2_buildEmailErrorLabelLayout
{
    [self us2_setToFullWidth:self.emailErrorLabel];
    [self us2_setView:self.emailErrorLabel toMaximumHeight:kDefaultErrorLabelHeight];
    [self us2_setView:self.emailErrorLabel underView:self.emailTextField withMargin:0.0];
}


#pragma mark - UK Postcode

- (void)us2_buildUKPostcodeHeadlineLabelLayout
{
    [self us2_setToFullWidth:self.ukPostcodeHeadlineLabel];
    [self us2_setView:self.ukPostcodeHeadlineLabel toExactHeight:kDefaultHeadlineLabelHeight];
    [self us2_setView:self.ukPostcodeHeadlineLabel underView:self.emailErrorLabel withMargin:kDefaultMargin];
}

- (void)us2_buildUKPostcodeTextFieldLayout
{
    [self us2_setToFullWidth:self.ukPostcodeTextField];
    [self us2_setView:self.ukPostcodeTextField toExactHeight:kDefaultTextFieldHeight];
    [self us2_setView:self.ukPostcodeTextField underView:self.ukPostcodeHeadlineLabel withMargin:0.0];
}

- (void)us2_buildUKPostcodeErrorLabelLayout
{
    [self us2_setToFullWidth:self.ukPostcodeErrorLabel];
    [self us2_setView:self.ukPostcodeErrorLabel toMaximumHeight:kDefaultErrorLabelHeight];
    [self us2_setView:self.ukPostcodeErrorLabel underView:self.ukPostcodeTextField withMargin:0.0];
}


#pragma mark - Submit button

- (void)us2_buildSubmitButtonLayout
{
    [self us2_setToFullWidth:self.submitButton];
    [self us2_setView:self.submitButton toExactHeight:kDefaultButtonHeight];
    [self us2_setView:self.submitButton underView:self.ukPostcodeErrorLabel withMargin:kDefaultMargin];
    [self us2_setViewToBottom:self.submitButton];
}


#pragma mark - Layout helpers

- (void)us2_setViewToTop:(UIView *)view
{
    NSString *formatString = @"V:|-28-[view]";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self.containerView addConstraints:constraints];
}

- (void)us2_setViewToBottom:(UIView *)view
{
    NSString *formatString = @"V:[view]-48-|";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self.containerView addConstraints:constraints];
}

- (void)us2_setToFullWidth:(UIView *)view
{
    NSString *formatString = @"H:|-[view]-|";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self.containerView addConstraints:constraints];
}

- (void)us2_setToFullHeight:(UIView *)view
{
    NSString *formatString = @"V:|-[view]-|";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self.containerView addConstraints:constraints];
}

- (void)us2_setView:(UIView *)view toExactHeight:(CGFloat)height
{
    NSString *formatString = @"V:[view(==toHeight)]";
    NSNumber *toHeight = @(height);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:NSDictionaryOfVariableBindings(toHeight)
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self.containerView addConstraints:constraints];
}

- (void)us2_setView:(UIView *)view toMaximumHeight:(CGFloat)height
{
    NSString *formatString = @"V:[view(<=999)]";
    NSNumber *toHeight = @(height);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:NSDictionaryOfVariableBindings(toHeight)
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self.containerView addConstraints:constraints];
}

- (void)us2_setView:(UIView *)view1 underView:(UIView *)view2 withMargin:(CGFloat)margin
{
    NSString *formatString = @"V:[view2]-toMargin-[view1]";
    NSNumber *toMargin = @(margin);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:NSDictionaryOfVariableBindings(toMargin)
                                                                     views:NSDictionaryOfVariableBindings(view2, view1)];
    [self.containerView addConstraints:constraints];
}

@end
