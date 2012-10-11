//
//  US2ValidatorComposite.m
//  US2FormValidator
//
//  Created by Matthew Purland <m.purland@gmail.com>
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


#import "US2ValidatorComposite.h"

@implementation US2ValidatorComposite

@synthesize validators = _validators;

- (id) initWithValidators: (NSArray *) validators {
    if (self = [super init]) {
        self.validators = [NSMutableArray arrayWithArray: validators];
    }
    
    return self;
}

- (id) init {
    if (self = [self initWithValidators: [NSArray array]]) {
        
    }
    
    return self;
}

- (void) addValidator: (id<US2ValidatorProtocol>) validator {
    [self.validators addObject: validator];
}

- (void) addValidatorsFromArray: (NSArray *) validators {
    [self.validators addObjectsFromArray: validators];
}

#pragma mark - Condition check

/**
    Returns all violated condition in a US2ConditionCollection by checking each composite validator.
 */
- (US2ConditionCollection *)checkConditions:(NSString *)string
{
    US2ConditionCollection *violatedConditions = [super checkConditions: string];
    
    // Check violated conditions of each composite validator
    if (violatedConditions == nil) {
        for (id<US2ValidatorProtocol> validator in _validators) {
            US2ConditionCollection *checkedViolatedConditions = [validator checkConditions: string];
            if (checkedViolatedConditions != nil) {
                if (violatedConditions == nil) {
                    violatedConditions = [[US2ConditionCollection alloc] init];
                }
                for (id<US2ConditionProtocol> condition in checkedViolatedConditions) {
                    [violatedConditions addCondition: condition];
                }
            }
        }
    }
    
    return [violatedConditions autorelease];
}

@end
