//
//  APIForIOSLesser10.m
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "APIForIOSLesser10.h"
#import "../../Utilities/BMImageUtils.h"

@interface APIForIOSLesser10()
@end

@implementation APIForIOSLesser10 


- (AVCaptureDevice *) getCaptureDeviceWithPostion:(BMCamPosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
      for (AVCaptureDevice *device in devices) {
            if ([device position] == (AVCaptureDevicePosition) position)
                return device;
        }

    return nil;
}

- (AVCaptureStillImageOutput *)getCaptureOutput:(struct photoCaptureOptions)options {
    AVCaptureStillImageOutput * photoOutput = AVCaptureStillImageOutput.new;
    AVCaptureConnection  * connection = [photoOutput connectionWithMediaType:AVMediaTypeVideo];
    if (connection) {
        [photoOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer,  NSError *error){
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *takenImage = [UIImage imageWithData:imageData];
            takenImage = [BMImageUtils finalizeUIImage:takenImage andOptions:options];
            
            
        }];
    }
    return photoOutput;
 
}



@end
