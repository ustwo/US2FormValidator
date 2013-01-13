//
//  US2ConditionPresent.m
//  US2FormValidationFramework
//
//  Created by Alex Fish on 13/01/2013.
//  Copyright (c) 2013 ustwo™. All rights reserved.
//

#import "US2ConditionPresent.h"

@implementation US2ConditionPresent

- (BOOL)check:(NSString *)string
{
    if(!string)
    {
        return NO;
    }
    
    return string.length > 0 ? YES : NO;
}


#pragma mark - Allow violation

- (BOOL)shouldAllowViolation
{
    return YES;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return US2LocalizedString(@"US2KeyConditionViolationPresent", nil);
}

@end
