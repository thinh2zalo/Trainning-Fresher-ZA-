//
//  CountryModel.h
//  testJM
//
//  Created by Steve on 12/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryModel : NSObject
@property (nonatomic) NSInteger ID;
@property (nonatomic) NSString *country;
- initWithDict:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
