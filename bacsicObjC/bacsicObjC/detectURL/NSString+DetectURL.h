//
//  NSString+DetectURL.h
//  ExampleRegex
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (DetectURL)
+(NSString *)getShemeFromURLString:(NSString *) strURL;
+(NSString *)getSubDomainFromURLString:(NSString *) strURL;
+(NSString *)getDomainFromURLString:(NSString *) strURL;
+(NSString *)getPathFromURLString:(NSString *) strURL;
//+(NSString *)getFullDomainFromURLString:(NSString *)strURL
@end

NS_ASSUME_NONNULL_END
