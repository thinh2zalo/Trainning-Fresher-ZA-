//
//  Hobby.h
//  testJM
//
//  Created by Steve on 12/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FreeTime.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hobby : JSONModel
@property (nonatomic, strong) NSArray <FreeTime *>  * arrFreeTime;
@property (nonatomic, strong) NSString * nameHobby;
@property (nonatomic, strong) NSString * typeHobby;
@end

NS_ASSUME_NONNULL_END
