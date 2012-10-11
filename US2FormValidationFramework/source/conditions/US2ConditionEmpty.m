//
//  US2ConditionEmpty.m
//  US2FormValidationFramework
//
//  Created by Matthew Purland on 10/10/12.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import "US2ConditionEmpty.h"

@implementation US2ConditionEmpty

- (id) init {
    if (self = [super init]) {
        self.allowsNull = YES;
    }
    
    return self;
}

- (BOOL)check:(NSString *)string
{
    if (nil == string && self.allowsNull)
        return NO;
    
    if (![string isEqualToString: @""]) {
        return YES;
    }
    
    return NO;
}


#pragma mark - Allow violation

- (BOOL)shouldAllowViolation
{
    return YES;
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    NSString *key = @"US2KeyConditionViolationEmpty";
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource: @"Localization" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    if (bundle)
    {
        return [bundle localizedStringForKey:key value:key table:nil];
    }
    
    return nil;
}

@end
