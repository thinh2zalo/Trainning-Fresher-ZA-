//
//  CameraViewDelegate.h
//  BMCamera
//
//  Created by Steve on 10/24/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CameraViewDelegate <NSObject>
- (void)onCaptured:(UIImage *) image;
@end

NS_ASSUME_NONNULL_END
