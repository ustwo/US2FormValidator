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

@implementation US2FormEntry
@synthesize validatable;
@synthesize validator;

@end

@implementation US2Form

- (id) init {
    if (self = [super init]) {
        _entries = [[NSMutableArray alloc] initWithCapacity: 1];
    }
    
    return self;
}

- (id) initWithValidatable: (id<US2Validatable>) validatable validator: (id<US2ValidatorProtocol>) validator {
    if (self = [self init]) {
        [self addValidatable: validatable validator: validator];
    }
    
    return self;
}

- (void) addValidatable: (id<US2Validatable>) validatable validator: (id<US2ValidatorProtocol>) validator {
    if (validatable != nil && validator != nil) {
        US2FormEntry *entry = [[US2FormEntry alloc] init];
        [entry setValidatable: validatable];
        [entry setValidator: validator];
        [_entries addObject: entry];
        [entry release];
    }
}

- (void) addValidatable: (id<US2Validatable>) validatable {
    [self addValidatable: validatable validator: [validatable validator]];
}

- (US2ConditionCollection *) checkConditions {
    US2ConditionCollection *conditions = nil;
    for (US2FormEntry *entry in _entries) {
        US2ConditionCollection *entryConditions = [entry.validator checkConditions: [entry.validatable validatableText]];
        if (entryConditions && conditions == nil) {
            conditions = [[US2ConditionCollection alloc] init];
        }
        for (id<US2ConditionProtocol> condition in entryConditions) {
            [conditions addCondition: condition];
        }
    }
    return [conditions autorelease];
}

@end