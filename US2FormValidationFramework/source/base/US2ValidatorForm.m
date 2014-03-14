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
#import "US2Validatable.h"
#import "US2ConditionCollection.h"
#import "US2Validator.h"


@interface US2ValidatorForm ()

@property (nonatomic) NSMutableArray *entries;
@property (nonatomic) BOOL           lastValidState;

@end


@implementation US2ValidatorForm


#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.entries = [[NSMutableArray alloc] initWithCapacity:1];
        self.lastValidState = NO;
    }
    
    return self;
}

- (void)dealloc
{
    self.entries = nil;
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
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added nil object <%@> as validatable to form.", [validatable class]], nil];
    }
    
    if (![validatable conformsToProtocol:@protocol(US2Validatable)])
    {
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added incompatible validatable <%@> to form.", [validatable class]], nil];
    }
    
    [self.entries addObject:validatable];
    
    [self us2_listenForTextDidChangeNotification:validatable];
}

- (id<US2Validatable>)validatableAtIndex:(NSInteger)index
{
    return self.entries[index];
}


#pragma mark - Listener

- (void)us2_listenForTextDidChangeNotification:(id<US2Validatable>)validatable
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
    return self.entries.count;
}


#pragma mark - Validation state

- (US2ConditionCollection *)violatedConditions
{
    US2ConditionCollection *violatedConditions = nil;
    for (id<US2Validatable> validatable in self.entries)
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
    for (id<US2Validatable> validatable in self.entries)
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
    if (self.lastValidState == self.isValid) return;
    
    self.lastValidState = !self.lastValidState;
    
    if (self.didChangeValidState)
    {
        self.didChangeValidState(self.isValid);
    }
}

@end