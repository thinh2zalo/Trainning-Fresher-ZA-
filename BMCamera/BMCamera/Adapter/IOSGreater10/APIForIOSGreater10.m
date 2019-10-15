//
//  APIForIOSGreater10.m
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "APIForIOSGreater10.h"

@implementation APIForIOSGreater10

- (AVCaptureDevice *) getCaptureDeviceWithPostion:(BMCamPosition) position {
    AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                                                                                                            mediaType:AVMediaTypeVideo
                                                                                                                             position:(AVCaptureDevicePosition)position];
    NSArray *arrayCaptureDevices = [captureDeviceDiscoverySession devices];
    if (arrayCaptureDevices.count > 0) {
        return arrayCaptureDevices.firstObject;
    }
    return nil;
}
@end
