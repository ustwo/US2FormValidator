//
//  FormTextFieldTableViewCell.m
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

#import "FormTextFieldTableViewCell.h"
#import "FormTableViewCellPrivate.h"
#import "US2ValidatorTextField.h"


static const float  kFormTextFieldX  = 110.0;


@implementation FormTextFieldTableViewCell

@dynamic textField;

/**
 Fit dimension of text field and align UI
*/
- (void)layoutSubviews
{    
    [super layoutSubviews];
    
    if (nil != _textUI)
    {
        // Collapse text field height to content
        CGSize size = [@"#" sizeWithFont:((US2ValidatorTextField *)_textUI).font
                       constrainedToSize:CGSizeMake(UINT16_MAX, UINT16_MAX)
                           lineBreakMode:UILineBreakModeClip];
        
        // Set dimension of text field
        CGFloat verticalCenter = round((self.contentView.frame.size.height - size.height) / 2.0);
        _textUI.frame = CGRectMake(kFormTextFieldX, verticalCenter, self.contentView.frame.size.width - kFormTextFieldX - 40.0, size.height);
        
        ((US2ValidatorTextField *)_textUI).font  = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    }
    
    if (nil != _iconButton)
    {
        _iconButton.frame = CGRectMake(self.contentView.frame.size.width - 42.0,
                                       round((self.contentView.frame.size.height - kIconButtonFrame.size.height) / 2.0),
                                       kIconButtonFrame.size.width,
                                       kIconButtonFrame.size.height);
    }
}


#pragma mark - Validation text field

- (void)setTextField:(US2ValidatorTextField *)textField
{
    self.textUI = textField;
}

- (US2ValidatorTextField *)textField
{
    return (US2ValidatorTextField *)self.textUI;
}


@end
