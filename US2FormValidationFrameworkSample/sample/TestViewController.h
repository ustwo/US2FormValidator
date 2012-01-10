//
//  TestViewController.h
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
//  A simple test view controller which creates a test view with some
//  sample validation text fields on it.
//  This controller sets the properties of all created validator text fields.
//  When text inputs are violating the configured conditions (US2Condition)
//  the delegate instance will receive this information.
//

#import "TestView.h"
#import "TooltipView.h"
#import "FormTableViewCell.h"
#import "US2ValidatorUIDelegate.h"
#import "US2ValidatorUIProtocol.h"


@interface TestViewController : UIViewController <US2ValidatorUIDelegate,
                                                  UITextFieldDelegate,
                                                  UITextViewDelegate,
                                                  FormTableViewCellDelegate,
                                                  UITableViewDelegate,
                                                  UITableViewDataSource>
{
@private
    NSMutableArray *_textUICollection;
    NSMutableArray *_typeStringCollection;
    
    TooltipView    *_tooltipView;
    id <US2ValidatorUIProtocol> _tooltipConnectedTextUI;
    
    BOOL           _didSubmit;
}

@property (nonatomic, retain, readonly) TestView *testView;


@end
