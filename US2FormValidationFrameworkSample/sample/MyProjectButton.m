//
//  MyProjectButton.m
//  US2FormValidationFrameworkSample
//
//  Created by Martin on 21/01/2014.
//
//

#import "MyProjectButton.h"
#import <QuartzCore/QuartzCore.h>


@implementation MyProjectButton

+ (MyProjectButton *)button
{
    MyProjectButton *button = [MyProjectButton buttonWithType:UIButtonTypeCustom];
    
    return button;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self US2_build];
    }
    return self;
}

- (void)US2_build
{
    self.layer.cornerRadius = 4.0;
    self.clipsToBounds = YES;
    [self setTitle:@"Submit" forState:UIControlStateNormal];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (enabled)
    {
        self.backgroundColor = [UIColor greenColor];
    }
    else
    {
        self.backgroundColor = [UIColor grayColor];
    }
}

@end
