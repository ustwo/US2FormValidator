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

#import "US2ValidatorForm.h"


@interface US2ValidatorForm ()
{
    NSMutableArray *_entries;
    BOOL _lastValidState;
}
@end


@implementation US2ValidatorForm


#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _entries = [[NSMutableArray alloc] initWithCapacity:1];
        _lastValidState = NO;
    }
    
    return self;
}

- (void)dealloc
{
    _entries = nil;
}

- (instancetype)initWithValidatables:(NSSet *)validatables
{
    self = [super init];
    if (self)
    {
        for (id<US2Validatable> validatable in validatables)
        {
            [self addValidatable:validatable];
        }
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
    
    [self US2__listenForTextDidChangeNotification:validatable];
}

- (id<US2Validatable>)validatableAtIndex:(NSInteger)index
{
    return [_entries objectAtIndex:index];
}

- (void)US2__listenForTextDidChangeNotification:(id<US2Validatable>)validatable
{
    NSString *notificationName;
    if ([validatable isKindOfClass:[UITextField class]])
    {
        notificationName = UITextFieldTextDidChangeNotification;
    }
    else if ([validatable isKindOfClass:[UITextView class]])
    {
        notificationName = UITextViewTextDidChangeNotification;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textUIChanged:)
                                                 name:notificationName
                                               object:validatable];
}


#pragma mark - Count

- (NSUInteger)count
{
    return _entries.count;
}


#pragma mark - Validation state

- (US2ConditionCollection *)violatedConditions
{
    US2ConditionCollection *violatedConditions = nil;
    for (id<US2Validatable> validatable in _entries)
    {
        US2ConditionCollection *validatableConditions = [validatable.validator violatedConditionsUsingString:validatable.text];
        for (id<US2ConditionProtocol> condition in validatableConditions)
        {
            if (!violatedConditions)
            {
                violatedConditions = [[US2ConditionCollection alloc] init];
            }
            [violatedConditions addCondition:condition];
        }
    }
    
    return violatedConditions;
}

- (BOOL)isValid
{
    for (id<US2Validatable> validatable in _entries)
    {
        if (validatable.isValid == NO)
        {
            return NO;
        }
    }
    
    return YES;
}


#pragma mark - Text events

- (void)textUIChanged:(NSNotification *)notification
{
    if (_lastValidState == self.isValid) return;
    _lastValidState = !_lastValidState;
    
    if (_didChangeValidState)
    {
        _didChangeValidState(self.isValid);
    }
}

@end