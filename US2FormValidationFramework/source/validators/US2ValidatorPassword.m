//
//  US2ValidatorPassword.m
//  US2FormValidationFramework
//
//  Created by Alex Fish on 07/05/2012.
//  Modified by Martin Stolz on 27/11/2013.
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

#import "US2ValidatorPassword.h"


@implementation US2ValidatorPassword


- (id)init
{
    self = [super initWithCondition:[[US2ConditionPassword alloc] init]];
    return self;
}


#pragma mark - Setters

- (void)setMinimalLowerCase:(NSUInteger)minimalLowerCase
{
    if(_minimalLowerCase != minimalLowerCase)
    {
        _minimalLowerCase = minimalLowerCase;
        [self US2__modifyCondition];
    }
}

- (void)setMinimalUpperCase:(NSUInteger)minimalUpperCase
{
    if(_minimalUpperCase != minimalUpperCase)
    {
        _minimalUpperCase = minimalUpperCase;
        [self US2__modifyCondition];
    }
}

- (void)setMinimalNumbers:(NSUInteger)minimalNumbers
{
    if(_minimalNumbers != minimalNumbers)
    {
        _minimalNumbers = minimalNumbers;
        [self US2__modifyCondition];
    }
}

- (void)setMinimalSymbols:(NSUInteger)minimalSymbols
{
    if(_minimalSymbols != minimalSymbols)
    {
        _minimalSymbols = minimalSymbols;
        [self US2__modifyCondition];
    }
}

- (void)setMinimalLength:(NSUInteger)minimalLength
{
    if(_minimalLength != minimalLength)
    {
        _minimalLength = minimalLength;
        [self US2__modifyCondition];
    }
}

- (void)setRequiredStrength:(US2PasswordStrength)requiredStrength
{
    if(_requiredStrength != requiredStrength)
    {
        _requiredStrength = requiredStrength;
        [self US2__modifyCondition];
    }
}


#pragma mark - Modification of condition

- (void)US2__modifyCondition
{
    // Remove all added password strength coniditons
    [self removeConditionsOfClass:[US2ConditionPassword class]];
    
    // Add new strength condition
    US2ConditionPassword *strengthCondition = [[US2ConditionPassword alloc] init];
    strengthCondition.minimalLowerCase      = _minimalLowerCase;
    strengthCondition.minimalUpperCase      = _minimalUpperCase;
    strengthCondition.minimalNumbers        = _minimalNumbers;
    strengthCondition.minimalSymbols        = _minimalSymbols;
    strengthCondition.minimalLength         = _minimalLength;
    strengthCondition.requiredStrength      = _requiredStrength;
    [self addCondition:strengthCondition];
}

@end
