//
//  Person.h
//  testJM
//
//  Created by Steve on 12/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Hobby.h"
#import "CountryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
//@property (nonatomic, strong) NSArray <FreeTime *> *arrFreeTime;
@property (nonatomic, strong)  CountryModel * countryModel;
//@property (nonatomic, strong) NSString *firstName;
//@property (nonatomic, strong) NSString *lastName;
//@property (nonatomic, strong) NSNumber *age;
- initWithDict:(NSDictionary * ) dict;
@end

NS_ASSUME_NONNULL_END
