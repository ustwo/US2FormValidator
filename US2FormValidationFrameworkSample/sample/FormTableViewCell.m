//
//  FormTableViewCell.m
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

#import "FormTableViewCell.h"
#import "FormTableViewCellPrivate.h"


const CGRect kIconButtonFrame = {{0.0, 0.0}, {44.0, 44.0}};


@implementation FormTableViewCell


@synthesize delegate = _delegate;
@dynamic    textUI;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self _initUserInterface];
    }
    
    return self;
}

- (void)dealloc
{    
    [self _removeTextUI];
    
    [super dealloc];
}


#pragma mark - Build user interface

- (void)_initUserInterface
{
    // Add icon button
    CGRect iconButtonFrame = kIconButtonFrame;
    _iconButton            = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconButton.frame      = iconButtonFrame;
    [_iconButton addTarget:self action:@selector(iconButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_iconButton];
    
    // Set waiting icon to cell
    self.icon = [UIImage imageNamed:@"image_icon_validation_waiting.png"];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - Update user interface

- (void)_updateUserInterface
{
    // Set icon
    if (_hasToUpdateIcon)
    {
        [_iconButton setImage:_icon forState:UIControlStateNormal];
    }
}


#pragma mark - Selection

/**
 Activate the text field within cell when touching on cell.
 Do not show any selection animation, so no super call here.
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected)
    {
        // Select text field
        if (nil != _textUI)
        {
            [((UIView *)_textUI) becomeFirstResponder];
        }
    }
}

/**
 Do not show any highlight animation, so no super call here.
*/
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    //
}


#pragma mark - Validation text UI

/**
 Remove text field from cell
*/
- (void)_removeTextUI
{
    if (nil != _textUI)
    {
        [((UIView *)_textUI) removeFromSuperview];
        _textUI = nil;
    }
}

/**
 Add text field to cell
*/
- (void)_addTextUI
{
    ((UIView *)_textUI).backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:((UIView *)_textUI)];
    [_textUI release];
}

/**
 The text field UI will be set from outside and added to the cell
*/
- (void)setTextUI:(id <US2ValidatorUIProtocol>)textUI
{
    [self _removeTextUI];
    
    _textUI = [textUI retain];
    
    [self _addTextUI];
    
    kFormTableViewCellStatus status = _textUI.isValid == YES ? kFormTableViewCellStatusValid : kFormTableViewCellStatusInvalid;
    status = _textUI.text.length == 0 ? kFormTableViewCellStatusWaiting : status;
    [self updateValidationIconByValidStatus:status];
    
    [self setNeedsDisplay];
}

/**
 Return the set text field
*/
- (id <US2ValidatorUIProtocol>)textUI
{
    return _textUI;
}


#pragma mark - Icon

- (void)setIcon:(UIImage *)image
{
    [_icon release];
    _icon = [image retain];
    
    _hasToUpdateIcon = YES;
    [self _updateUserInterface];
}

- (UIImage *)icon
{
    return _icon;
}

- (void)updateValidationIconByValidStatus:(kFormTableViewCellStatus)status
{
    // Set validation status icon to cell
    UIImage *icon = nil;
    switch (status)
    {
        case kFormTableViewCellStatusValid:
        {
            icon = [UIImage imageNamed:@"image_icon_validation_valid.png"];
            break;
        }
        case kFormTableViewCellStatusWaiting:
        {
            icon = [UIImage imageNamed:@"image_icon_validation_waiting.png"];
            break;
        }
        case kFormTableViewCellStatusInvalid:
        {
            icon = [UIImage imageNamed:@"image_icon_validation_invalid.png"];
            break;
        }
    }
    
    self.icon = icon;
}


#pragma mark - Icon button

- (void)iconButtonTouched:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(formTableViewCell:touchedIconButton:aligningTextUI:)])
    {
        [_delegate formTableViewCell:self touchedIconButton:_iconButton aligningTextUI:_textUI];
    }
}


@end
