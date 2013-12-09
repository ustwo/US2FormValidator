//
//  TestViewController.m
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

#import "US2FormValidator.h"

#import "TestViewController.h"
#import "MyProjectValidatorName.h"
#import "MyProjectValidatorAbout.h"
#import "FormTextFieldTableViewCell.h"
#import "FormTextViewTableViewCell.h"
#import "ValidTooltipView.h"
#import "InvalidTooltipView.h"
#import "SubmitButtonTableViewCell.h"


@interface TestViewController () <US2ValidatorTextFieldDelegate,
                                  US2ValidatorTextViewDelegate,
                                  FormTableViewCellDelegate,
                                  UITableViewDelegate,
                                  UITableViewDataSource>
{
    NSMutableArray *_typeStringCollection;
    TooltipView    *_tooltipView;
    BOOL           _didSubmit;
    
    id<US2Validatable> _tooltipConnectedValidatable;
    
    US2ValidatorForm *_form;
}
@end


@implementation TestViewController


#pragma mark - View setter and getter

- (void)setTestView:(TestView *)view
{
    self.view = view;
}

- (TestView *)testView
{
    return (TestView *)self.view;
}


#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    [self buildView];
}

/**
 Build custom view with test validator text fields added
*/
- (void)buildView
{
    self.testView = [[TestView alloc] initWithFrame:self.view.frame];
}

/**
 Initialize the UI components after view did load
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self initUserInterface];
}


#pragma mark - Initialize data

- (void)initData
{
    // Flag whether 'submit' button was touched to validate every text UI
    _didSubmit = NO;
    
    // Set type string for every form item
    _typeStringCollection = [[NSMutableArray alloc] init];
    [_typeStringCollection addObject:@"US2 Class"];
    [_typeStringCollection addObject:@"Post Code"];
    [_typeStringCollection addObject:@"About"];
    
//    _validatableCollection = [[NSMutableArray alloc] init];
    
    [self createForm];
    
    // Set text fields which will be used in form
    [self createUS2ClassNameField];
    [self createPostcodeField];
    [self createAboutTextField];
}

- (void)createForm
{
    _form = [[US2ValidatorForm alloc] init];
    
    [_form setDidChangeValidState:^(BOOL isValid) {
        
        NSLog(@"form's state changed to: %@", (isValid ? @"YES" : @"NO"));
    }];
}

- (void)createUS2ClassNameField
{
    NSString *classPrefix = @"US2";
    
    US2ConditionRange *rangeCondition = [US2ConditionRange condition];
    rangeCondition.range = US2TextRangeMake(classPrefix.length, 256);
    rangeCondition.shouldAllowViolation = NO;
    
    US2Validator *classNameValidator = [[US2Validator alloc] initWithCondition:rangeCondition];
    
    US2ValidatorTextField *classNameTextField  = [[US2ValidatorTextField alloc] init];
    classNameTextField.validator               = classNameValidator;
    classNameTextField.delegate                = self;
    classNameTextField.validateOnFocusLossOnly = NO;
    classNameTextField.text                    = classPrefix;
    classNameTextField.placeholder             = @"US2 Class Name";
    [_form addValidatable:classNameTextField];
}

- (void)createPostcodeField
{
    US2ConditionPostcodeUK *ukPostcodeCondition = [US2ConditionPostcodeUK condition];
    US2Validator *validator = [[US2Validator alloc] initWithCondition:ukPostcodeCondition];
    
    US2ValidatorTextField *postcodeTextField  = [[US2ValidatorTextField alloc] init];
    postcodeTextField.validator               = validator;
    postcodeTextField.delegate                = self;
    postcodeTextField.validateOnFocusLossOnly = YES;
    postcodeTextField.text                    = @"";
    postcodeTextField.placeholder             = @"Postcode";
    postcodeTextField.autocapitalizationType  = UITextAutocapitalizationTypeAllCharacters;
    [_form addValidatable:postcodeTextField];
}

- (void)createAboutTextField
{
    US2ConditionPresent *presentCondition = [US2ConditionPresent condition];
    US2Validator *validator = [[US2Validator alloc] initWithCondition:presentCondition];
    
    US2ValidatorTextView *aboutTextView   = [[US2ValidatorTextView alloc] init];
    aboutTextView.validator               = validator;
    aboutTextView.delegate                = self;
    aboutTextView.validateOnFocusLossOnly = YES;
    [_form addValidatable:aboutTextView];
}


#pragma mark - Initialization of view

/**
 Initialize the UI and register interest for some changes
*/
- (void)initUserInterface
{
    // Serve table view delegate
    self.testView.tableView.delegate   = self;
    self.testView.tableView.dataSource = self;
}


#pragma mark - Validator text field protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Hide tooltip 
    if (nil != _tooltipView
        && ![_tooltipConnectedValidatable isEqual:textField])
    {
        [_tooltipView removeFromSuperview];
        _tooltipView = nil;
    }
    
    _tooltipConnectedValidatable = nil;
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // Hide tooltip 
    if (nil != _tooltipView
        && ![_tooltipConnectedValidatable isEqual:textView])
    {
        [_tooltipView removeFromSuperview];
        _tooltipView = nil;
    }
    
    _tooltipConnectedValidatable = nil;
    
    return YES;
}

/**
 Called for every valid or violated state change
 React to this information by showing up warnings or disabling a 'send' button e.g.
*/
- (void)validatable:(id<US2Validatable>)validatable changedValidState:(BOOL)isValid
{
    NSLog(@"validatorUI changedValidState: %d", isValid);
    
    // 1st super view UITableViewCellContentView
    // 2nd super view FormTextFieldTableViewCell
    id cell = ((UIView *)validatable).superview.superview;
    if ([cell isKindOfClass:[FormTableViewCell class]])
    {
        FormTableViewCell *formTableViewCell = (FormTableViewCell *)cell;
        kFormTableViewCellStatus status = isValid == YES ? kFormTableViewCellStatusValid : kFormTableViewCellStatusInvalid;
        status = validatable.text.length == 0 ? kFormTableViewCellStatusWaiting : status;
        [formTableViewCell updateValidationIconByValidStatus:status];
    }
    
    // Hide tooltip 
    if (isValid)
    {
        [self dismissTooltip];
    }
}

/**
 Called on every violation of the highest prioritised validator condition.
 Update UI like showing alert messages or disabling buttons.
*/
- (void)validatable:(id<US2Validatable>)validatable violatedConditions:(US2ConditionCollection *)conditions
{
    NSLog(@"validatorUI violatedConditions: \n%@", conditions);
}

/**
 Update violation status of text field after ending editing
*/
- (void)textFieldDidEndEditing:(US2ValidatorTextField *)validatorTextField
{
    id cell = validatorTextField.superview.superview;
    if ([cell isKindOfClass:[FormTextFieldTableViewCell class]])
    {
        FormTextFieldTableViewCell *formTextFieldTableViewCell = (FormTextFieldTableViewCell *)cell;
        kFormTableViewCellStatus status = validatorTextField.isValid == YES ? kFormTableViewCellStatusValid : kFormTableViewCellStatusInvalid;
        
        if (_didSubmit == NO)
        {
            status = validatorTextField.text.length == 0 ? kFormTableViewCellStatusWaiting : status;
        }
        
        [formTextFieldTableViewCell updateValidationIconByValidStatus:status];
    }
}

/**
 Update violation status of text view after ending editing
*/
- (void)textViewDidEndEditing:(US2ValidatorTextView *)validatorTextView
{
    id cell = validatorTextView.superview.superview;
    if ([cell isKindOfClass:[FormTableViewCell class]])
    {
        FormTableViewCell *formTableViewCell = (FormTableViewCell *)cell;
        kFormTableViewCellStatus status = validatorTextView.isValid == YES ? kFormTableViewCellStatusValid : kFormTableViewCellStatusInvalid;
        
        // If form was submitted once the waiting status is obsolete,
        // the user knows that the text UI is invalid or valid, so
        // the text UI is not 'waiting' for input, because submit button
        // was the 'input'
        if (_didSubmit == NO)
        {
            status = validatorTextView.text.length == 0 ? kFormTableViewCellStatusWaiting : status;
        }
        
        [formTableViewCell updateValidationIconByValidStatus:status];
    }
}


#pragma mark - Table view delegate

/**
 * Simple text fields are one line high, the free text for 'About' is three lines high
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row
        || 1 == indexPath.row)
    {
        return 50.0;
    }
    else
    {
        return 70.0;
    }
    
    return 0.0;
}

/**
 * The cell has to be deselected otherwise iOS will re-select the cell after re-using it and thus the text field in the last re-used cell will become first responder
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2.0;
}


#pragma mark - Table view data source

/**
 * Show one section with three items
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/**
 * Show three items 'Name', 'Email' and 'About'
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}

/**
 * Return cells to table view. Set a cached text UI to new generated or re-used cell, thus there is
 * still access to all text UIs in a form. Otherwise the text UIs will be thrown away due to
 * reusing of the table view. It helps keeping the right data in the right text UI and having the 
 * first responder on the right text UI.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create submit button cell at the end of the table view
    if (indexPath.section == 1)
    {
        SubmitButtonTableViewCell *cell = [self submitButtonTableViewCellFromTableView:tableView];
        [cell.button addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    // Create validator text UI cells
    else
    {
        FormTableViewCell *cell;
        
        id<US2Validatable> validatable = [_form validatableAtIndex:indexPath.row];

        // Determine the kind of validation text UI and create regarding cell
        if ([validatable isKindOfClass:[US2ValidatorTextField class]])
        {
            cell = [self formTextFieldTableViewCellFromTableView:tableView];
        }
        else
        {
            cell = [self formTextViewTableViewCellFromTableView:tableView];
        }

        // Set validation text UI from collection to created cell
        cell.validatable = validatable;

        // Set type string of form element
        cell.textLabel.text       = [_typeStringCollection objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"required";

        // Listen for touches on cell's icon button
        cell.delegate = self;
        
        return cell;
    }

    return nil;
}

/**
 * Creating new form text field table view cells or re-use them
 */
- (FormTextFieldTableViewCell *)formTextFieldTableViewCellFromTableView:(UITableView *)tableView
{    
    FormTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FormTextFieldTableViewCellReuseIdentifier"];
    if (nil == cell)
    {
        cell = [[FormTextFieldTableViewCell alloc] initWithReuseIdentifier:@"FormTextFieldTableViewCellReuseIdentifier"];
    }
    
    return cell;
}

/**
 * Creating new form text view table view cells or re-use them
 */
- (FormTextViewTableViewCell *)formTextViewTableViewCellFromTableView:(UITableView *)tableView
{
    FormTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FormTextViewTableViewCellReuseIdentifier"];
    if (nil == cell)
    {
        cell = [[FormTextViewTableViewCell alloc] initWithReuseIdentifier:@"FormTextViewTableViewCellReuseIdentifier"];
    }
    
    return cell;
}

/**
 * Creating new submit button table view cell or re-use it
 */
- (SubmitButtonTableViewCell *)submitButtonTableViewCellFromTableView:(UITableView *)tableView
{
    SubmitButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubmitButtonTableViewCellReuseIdentifier"];
    if (nil == cell)
    {
        cell = [[SubmitButtonTableViewCell alloc] initWithReuseIdentifier:@"SubmitButtonTableViewCellReuseIdentifier"];
    }
    
    return cell;
}


#pragma mark - Form table view cell delegate

- (void)formTableViewCell:(FormTableViewCell *)cell touchedIconButton:(UIButton *)button aligningValidatable:(id<US2Validatable>)validatable
{
    // Show tooltip if status changed to invalid
    // Hide tooltip if status changed to valid
    if (nil != _tooltipView)
    {
        [_tooltipView removeFromSuperview];
        _tooltipView = nil;
    }
    
    // Do not show tooltip again, because it was toggled off
    if ([_tooltipConnectedValidatable isEqual:validatable])
    {
        _tooltipConnectedValidatable = nil;
        
        return;
    }
    
    // Determine point where to add the tooltip
    CGPoint point = [button convertPoint:CGPointMake(0.0, button.frame.size.height - 4.0) toView:self.testView.tableView];
    
    // Create tooltip
    // Set text to tooltip
    US2Validator *validator = validatable.validator;
    US2ConditionCollection *conditionCollection = [validator violatedConditionsUsingString:validatable.text];
    CGRect tooltipViewFrame = CGRectMake(6.0, point.y, 309.0, _tooltipView.frame.size.height);
    if (nil == conditionCollection)
    {
        _tooltipView       = [[ValidTooltipView alloc] init];
        _tooltipView.frame = tooltipViewFrame;
        
        _tooltipView.text = @"Everything is okay.";
    }
    else
    {
        _tooltipView       = [[InvalidTooltipView alloc] init];
        _tooltipView.frame = tooltipViewFrame;
        
        // Get first violation
        US2Condition *violatedCondition = [conditionCollection conditionAtIndex:0];
        _tooltipView.text = [violatedCondition localizedViolationString];
    }
    [self.testView.tableView addSubview:_tooltipView];
    
    // Remember text UI to which the tooltip was connected
    _tooltipConnectedValidatable = validatable;
}

- (void)dismissTooltip
{
    if (nil != _tooltipView)
    {
        [_tooltipView removeFromSuperview];
        _tooltipView = nil;
    }
    
    _tooltipConnectedValidatable = nil;
}


#pragma mark - Submit button

- (void)submitButtonTouched:(UIButton *)button
{
    // Set flag to YES
    _didSubmit = YES;
    
    // Create string which will contain the first error in form
    NSMutableString *errorString = [NSMutableString string];
    
    // Validate every text UI in custom text UI collection
    for (NSUInteger i = 0; i < _form.count; i++)
    {
        id<US2Validatable> validatable = [_form validatableAtIndex:i];
        id cell = ((UIView *)validatable).superview.superview;
        if ([cell isKindOfClass:[FormTableViewCell class]])
        {
            FormTableViewCell *formTableViewCell = (FormTextFieldTableViewCell *)cell;
            kFormTableViewCellStatus status = validatable.isValid == YES ? kFormTableViewCellStatusValid : kFormTableViewCellStatusInvalid;
            [formTableViewCell updateValidationIconByValidStatus:status];
            
            // If the text UI has invalid text remember the violated condition with highest priority
            if (validatable.isValid == NO
                && errorString.length == 0)
            {
                US2Validator *validator = [validatable validator];
                US2ConditionCollection *conditionCollection = [validator violatedConditionsUsingString:[validatable text]];
                US2Condition *violatedCondition = [conditionCollection conditionAtIndex:0];
                
                NSMutableString *violatedString = [NSMutableString string];
                [violatedString appendString:formTableViewCell.textLabel.text];
                [violatedString appendString:@": "];
                [violatedString appendString:[violatedCondition localizedViolationString]];
                [errorString appendString:violatedString];
            }
        }
    }
    
    // Show alert if there was an invalid text in UI
    if (errorString.length > 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Text"
                                                            message:errorString
                                                           delegate:self
                                                  cancelButtonTitle:@"Continue"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}


@end
