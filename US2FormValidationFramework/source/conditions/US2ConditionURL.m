//
//  US2ConditionURL.m
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

#import "US2ConditionURL.h"


@implementation US2ConditionURL


- (BOOL)check:(NSString *)string
{
    if (nil == string)
    {
        return NO;
    }
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSTextCheckingResult *firstMatch = [detector firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    return [firstMatch.URL isKindOfClass:[NSURL class]]
           && ![firstMatch.URL.scheme isEqualToString:@"mailto"]
           && ![firstMatch.URL.scheme isEqualToString:@"ftp"];
}


#pragma mark - Allow violation

- (BOOL)shouldAllowViolation
{
    return YES;
}


#pragma mark - Localization

- (NSString *)localizedViolationString
{
    NSString *key = @"US2KeyConditionViolationURL";
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Localization.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    if (bundle)
    {
        return [bundle localizedStringForKey:key value:key table:nil];
    }
    
    return nil;
}

@end