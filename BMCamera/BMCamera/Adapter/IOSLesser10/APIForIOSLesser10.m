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
- (AVCaptureStillImageOutput *)getCaptureOutput{
    return AVCaptureStillImageOutput.new;
}

- (void)capturePhoto:(AVCaptureOutput *) capturePhotoOutput photoCaptureOptions:(struct photoCaptureOptions) options {
    AVCaptureConnection  * connection = [capturePhotoOutput connectionWithMediaType:AVMediaTypeVideo];
    if (connection) {
        AVCaptureStillImageOutput * photoOutput = (AVCaptureStillImageOutput *) capturePhotoOutput ;
        [photoOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer,  NSError *error){
            if (error == nil) {
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                UIImage *takenImage = UIImage.new;
                
                if (imageData) {
                    CGDataProviderRef  dataProvider = CGDataProviderCreateWithCFData((CFDataRef)imageData);
                    if (dataProvider) {
                        CGImageRef cgImage = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault);
                        takenImage = [BMImageUtils finalizeUIImage:cgImage andOptions:options];
                        
                    }
                }
            }
        }];
    }
}

@end
