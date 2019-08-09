//
//  NSString+DetectURL.m
//  ExampleRegex
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NSString+DetectURL.h"

@implementation NSString (DetectURL)

+(NSString *)getShemeFromURLString:(NSString *) strURL{
    NSString *pattern = @"(https?://)?([a-z0-9-]+?.?[a-z0-9-]+.[a-z]{2,})(/[^s]+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern  options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:strURL options:0 range:NSMakeRange(0, [strURL length])];
    
    if ([match rangeAtIndex:1].location != NSNotFound) {
       return  [strURL substringWithRange:[match rangeAtIndex:1]];
    }
    else {
        return @"";
    }
}
+(NSString *)getFullDomainFromURLString:(NSString *) strURL{
    NSString *pattern = @"(https?://)?([a-z0-9-]+?.?[a-z0-9-]+.[a-z]{2,})(/[^s]+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern  options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:strURL options:0 range:NSMakeRange(0, [strURL length])];
    
    if ([match rangeAtIndex:2].location != NSNotFound) {
        return  [strURL substringWithRange:[match rangeAtIndex:2]];
    }
    else {
        return @"";
    }
}
+(NSString *)getPathFromURLString:(NSString *) strURL{
    NSString *pattern = @"(https?://)?([a-z0-9-]+?.?[a-z0-9-]+.[a-z]{2,})/?([^\\s]+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern  options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:strURL options:0 range:NSMakeRange(0, [strURL length])];
    
    if ([match rangeAtIndex:3].location != NSNotFound) {
        return  [strURL substringWithRange:[match rangeAtIndex:3]];
    }
    else {
        return @"";
    }
    
}
+(NSString *)getSubDomainFromURLString:(NSString *) strURL{
    NSString *fullDomain = [self getFullDomainFromURLString:strURL];
    NSLog(@"%@",fullDomain);
    NSInteger times = [[fullDomain componentsSeparatedByString:@"."] count];
    if (times==3){
        return [self detectSubDomain:fullDomain];
        
    }
    else {
        return @"";
        
    }
    
}
+(NSString *)getDomainFromURLString:(NSString *) strURL{
    NSString *fullDomain = [self getFullDomainFromURLString:strURL];
    NSInteger times = [[fullDomain componentsSeparatedByString:@"."] count];
    if (times==3){
        return [self detectDomain:fullDomain];
        
    }
    else {
        return fullDomain;
        
    }
    
}
+(NSString *)detectSubDomain:(NSString *) fullDomain{
    NSString *pattern = @"([a-z0-9-]+).([a-z0-9-.]+)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern  options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:fullDomain options:0 range:NSMakeRange(0, [fullDomain length])];
    
    if ([match rangeAtIndex:1].location != NSNotFound){
        return [fullDomain substringWithRange:[match rangeAtIndex:1]];
    }
    else return @"";
}
+(NSString *)detectDomain:(NSString *) fullDomain{
    NSString *pattern = @"([a-z0-9-]+).([a-z0-9-.]+)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern  options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:fullDomain options:0 range:NSMakeRange(0, [fullDomain length])];
    
    if ([match rangeAtIndex:2].location != NSNotFound){
        return [fullDomain substringWithRange:[match rangeAtIndex:2]];
    }
    else return @"";
}

@end
