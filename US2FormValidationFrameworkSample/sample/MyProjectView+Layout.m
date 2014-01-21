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

- (void)US2_buildLayout
{
    [self US2_buildAboutHeadlineLabelLayout];
    [self US2_buildAboutTextFieldLayout];
    [self US2_buildAboutErrorLabelLayout];
    
    [self US2_buildEmailHeadlineLabelLayout];
    [self US2_buildEmailTextFieldLayout];
    [self US2_buildEmailErrorLabelLayout];
    
    [self US2_buildUKPostcodeHeadlineLabelLayout];
    [self US2_buildUKPostcodeTextFieldLayout];
    [self US2_buildUKPostcodeErrorLabelLayout];
    
    [self US2_buildSubmitButtonLayout];
}


#pragma mark - About

- (void)US2_buildAboutHeadlineLabelLayout
{
    [self US2_setToFullWidth:_aboutHeadlineLabel];
    [self US2_setView:_aboutHeadlineLabel toExactHeight:kDefaultHeadlineLabelHeight];
    [self US2_setViewToTop:_aboutHeadlineLabel];
}

- (void)US2_buildAboutTextFieldLayout
{
    [self US2_setToFullWidth:self.aboutTextField];
    [self US2_setView:self.aboutTextField toExactHeight:kDefaultTextFieldHeight];
    [self US2_setView:self.aboutTextField underView:_aboutHeadlineLabel withMargin:0.0];
}

- (void)US2_buildAboutErrorLabelLayout
{
    [self US2_setToFullWidth:self.aboutErrorLabel];
    [self US2_setView:self.aboutErrorLabel toMaximumHeight:kDefaultErrorLabelHeight];
    [self US2_setView:self.aboutErrorLabel underView:self.aboutTextField withMargin:0.0];
}


#pragma mark - Email

- (void)US2_buildEmailHeadlineLabelLayout
{
    [self US2_setToFullWidth:_emailHeadlineLabel];
    [self US2_setView:_emailHeadlineLabel toExactHeight:kDefaultHeadlineLabelHeight];
    [self US2_setView:_emailHeadlineLabel underView:self.aboutErrorLabel withMargin:kDefaultMargin];
}

- (void)US2_buildEmailTextFieldLayout
{
    [self US2_setToFullWidth:self.emailTextField];
    [self US2_setView:self.emailTextField toExactHeight:kDefaultTextFieldHeight];
    [self US2_setView:self.emailTextField underView:_emailHeadlineLabel withMargin:0.0];
}

- (void)US2_buildEmailErrorLabelLayout
{
    [self US2_setToFullWidth:self.emailErrorLabel];
    [self US2_setView:self.emailErrorLabel toMaximumHeight:kDefaultErrorLabelHeight];
    [self US2_setView:self.emailErrorLabel underView:self.emailTextField withMargin:0.0];
}


#pragma mark - UK Postcode

- (void)US2_buildUKPostcodeHeadlineLabelLayout
{
    [self US2_setToFullWidth:_ukPostcodeHeadlineLabel];
    [self US2_setView:_ukPostcodeHeadlineLabel toExactHeight:kDefaultHeadlineLabelHeight];
    [self US2_setView:_ukPostcodeHeadlineLabel underView:self.emailErrorLabel withMargin:kDefaultMargin];
}

- (void)US2_buildUKPostcodeTextFieldLayout
{
    [self US2_setToFullWidth:self.ukPostcodeTextField];
    [self US2_setView:self.ukPostcodeTextField toExactHeight:kDefaultTextFieldHeight];
    [self US2_setView:self.ukPostcodeTextField underView:_ukPostcodeHeadlineLabel withMargin:0.0];
}

- (void)US2_buildUKPostcodeErrorLabelLayout
{
    [self US2_setToFullWidth:self.ukPostcodeErrorLabel];
    [self US2_setView:self.ukPostcodeErrorLabel toMaximumHeight:kDefaultErrorLabelHeight];
    [self US2_setView:self.ukPostcodeErrorLabel underView:self.ukPostcodeTextField withMargin:0.0];
}


#pragma mark - Submit button

- (void)US2_buildSubmitButtonLayout
{
    [self US2_setToFullWidth:self.submitButton];
    [self US2_setView:self.submitButton toExactHeight:kDefaultButtonHeight];
    [self US2_setView:self.submitButton underView:self.ukPostcodeErrorLabel withMargin:kDefaultMargin];
}



- (void)US2_setViewToTop:(UIView *)view
{
    NSString *formatString = @"V:|-28-[view]";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self addConstraints:constraints];
}

- (void)US2_setToFullWidth:(UIView *)view
{
    NSString *formatString = @"H:|-[view]-|";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self addConstraints:constraints];
}

- (void)US2_setView:(UIView *)view toExactHeight:(CGFloat)height
{
    NSString *formatString = @"V:[view(==toHeight)]";
    NSNumber *toHeight = @(height);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:NSDictionaryOfVariableBindings(toHeight)
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self addConstraints:constraints];
}

- (void)US2_setView:(UIView *)view toMaximumHeight:(CGFloat)height
{
    NSString *formatString = @"V:[view(<=999)]";
    NSNumber *toHeight = @(height);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:NSDictionaryOfVariableBindings(toHeight)
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [self addConstraints:constraints];
}

- (void)US2_setView:(UIView *)view1 underView:(UIView *)view2 withMargin:(CGFloat)margin
{
    NSString *formatString = @"V:[view2]-toMargin-[view1]";
    NSNumber *toMargin = @(margin);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                   options:0
                                                                   metrics:NSDictionaryOfVariableBindings(toMargin)
                                                                     views:NSDictionaryOfVariableBindings(view2, view1)];
    [self addConstraints:constraints];
}

@end
