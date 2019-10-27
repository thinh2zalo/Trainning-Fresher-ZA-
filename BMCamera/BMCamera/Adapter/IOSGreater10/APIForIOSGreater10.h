//
//  APIForIOSGreater10.h
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../CameraCore/GetAPIProtocol.h"
#import "../../CameraCore/CameraCore.h"
NS_ASSUME_NONNULL_BEGIN

@interface APIForIOSGreater10 : NSObject <GetAPIProtocol>
@property (nonatomic) dispatch_queue_t queue;

@end

NS_ASSUME_NONNULL_END
