//
//  CountryModel.m
//  testJM
//
//  Created by Steve on 12/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel
- initWithDict:(NSDictionary *) dict {
    self = [super init];
    if (self) {
        self.ID = [[dict objectForKey:@"ID"] integerValue];
        self.country = [dict objectForKey:@"country"];
    }
    return self;
}
@end
