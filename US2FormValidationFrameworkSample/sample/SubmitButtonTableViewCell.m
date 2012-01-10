//
//  SubmitButtonTableViewCell.m
//  US2FormValidationFramework
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

#import "SubmitButtonTableViewCell.h"


@interface SubmitButtonTableViewCell ()
- (void)_initUserInterface;

@end


@implementation SubmitButtonTableViewCell


@synthesize button = _button;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self _initUserInterface];
    }
    
    return self;
}


#pragma mark - Build user interface

- (void)_initUserInterface
{    
    // Add button
    CGRect buttonFrame = CGRectMake(0.0, 0.0, 300.0, self.bounds.size.height);
    _button            = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _button.frame      = buttonFrame;
    [_button setTitle:@"Submit" forState:UIControlStateNormal];
    [self.contentView addSubview:_button];

    // Set selection style of cell
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Remove background
    self.backgroundView = [[[UIView alloc] init] autorelease];
}


#pragma mark - Selection

/**
 Do not show any selection animation, so no super call here.
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //
}

/**
 Do not show any highlight animation, so no super call here.
*/
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    //
}


@end
