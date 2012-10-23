//
//  US2Validator.m
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

#import "US2Validator.h"
#import "US2Condition.h"
#import "US2ConditionCollection.h"


@implementation US2Validator

+ (US2Validator *) validator {
    return [[[[self class] alloc] init] autorelease];
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _conditionCollection = [[US2ConditionCollection alloc] init];
    }
    
    return self;
}

- (id) initWithCondition: (id<US2ConditionProtocol>) firstCondition, ... {
    if (self = [self init]) {
        [self addCondition: firstCondition];
        
        va_list args;
        va_start(args, firstCondition);
        
        id<US2ConditionProtocol> condition = nil;
        
        while( (condition = va_arg( args, id<US2ConditionProtocol>)) != nil ) {
            
            [self addCondition: condition];
        }

        va_end(args);
    }
    
    return self;
}

- (id) initWithConditions: (NSArray *) conditions {
    if (self = [self init]) {
        for (id<US2ConditionProtocol> condition in conditions) {
            [self addCondition: condition];
        }
    }
    
    return self;
}

#pragma mark - Deinitialization

- (void)dealloc
{
    [_conditionCollection release];
    
    [super dealloc];
}

#pragma mark - Localized violation string

- (void) setLocalizedViolationString: (NSString *) localizedViolationString forConditionAtIndex: (NSUInteger) index {
    if (index < [_conditionCollection count]) {
        id<US2ConditionProtocol> conditionProtocol = [_conditionCollection conditionAtIndex: index];
        if ([conditionProtocol isKindOfClass: [US2Condition class]]) {
            US2Condition *condition = (US2Condition *) conditionProtocol;
            condition.localizedViolationString = localizedViolationString;
        }
    }
}

- (id) withLocalizedViolationString: (NSString *) localizedViolationString forConditionAtIndex: (NSUInteger) index {
    [self setLocalizedViolationString: localizedViolationString forConditionAtIndex: index];
    return self;
}

- (id) withLocalizedViolationString: (NSString *) localizedViolationString {
    return [self withLocalizedViolationString: localizedViolationString forConditionAtIndex: 0];
}

#pragma mark - Condition

/**
 Add condition for validation queue.
*/
- (void)addCondition:(id <US2ConditionProtocol>)condition
{
    if ([condition isKindOfClass:[US2Condition class]])
        [_conditionCollection addCondition:condition];
    else
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added incompatible condition <%@> to validator.", [condition class]], nil];
}

/**
 Remove all conditions which are kind of specific class.
*/
- (void)removeConditionOfClass:(Class <US2ConditionProtocol>)conditionClass
{
    for (US2Condition *condition in _conditionCollection)
    {
        if ([condition isKindOfClass:conditionClass])
            [_conditionCollection removeCondition:condition];
    }
}


#pragma mark - Condition check

/**
 Returns all violated condition in a US2ConditionCollection
*/
- (US2ConditionCollection *)checkConditions:(NSString *)string
{
    US2ConditionCollection *violatedConditions = nil;
    for (US2Condition *condition in _conditionCollection)
    {
        if (NO == [condition check:string])
        {
            if (nil == violatedConditions)
                violatedConditions = [[US2ConditionCollection alloc] init];
            
            [violatedConditions addCondition:condition];
        }
    }
    
    return [violatedConditions autorelease];
}


@end

@implementation US2ValidatorSingleCondition

@synthesize condition = _condition;
@dynamic localizedViolationString;

- (id) initWithCondition: (id<US2ConditionProtocol>) condition {
    if (self = [super init]) {
        [self setCondition: condition];
    }
    
    return self;
}

- (void) setCondition:(id<US2ConditionProtocol>)condition {
    [_condition release];
    _condition = [condition retain];
    
    [_conditionCollection removeAllConditions];
    [self addCondition: _condition];
}

- (NSString *) localizedViolationString {
    if ([_conditionCollection count] > 0) {
        return [[_conditionCollection conditionAtIndex: 0] localizedViolationString];
    }
    
    return nil;
}

- (void) setLocalizedViolationString:(NSString *)localizedViolationString {
    [self setLocalizedViolationString: localizedViolationString forConditionAtIndex: 0];
}

@end