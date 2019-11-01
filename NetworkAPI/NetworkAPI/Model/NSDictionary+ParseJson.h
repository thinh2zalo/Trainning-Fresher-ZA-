//
//  NSDictionary+DictCategory.h
//  categoryExample
//
//  Created by CPU11606 on 8/6/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ParseJson)
- (NSString *)getNSString:(NSString *) strKey;
- (NSArray *)getNSArray:(NSString *) arrKey;
- (NSNumber *)getNSNumber:(NSString *) numberKey;
- (NSString *)getTitle;
- (NSURL *)getURL;
- (NSURL *)getNSURLWithString:(NSString *) URL;
@end

NS_ASSUME_NONNULL_END
