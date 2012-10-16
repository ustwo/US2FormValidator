//
//  ConditionUnitTests.m
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

#import "ConditionUnitTests.h"
#import "US2Condition.h"
#import "US2ConditionCollection.h"
#import "US2ConditionAlphabetic.h"
#import "US2ConditionAlphanumeric.h"
#import "US2ConditionEmail.h"
#import "US2ConditionNumeric.h"
#import "US2ConditionRange.h"
#import "US2ConditionURL.h"
#import "US2ConditionShorthandURL.h"
#import "US2ConditionPostcodeUK.h"
#import "US2ConditionOr.h"
#import "US2ConditionAnd.h"
#import "US2ConditionNot.h"

@implementation ConditionUnitTests


- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

/**
 Test US2ConditionCollection check
 */
- (void)testUS2ConditionCollection
{
    US2ConditionCollection *collection = [[US2ConditionCollection alloc] init];
    
    STAssertTrue(collection.count == 0, @"The collection should be empty", nil);
    
    NSObject *someObject = nil;
    STAssertThrows([collection addCondition:(US2Condition *)someObject], @"Must not be able to take a nil object", nil);
    STAssertTrue(collection.count == 0, @"The collection must be empty", nil);
    
    someObject = [[[NSObject alloc] init] autorelease];
    STAssertNoThrow([collection addCondition:(US2Condition *)someObject], @"Must be able to take some other object", nil);
    US2Condition *condition = [collection conditionAtIndex:0];
    STAssertFalse([condition isKindOfClass:[US2Condition class]], @"The first item in collection can't be a condition", nil);
    [collection removeConditionAtIndex:0];
    STAssertTrue(collection.count == 0, @"The collection must be empty", nil);
    
    US2Condition *condition2 = [[[US2Condition alloc] init] autorelease];
    STAssertNoThrow([collection addCondition:condition2], @"Must be able to take a condition", nil);
    STAssertTrue(collection.count == 1, @"The collection must have one item", nil);
    [collection removeCondition:condition2];
    STAssertTrue(collection.count == 0, @"The collection must be empty", nil);
    
    [collection release];
}

/**
 Test US2ConditionAlphabetic check
 */
- (void)testUS2ConditionAlphabetic
{
    NSString *successTestString1 = @"abcdefgh";
    NSString *successTestString2 = @"abcd efg h";
    NSString *failureTestString1 = @"12345678";
    NSString *failureTestString2 = @"a?";
    NSString *failureTestString3 = nil;
    
    US2ConditionAlphabetic *condition = [[US2ConditionAlphabetic alloc] init];
    
    STAssertTrue([condition check:successTestString1], @"The US2ConditionAlphabetic should respond with TRUE and not FALSE", nil);
    
    condition.allowWhitespace = YES;
    STAssertTrue([condition check:successTestString1], @"The US2ConditionAlphabetic should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionAlphabetic should respond with TRUE and not FALSE", nil);
    condition.allowWhitespace = NO;
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionAlphabetic should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionAlphabetic should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString3], @"The US2ConditionAlphabetic should respond with FALSE and not TRUE", nil);
    
    [condition release];
}

/**
 Test US2ConditionAlphanumeric check
 */
- (void)testUS2ConditionAlphanumeric
{
    NSString *successTestString1 = @"abcdefgh1234567890";
    NSString *failureTestString1 = @"a?1";
    NSString *failureTestString2 = nil;
    
    US2ConditionAlphanumeric *condition = [[US2ConditionAlphanumeric alloc] init];
    STAssertTrue([condition check:successTestString1], @"The US2ConditionAlphanumeric should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionAlphanumeric should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionAlphanumeric should respond with FALSE and not TRUE", nil);
}

/**
 Test US2ConditionEmail check
 */
- (void)testUS2ConditionEmail
{
    NSString *successTestString1 = @"example@example.ex";
    NSString *successTestString2 = @"e_x.a+m-p_l.e@example.ex.am";
    NSString *successTestString3 = @"example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_example_@example.ex";
    NSString *failureTestString1 = @"example";
    NSString *failureTestString2 = @"example@";
    NSString *failureTestString3 = @"example@example";
    NSString *failureTestString4 = @"example@example.";
    NSString *failureTestString5 = @"example@example.ex.";
    NSString *failureTestString6 = @"e xample@example.ex.";
    NSString *failureTestString7 = @"e/xample@example.ex.";
    NSString *failureTestString8 = @"example@example.ex example@example.ex";
    NSString *failureTestString9 = nil;
    
    US2ConditionEmail *condition = [[US2ConditionEmail alloc] init];
    STAssertTrue([condition check:successTestString1], @"The US2ConditionEmail should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionEmail should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString3], @"The US2ConditionEmail should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString3], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString4], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString5], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString6], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString7], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString8], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString9], @"The US2ConditionEmail should respond with FALSE and not TRUE", nil);
}

/**
 Test US2ConditionURL check
 */
- (void)testUS2ConditionURL
{
    NSString *successTestString1 = @"http://www.example.com";
    NSString *successTestString2 = @"https://www.example.com";
    NSString *successTestString3 = @"http://www.example.com/path";
    NSString *successTestString4 = @"http://www.example.com/?id=12345&param=value";
    
    NSString *failureTestString1 = @"";
    NSString *failureTestString2 = nil;
    NSString *failureTestString3 = @"example";
    NSString *failureTestString4 = @"example.com";
    NSString *failureTestString5 = @"www.example.com";
    NSString *failureTestString6 = @"http://example";
    NSString *failureTestString7 = @"http://";
    NSString *failureTestString8 = @"ftp://www.example.com";
    NSString *failureTestString9 = @"mailto://www.example.com";
    
    US2ConditionURL* condition = [[US2ConditionURL alloc] init];
    STAssertTrue([condition check:successTestString1], @"The US2ConditionURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString3], @"The US2ConditionURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString4], @"The US2ConditionURL should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString3], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString4], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString5], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString6], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString7], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString8], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString9], @"The US2ConditionURL should respond with FALSE and not TRUE", nil);
}

/**
 Test US2ConditionShorthandURL check
 */
- (void)testUS2ConditionShorthandURL
{
    NSString *successTestString1 = @"http://www.example.com";
    NSString *successTestString2 = @"https://www.example.com";
    NSString *successTestString3 = @"http://www.example.com/path";
    NSString *successTestString4 = @"http://www.example.com/path";
    NSString *successTestString5 = @"http://www.example.com/?id=12345&param=value";
    NSString *successTestString6 = @"example.com";
    NSString *successTestString7 = @"www.example.com";
    NSString *successTestString8 = @"www.example.com/path";
    
    NSString *failureTestString1 = @"";
    NSString *failureTestString2 = nil;
    NSString *failureTestString3 = @"example";
    NSString *failureTestString4 = @"http://example";
    NSString *failureTestString5 = @"http://";
    NSString *failureTestString6 = @"ftp://www.example.com";
    NSString *failureTestString7 = @"mailto://www.example.com";
    
    US2ConditionShorthandURL* condition = [[US2ConditionShorthandURL alloc] init];
    STAssertTrue([condition check:successTestString1], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString3], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString4], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString5], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString6], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString7], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString8], @"The US2ConditionShorthandURL should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionShorthandURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionShorthandURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString3], @"The US2ConditionShorthandURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString4], @"The US2ConditionShorthandURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString5], @"The US2ConditionShorthandURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString6], @"The US2ConditionShorthandURL should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString7], @"The US2ConditionShorthandURL should respond with FALSE and not TRUE", nil);
}

/**
 Test US2ConditionNumeric check
*/
- (void)testUS2ConditionNumeric
{
    NSString *successTestString1 = @"1234567890";
    NSMutableString *successTestString2 = [NSMutableString string];
    for (NSUInteger i = 0; i < 10; i++)
    {
        [successTestString2 appendString:successTestString1];
    }
    
    NSString *failureTestString1 = @"a";
    NSString *failureTestString2 = nil;
    
    US2ConditionNumeric *condition = [[US2ConditionNumeric alloc] init];
    STAssertTrue([condition check:successTestString1], @"The US2ConditionNumeric should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionNumeric should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionNumeric should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionNumeric should respond with FALSE and not TRUE", nil);
}

/**
 Test US2ConditionRange check
*/
- (void)testUS2ConditionRange
{
    NSString *successTestString1 = @"1A2B3D4C5D";
    NSString *successTestString2 = @"1A2";
//    NSMutableString *successTestString3 = [NSMutableString string];
//    for (NSUInteger i = 0; i < 1000000; i++)
//    {
//        [successTestString3 appendString:successTestString1];
//    }
    
    NSString *failureTestString1 = @"1A2B3D4C5D6E";
    NSString *failureTestString2 = @"1A";
    NSString *failureTestString3 = nil;
    NSString *failureTestString4 = @"";
    
    US2ConditionRange *condition = [[US2ConditionRange alloc] init];
    condition.range = NSMakeRange(3, 10);
    STAssertTrue([condition check:successTestString1], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString3], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString4], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
}

/**
 Test US2ConditionRange check
 */
- (void)testUS2ConditionRange2
{
    NSString *successTestString1 = @"";
    NSString *successTestString2 = @"1";
    NSString *successTestString3 = @"1A";
    NSString *successTestString4 = @"1A2";
    
    NSString *failureTestString1 = @"1A234";
    
    US2ConditionRange *condition = [[US2ConditionRange alloc] init];
    condition.range = NSMakeRange(0, 4);
    STAssertTrue([condition check:successTestString1], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString3], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString4], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
}

/**
 Test US2ConditionPostcodeUK check
 */
- (void)testUS2ConditionPostcodeUK
{
    NSString *successTestString1 = @"M1 1BA";
    NSString *successTestString2 = @"N12 1UD";
    NSString *successTestString3 = @"EH9 4UA";
    NSString *successTestString4 = @"RG6 1WG";
    NSString *successTestString5 = @"W1A 1NA";
    NSString *successTestString6 = @"SW1A 1HQ";
    NSString *successTestString7 = @"FIQQ 1ZZ"; // Falkland Islands
    
    NSString *failureTestString1 = @"M1AA 1BA";
    NSString *failureTestString2 = @"M1 1BAA";
    NSString *failureTestString3 = @"M1 1BA1";
    NSString *failureTestString4 = nil;
    NSString *failureTestString5 = @"";
    
    US2ConditionPostcodeUK *condition = [[US2ConditionPostcodeUK alloc] init];
    STAssertTrue([condition check:successTestString1], @"The US2ConditionPostcodeUK should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The US2ConditionPostcodeUK should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString3], @"The US2ConditionPostcodeUK should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString4], @"The US2ConditionPostcodeUK should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString5], @"The US2ConditionPostcodeUK should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString6], @"The US2ConditionPostcodeUK should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString7], @"The US2ConditionPostcodeUK should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The US2ConditionPostcodeUK should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString2], @"The US2ConditionPostcodeUK should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString3], @"The US2ConditionPostcodeUK should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString4], @"The US2ConditionPostcodeUK should respond with FALSE and not TRUE", nil);
    STAssertFalse([condition check:failureTestString5], @"The US2ConditionPostcodeUK should respond with FALSE and not TRUE", nil);
}

/**
 Test US2Condition createLocalizedViolationString and localizedViolationString customization.
 */
- (void)testUS2ConditionCustomLocalizedViolationString
{
    NSString *customLocalizedViolationString = @"Enter a valid UK postal code.";
    US2ConditionPostcodeUK *condition = [[US2ConditionPostcodeUK alloc] init];
    condition.localizedViolationString = customLocalizedViolationString;
    
    STAssertEqualObjects([condition localizedViolationString], customLocalizedViolationString, @"Condition must return custom/overriden localized violation string.");
}

/**
 Test US2ConditionOr
 */
- (void) testUS2ConditionOr {
    NSString *successTestString1 = @"";    
    NSString *failureTestString1 = @"1A234";
    
    US2ConditionRange *conditionRange = [[US2ConditionRange alloc] init];
    conditionRange.range = NSMakeRange(0, 4);
    
    US2ConditionAlphanumeric *conditionAlphanumeric = [[US2ConditionAlphanumeric alloc] init];
    
    US2ConditionOr *conditionOr = [[US2ConditionOr alloc] initWithConditionOne: conditionRange two: conditionAlphanumeric];
    NSString *expectedLocalizedViolationString = @"Min 0 Max 4 or must only contain alphanumeric";
    conditionOr.localizedViolationString = expectedLocalizedViolationString;
    
    // Test initial conditions
    STAssertTrue([conditionRange check:successTestString1], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);    
    STAssertFalse([conditionRange check:failureTestString1], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
    STAssertEqualObjects([conditionRange localizedViolationString], @"Enter minimum 0, maximum 4 characters", @"Localized violation desription must match.");
    
    // Test or condition
    STAssertTrue([conditionOr check: failureTestString1], @"The US2ConditionOr should be true for alpha or range.", nil);
    STAssertEqualObjects([conditionOr localizedViolationString], expectedLocalizedViolationString, @"Localized violation desription must match.");
}

/**
 Test US2ConditionAnd
 */
- (void) testUS2ConditionAnd {
    NSString *successTestString1 = @"";
    NSString *successTestString2 = @"1A23";
    NSString *failureTestString1 = @"1A234";
    
    US2ConditionRange *conditionRange = [[US2ConditionRange alloc] init];
    conditionRange.range = NSMakeRange(0, 4);
    
    US2ConditionAlphanumeric *conditionAlphanumeric = [[US2ConditionAlphanumeric alloc] init];
    
    US2ConditionAnd *conditionAnd = [[US2ConditionAnd alloc] initWithConditionOne: conditionRange two: conditionAlphanumeric];
    NSString *expectedLocalizedViolationString = @"Min 0 Max 4 and must only contain alphanumeric";
    conditionAnd.localizedViolationString = expectedLocalizedViolationString;
    
    // Test initial conditions
    STAssertTrue([conditionRange check:successTestString1], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    STAssertFalse([conditionRange check:failureTestString1], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
    STAssertEqualObjects([conditionRange localizedViolationString], @"Enter minimum 0, maximum 4 characters", @"Localized violation desription must match.");
    
    // Test or condition
    STAssertTrue([conditionAnd check: successTestString1], @"The US2ConditionAnd should be true for alpha or range.", nil);
    STAssertTrue([conditionAnd check: successTestString2], @"The US2ConditionAnd should be true for alpha or range.", nil);
    STAssertFalse([conditionAnd check: failureTestString1], @"The US2ConditionAnd should be true for alpha or range.", nil);
    STAssertEqualObjects([conditionAnd localizedViolationString], expectedLocalizedViolationString, @"Localized violation desription must match.");
}

/**
 Test US2ConditionNot
 */
- (void) testUS2ConditionNot {
    NSString *successTestString1 = @"";
    NSString *failureTestString1 = @"1A234";
    
    US2ConditionRange *conditionRange = [[US2ConditionRange alloc] init];
    conditionRange.range = NSMakeRange(0, 4);
    
    US2ConditionNot *conditionNot = [[US2ConditionNot alloc] initWithCondition: conditionRange];
    NSString *expectedLocalizedViolationString = @"Must not be between 0 through 4.";
    conditionNot.localizedViolationString = expectedLocalizedViolationString;
    
    // Test initial conditions
    STAssertTrue([conditionRange check:successTestString1], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    STAssertFalse([conditionRange check:failureTestString1], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
    STAssertEqualObjects([conditionRange localizedViolationString], @"Enter minimum 0, maximum 4 characters", @"Localized violation desription must match.");
    
    // Test not condition
    STAssertFalse([conditionNot check:successTestString1], @"The US2ConditionRange should respond with TRUE and not FALSE", nil);
    STAssertTrue([conditionNot check:failureTestString1], @"The US2ConditionRange should respond with FALSE and not TRUE", nil);
    STAssertEqualObjects([conditionNot localizedViolationString], expectedLocalizedViolationString, @"Localized violation desription must match.");
    
}

/**
 Test US2Condition condition
 */
- (void) testUS2ConditionStatic {
    US2Condition *conditionRange = [US2ConditionRange condition];
    STAssertNotNil(conditionRange, @"Condition must not be nil.");
    STAssertTrue([conditionRange isKindOfClass: [US2ConditionRange class]], @"Must be correct class.", nil);
}

@end
