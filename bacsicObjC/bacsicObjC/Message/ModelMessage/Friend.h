//
//  Friend.h
//  bacsicObjC
//
//  Created by Steve on 9/17/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Friend : NSObject
@property (nonatomic) NSInteger friendID;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSURL * avatarUrl;
@property (nonatomic) BOOL  isAvailable;

@end

NS_ASSUME_NONNULL_END
