![ustwo US2FormValidator](https://github.com/ustwo/US2FormValidator/raw/light-arc/Documentation/Images/Form Validator Sample Preview.jpg)

ustwo™ iOS Form Validator
=========================

[![Build Status](https://travis-ci.org/ustwo/US2FormValidator.png?branch=light-arc)](https://travis-ci.org/ustwo/US2FormValidator)

The form validator framework allows you to conveniently validate entire forms with various types of fields.
Bear in mind this is version 2 and is incompatible to version 1.x.

Features
--------

* Simply use US2ValidatorTextField instead of UITextField (US2ValidatorTextView instead of UITextView)
* Use the form to get notified as soon as all fields are valid
* Know what went wrong and where
* Create own conditions using regular expressions for example
* Create own validators which contain a collection of conditions
* ARC only

Changelog
---------
### 2.0
* Simplified API
* ARC compatible
* Use text field's delegate property instead of validatorUIDelegate property to get called back
* Conditions are valid when string is empty, combine with US2ConditionPresent to catch this case


Installation using CocoaPods
----------------------------

How to use CocoaPods? Go to:
https://github.com/CocoaPods/CocoaPods

Add the following line to your pod file:

    pod 'US2FormValidator', '~> 2.0'

Manual installation
-------------------

### Clone the project

Clone the project from the link above.

### Import the framework project into your project

![Import framework screen](https://github.com/ustwo/US2FormValidator/raw/master/Documentation/Images/Import Framework.png)

### Set target dependencies

![Target dependencies screen](https://github.com/ustwo/US2FormValidator/raw/master/Documentation/Images/Target Dependencies.png)

### Add US2Localizable.strings to your projects Copy Bundle Resources

![Target dependencies screen](https://github.com/ustwo/US2FormValidator/raw/master/Documentation/Images/Bundle Resources.png)

How-To
------

### Add a condition to a validator

    US2Validator *validator = [[US2Validator alloc] init];
    
    US2ConditionAlphabetic *condition = [[US2ConditionAlphabetic alloc] init];
    [validator addCondition:condition];
    
    US2ConditionCollection *conditionCollection1 = [validator checkConditions:@"HelloWorld"];
    US2ConditionCollection *conditionCollection2 = [validator checkConditions:@"Hello World 123"];
    
    BOOL isValid = conditionCollection1 == nil; // isValid == YES
    isValid = conditionCollection2 == nil;      // isValid == NO
    
    // What went wrong?
    NSLog(@"conditionCollection2: %@", conditionCollection2);

### Add a validation text field

    US2ValidatorTextField *firstNameTextField  = [[US2ValidatorTextField alloc] init];
    firstNameTextField.validator               = [[MyProjectValidatorName alloc] init];
    firstNameTextField.shouldAllowViolation    = YES;
    firstNameTextField.validateOnFocusLossOnly = YES;
    firstNameTextField.placeholder             = @"Enter first name";
    firstNameTextField.delegate                = self;
    [self.textUICollection addObject:firstNameTextField];

### Create an own condition

Create the interface.

	#import <Foundation/Foundation.h>
	#import "US2Condition.h"
	
	
	@interface MyProjectConditionName : US2Condition
	@end

Create the implementation.

	#import "MyProjectConditionName.h"
	
	
	@implementation MyProjectConditionName

	- (BOOL)check:(NSString *)string
	{
		if (nil == string)
		{
			string = [NSString string];
		}
		
		self.regexString = @"[a-zA-Z .-]";
		
		return [super check:string];
	}
	
	
	#pragma mark - Localization
	
	- (NSString *)localizedViolationString
	{
		return @"Not a valid name";
	}
	
	
	@end

### Create own validator

Create the interface.

	#import <Foundation/Foundation.h>
	#import "US2Validator.h"
	
	
	#pragma mark - Validator interface
	
	@interface MyProjectValidatorName : US2Validator
	@end

Create the implementation.

	#import "MyProjectValidatorName.h"
	#import "MyProjectConditionName.h"
	#import "US2ConditionRange.h"
	
	
	@implementation MyProjectValidatorName
	
	
	#pragma mark - Initialization
	
	- (id)init
	{
		self = [super init];
		if (self)
		{
			[self addCondition:[[MyProjectConditionName alloc] init]];
			
			US2ConditionRange *rangeCondition   = [[US2ConditionRange alloc] init];
			rangeCondition.range                = US2MakeRange(2, UINT16_MAX);
			rangeCondition.shouldAllowViolation = YES;
			
			[self addCondition:rangeCondition];
		}
		
		return self;
	}
	
	
	@end

