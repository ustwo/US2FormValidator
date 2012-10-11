//
//  US2ValidatorEmpty.m
//  US2FormValidationFramework
//
//  Created by Matthew Purland on 10/10/12.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import "US2ValidatorEmpty.h"
#import "US2ConditionEmpty.h"

@implementation US2ValidatorEmpty

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[[US2ConditionEmpty alloc] init] autorelease]];
    }
    
    return self;
}

@end
