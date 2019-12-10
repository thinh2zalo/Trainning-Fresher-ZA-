//
//  freeTime.h
//  testJM
//
//  Created by Steve on 12/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface FreeTime : JSONModel
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * location;
@end

NS_ASSUME_NONNULL_END
