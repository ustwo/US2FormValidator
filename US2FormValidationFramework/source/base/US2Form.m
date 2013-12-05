//
//  US2Form.m
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

#import "US2Form.h"


@interface US2Form ()
{
    NSMutableArray *_entries;
}
@end


@implementation US2Form

- (id)init
{
    self = [super init];
    if (self)
    {
        _entries = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return self;
}

- (void)dealloc
{
    _entries = nil;
}

- (id)initWithValidatable:(id<US2Validatable>)validatable
{
    self = [super init];
    if (self)
    {
        [self addValidatable:validatable];
    }
    
    return self;
}

- (void)addValidatable:(id<US2Validatable>)validatable
{
    if (!validatable)
    {
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added nil object <%@>  as validatable to form.", [validatable class]], nil];
    }
    
    if (![validatable conformsToProtocol:@protocol(US2Validatable)])
    {
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added incompatible validatable <%@> to form.", [validatable class]], nil];
    }
    
    [_entries addObject:validatable];
}

- (id<US2Validatable>)validatableAtIndex:(NSInteger)index
{
    return [_entries objectAtIndex:index];
}

- (NSUInteger)count
{
    return _entries.count;
}

- (US2ConditionCollection *)violatedConditions
{
    US2ConditionCollection *conditions = nil;
    for (id<US2Validatable> validatable in _entries)
    {
        US2ConditionCollection *entryConditions = [validatable.validator violatedConditionsUsingString:validatable.text];
        if (entryConditions && conditions == nil)
        {
            conditions = [[US2ConditionCollection alloc] init];
        }
        for (id<US2ConditionProtocol> condition in entryConditions)
        {
            [conditions addCondition:condition];
        }
    }
    
    return conditions;
}

@end