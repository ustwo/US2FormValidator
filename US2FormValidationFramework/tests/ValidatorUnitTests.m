//
//  ValidatorUnitTests.m
//  US2FormValidatorUnitTests
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

#import "ValidatorUnitTests.h"
#import "US2Validator.h"
#import "US2ConditionAlphabetic.h"
#import "US2ConditionRange.h"
#import "US2ValidatorComposite.h"
#import "US2ValidatorAlphabetic.h"
#import "US2ValidatorRange.h"
#import "US2ValidatorForm.h"
#import "US2ValidatorTextField.h"
#import "US2ValidatorTextView.h"
#import "US2ValidatorPostcodeUK.h"


@implementation US2ValidatableMock
@end


@implementation ValidatorUnitTests


- (void)setUp
{
    [super setUp];
    
    _validator = [[US2Validator alloc] init];
}

- (void)tearDown
{
    _validator = nil;
    
    [super tearDown];
}

/**
 Test US2Validator class.
 
 (1) Create conditions
 (2) Add conditions to validator
 (3) Test completely valid string
 (3) Test partially valid string
 (4) Test invalid string
 */
- (void)testValidator
{
    // Test for existing validator
    STAssertNotNil(_validator, @"Validator instance must not be nil", nil);
    
    // Create first condition
    US2ConditionAlphabetic *condition1 = [[US2ConditionAlphabetic alloc] init];
    
    // Create second condition
    US2ConditionRange *condition2 = [[US2ConditionRange alloc] init];
    condition2.range = US2TextRangeMake(3, 12);
    
    // Create string to test
    NSString *successTestString1 = @"abcdefgh";
    NSString *successTestString2 = @"abc def gh";
    NSString *failureTestString1 = @"ab";
    NSString *failureTestString2 = @"12";
    
    // Add first condition to validator
    [_validator addCondition:condition1];
    [_validator addCondition:condition2];
    
    US2ConditionCollection *collection = nil;
    
    // Validate whitespace first
    condition1.allowWhitespace = YES;
    collection = [_validator violatedConditionsUsingString:successTestString2];
    STAssertNil(collection, @"Collection must be nil", nil);
    
    collection = [_validator violatedConditionsUsingString:successTestString1];
    STAssertNil(collection, @"Collection must be nil", nil);
    condition1.allowWhitespace = NO;
    
    collection = [_validator violatedConditionsUsingString:successTestString1];
    STAssertNil(collection, @"Collection must be nil", nil);
    
    collection = [_validator violatedConditionsUsingString:failureTestString1];
    STAssertNotNil(collection, @"Collection must not be nil", nil);
    
    collection = [_validator violatedConditionsUsingString:failureTestString2];
    STAssertNotNil(collection, @"Collection must not be nil", nil);
}

/**
 Test US2ValidatorComposite class.
 */

- (void)testValidatorComposite
{
    US2ValidatorComposite *validatorComposite = [[US2ValidatorComposite alloc] init];
    
    // Test for existing validator
    STAssertNotNil(validatorComposite, @"Validator instance must not be nil", nil);
    
    // Create first validator
    US2ValidatorAlphabetic *validator1 = [[US2ValidatorAlphabetic alloc] init];
    
    // Create second validator
    US2ValidatorRange *validator2 = [[US2ValidatorRange alloc] init];
    validator2.range = US2TextRangeMake(3, 12);
    
    // Create string to test
    NSString *successTestString1 = @"abcdefgh";
    NSString *failureTestString1 = @"ab";
    NSString *failureTestString2 = @"12";
    
    // Add validators to composite
    [validatorComposite addValidator:validator1];
    [validatorComposite addValidator:validator2];
    
    US2ConditionCollection *collection = nil;
    collection = [validatorComposite violatedConditionsUsingString:successTestString1];
    STAssertNil(collection, @"Collection must be nil", nil);
    
    collection = [validatorComposite violatedConditionsUsingString:failureTestString1];
    STAssertNotNil(collection, @"Collection must not be nil", nil);
    
    collection = [validatorComposite violatedConditionsUsingString:failureTestString2];
    STAssertNotNil(collection, @"Collection must not be nil", nil);
}

/**
    Test US2Form class.
 */
- (void)testForm
{
    US2ValidatorForm *form = [[US2ValidatorForm alloc] init];
    
    // Test for existing form
    STAssertNotNil(form, @"Form instance must not be nil", nil);
    
    // Create first validator
    US2ValidatorAlphabetic *validator1 = [[US2ValidatorAlphabetic alloc] init];
    
    // Create second validator
    US2ValidatorRange *validator2 = [[US2ValidatorRange alloc] init];
    validator2.range = US2TextRangeMake(3, 12);
    
    // Create string to test
    NSString *successTestString1 = @"abcdefgh";
    NSString *failureTestString1 = @"ab";
    
    US2ValidatableMock *validatable1 = [[US2ValidatableMock alloc] init];
    validatable1.validator = validator1;
    validatable1.text = successTestString1;
    
    US2ValidatableMock *validatable2 = [[US2ValidatableMock alloc] init];
    validatable2.validator = validator2;
    validatable2.text = failureTestString1;
    
    [form addValidatable:validatable1];
    
    US2ConditionCollection *collection = [form violatedConditions];
    STAssertNil(collection, @"Collection must be nil", nil);
    
    [form addValidatable:validatable2];
    
    collection = [form violatedConditions];
    STAssertNotNil(collection, @"Collection must not be nil", nil);
}

/**
 Test US2Validator with localizedViolationString customization.
 */
- (void)testUS2ValidatorCustomLocalizedViolationString
{
    // Create first validator
    US2ValidatorAlphabetic *validator1 = [[US2ValidatorAlphabetic alloc] init];
    
    NSString *expectedLocalizedViolationString = @"You should only enter letters.";
    
    NSString *defaultLocalizedViolationString = @"US2KeyConditionViolationAlphabetic";
    
    STAssertNotNil(defaultLocalizedViolationString, @"Default localized violation string must not be nil.");
    
    NSString *successString1 = @"abcdef";
    NSString *failureString1 = @"abcde1";
    
    // Test success
    US2ConditionCollection *conditions = [validator1 violatedConditionsUsingString:successString1];
    STAssertNil(conditions, @"Alphabetic validator must validate alphabetic.");
    
    // Test failure with expected customized localized string
    validator1.localizedViolationString = expectedLocalizedViolationString;
    conditions = [validator1 violatedConditionsUsingString:failureString1];
    STAssertTrue([conditions count] > 0, nil);
    NSString *localizedViolationString = [validator1 localizedViolationString];
    STAssertEqualObjects(localizedViolationString, expectedLocalizedViolationString, @"Condition must return custom/overriden localized violation string.");
}

/**
 Test US2Validator validator
 */
- (void)testUS2ValidatorStatic
{
    US2Validator *validator = [US2ValidatorAlphabetic validator];
    STAssertNotNil(validator, @"Validator must not be nil.");
    STAssertTrue([validator isKindOfClass: [US2Validator class]], @"Must be correct class.", nil);
}

@end
