//
//  FormTableViewCell.h
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

#import <UIKit/UIKit.h>
#import "US2Validatable.h"


extern const CGRect kIconButtonFrame;


@protocol FormTableViewCellDelegate;


#pragma mark - Enumeration

enum
{
    kFormTableViewCellStatusValid,
    kFormTableViewCellStatusWaiting,
    kFormTableViewCellStatusInvalid
}
typedef kFormTableViewCellStatus;


#pragma mark - Form table view cell interface

@interface FormTableViewCell : UITableViewCell
{
@protected
    id<US2Validatable>             _validatable;
    UIImage                        *_icon;
    UIButton                       *_iconButton;
    BOOL                           _hasToUpdateIcon;
}

@property (nonatomic, weak) id <FormTableViewCellDelegate> delegate;
@property (nonatomic, strong) id<US2Validatable> validatable;
@property (nonatomic, strong) UIImage *icon;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)updateValidationIconByValidStatus:(kFormTableViewCellStatus)status;

@end


#pragma mark - Form table view cell protocol

@protocol FormTableViewCellDelegate <NSObject>

@optional
- (void)formTableViewCell:(FormTableViewCell *)cell touchedIconButton:(UIButton *)button aligningValidatable:(id<US2Validatable>)validatable;

@end