//
//  FeedAPI.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/27/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConnectData.h"
#import "MainViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^BlockCall)(void);
@protocol FeedAPIDelegate <NSObject>

@required
- (void)updateArrContents: (NSArray <Content *> *)content;

@end

@interface FeedAPI : NSObject

@property (nonatomic, weak) id<FeedAPIDelegate> delegate;
- (void)callAPI;
@end

NS_ASSUME_NONNULL_END
