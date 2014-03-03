//
//  MyProjectTextField.m
//  US2FormValidationFrameworkSample
//
//  Created by Martin on 21/01/2014.
//
//

#import "MyProjectTextField.h"


@implementation MyProjectTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self us2_build];
    }
    
    return self;
}

- (void)us2_build
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4.0;
    self.layer.borderColor  = [UIColor grayColor].CGColor;
    self.layer.borderWidth  = 1.0;
    self.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
    self.textColor = [UIColor blackColor];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10.0, 0.0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}


#pragma mark - Internal validation state changes

/**
 After occurring violations the UI will be changed.
 */
- (void)validatorTextFieldPrivate:(US2ValidatorTextFieldPrivate *)textFieldPrivate violatedConditions:(US2ConditionCollection *)conditions
{
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 2.0;
}

/**
 After the text of the text field turns into valid the UI will be changed back.
 */
- (void)validatorTextFieldPrivateSuccededConditions:(US2ValidatorTextFieldPrivate *)textFieldPrivate
{
    self.layer.borderColor = [UIColor greenColor].CGColor;
    self.layer.borderWidth = 2.0;
}

@end
