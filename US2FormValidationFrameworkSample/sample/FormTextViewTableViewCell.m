//
//  FormTextViewTableViewCell.m
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

#import "FormTextViewTableViewCell.h"
#import "FormTableViewCellPrivate.h"


static const float kFormTextViewX = 102.0;


@implementation FormTextViewTableViewCell


@dynamic textView;


/**
 Fit dimension of text field and align UI
*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (nil != _textUI)
    {
        // Set dimension of text field
        _textUI.frame = CGRectMake(kFormTextViewX, 0.0, self.contentView.frame.size.width - kFormTextViewX - 40.0, self.contentView.frame.size.height);
        ((US2ValidatorTextView *)_textUI).font  = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
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

- (void)setTextView:(US2ValidatorTextView *)textView
{
    self.textUI = textView;
}

- (US2ValidatorTextView *)textView
{
    return (US2ValidatorTextView *)self.textUI;
}


@end
