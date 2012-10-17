//
//  US2ValidatorTextView.m
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

#import "US2ValidatorTextView.h"
#import "US2ValidatorTextViewPrivate.h"
#import "US2Condition.h"
#import "US2Validator.h"


@interface US2ValidatorTextView (private)
- (void)_startUp;
@end


@implementation US2ValidatorTextView


@synthesize validatorUIDelegate     = _validatorUIDelegate;
@synthesize validator               = _validator;
@synthesize shouldAllowViolations   = _shouldAllowViolations;
@synthesize validateOnFocusLossOnly = _validateOnFocusLossOnly;
@dynamic    isValid;


#pragma mark - Initialization

- (id)init
{
	self = [self initWithFrame: CGRectZero];
	if (self)
	{
	}
    
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self _startUp];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _startUp];
    }
    
    return self;
}


#pragma mark - Deinitialization

- (void)dealloc
{
    // Remove notification observer
    [[NSNotificationCenter defaultCenter] removeObserver:_validatorTextViewPrivate name:UITextViewTextDidEndEditingNotification object:self];
    
    [_validator release];    
    [_validatorTextViewPrivate release];
    
    [super dealloc];
}


#pragma mark - Start up

/**
 Set interested instance. The private class US2ValidatorTextViewPrivate will serve the delegate after validation.
*/
- (void)_startUp
{    
    // Allows violation initially
    _shouldAllowViolations = YES;
    
    // Validate immediately
    _validateOnFocusLossOnly = NO;
    
    // Create listening instance 
    _validatorTextViewPrivate = [[US2ValidatorTextViewPrivate alloc] init];
    _validatorTextViewPrivate.validatorTextView = self;
    self.delegate = (id)_validatorTextViewPrivate;
    
    // Listen for end of editing
    [[NSNotificationCenter defaultCenter] addObserver:_validatorTextViewPrivate selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

/**
 Set interested instance. The private class US2ValidatorTextViewPrivate will serve the delegate after validation.
 */
- (void)setValidatorUIDelegate:(id <US2ValidatorUIDelegate, UITextViewDelegate>)validatorUIDelegate
{
    _validatorTextViewPrivate.delegate = validatorUIDelegate;
}

- (id <US2ValidatorUIDelegate, UITextViewDelegate>)validatorUIDelegate
{
    return _validatorTextViewPrivate.delegate;
}

- (BOOL)isValid
{
    return [_validator checkConditions:self.text] == nil;
}

- (NSString *) validatableText {
    return self.text;
}

#pragma mark - Validator text view delegate delegate

/**
 After occurring violations the UI will be changed.
*/
- (void)validatorTextViewDelegate:(US2ValidatorTextViewPrivate *)textViewPrivate violatedConditions:(US2ConditionCollection *)conditions
{
}

/**
 After the text of the text field turns into valid the UI will be changed back.
*/
- (void)validatorTextViewDelegateSuccededConditions:(US2ValidatorTextViewPrivate *)textViewPrivate
{
}

@end
