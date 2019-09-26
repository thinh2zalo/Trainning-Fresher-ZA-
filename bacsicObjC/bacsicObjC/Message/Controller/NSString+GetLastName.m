//
//  NSString+GetLastName.m
//  bacsicObjC
//
//  Created by Steve on 9/26/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NSString+GetLastName.h"

@implementation NSString (GetLastName)

+ (NSString *)getLastName:(NSString *) fullName{
    if(![fullName isKindOfClass:NSString.class]){
        NSLog(@"nil");
    }
    NSString *pattern = @"[A-Za-z]+$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern  options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:fullName options:0 range:NSMakeRange(0, [fullName length])];
    
    if ([match rangeAtIndex:0].location != NSNotFound) {
        return  [fullName substringWithRange:[match rangeAtIndex:0]];
    }
    else {
        return @"";
    }
}

@end
