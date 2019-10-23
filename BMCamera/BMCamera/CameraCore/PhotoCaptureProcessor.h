//
//  PhotoCaptureProcessor.h
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCaptureProcessor : NSObject <AVCapturePhotoCaptureDelegate>

@property (nonatomic) dispatch_queue_t queue;

@end

NS_ASSUME_NONNULL_END
