//
//  Person.m
//  testJM
//
//  Created by Steve on 12/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "Person.h"

@implementation Person
- initWithDict:(NSDictionary * ) dict {
    self = [super init];
    if (self) {
        
        self.countryModel = [[CountryModel alloc] initWithDict:[dict objectForKey:@"countryModel"]];

    }
    return self;
    
}
@end
