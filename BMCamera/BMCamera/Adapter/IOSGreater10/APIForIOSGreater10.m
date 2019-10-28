//
//  APIForIOSGreater10.m
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "APIForIOSGreater10.h"
#import "../../CameraCore/CameraViewDelegate.h"
#import "../../View/CameraView.h"
@interface APIForIOSGreater10()
@property (nonatomic, strong) NSMutableDictionary * progressPhotoCaptureProcessorsDict;

@end

@implementation APIForIOSGreater10

- (AVCaptureDevice *) getCaptureDeviceWithPostion:(BMCamPosition) position API_AVAILABLE(ios(10.0)){
    AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                                                                                                            mediaType:AVMediaTypeVideo
                                                                                                                             position:(AVCaptureDevicePosition)position];
    NSArray *arrayCaptureDevices = [captureDeviceDiscoverySession devices];
    if (arrayCaptureDevices.count > 0) {
        
        return arrayCaptureDevices.firstObject;
    }
    return nil;
}


- (void)capturePhoto:(AVCaptureOutput *) capturePhotoOutput photoCaptureOptions:(struct photoCaptureOptions) options handlerAfterCapture:(handlerAfterCapture) handlerAfterCapture  API_AVAILABLE(ios(10.0)) {
    AVCapturePhotoOutput * photoOutput = (AVCapturePhotoOutput *) capturePhotoOutput ;
    AVCapturePhotoSettings * setting = AVCapturePhotoSettings.new;
    if (photoOutput) {
        PhotoCaptureProcessor  __block * processor = [[PhotoCaptureProcessor alloc]initWithUniqueID:setting.uniqueID photoCaptureOptions:options willCapturePhotoAnimation:^{
            
        } andCompleteHandler:^(PhotoCaptureProcessor * processor, UIImage * image) {
            dispatch_async(self.queue, ^{
                [self.progressPhotoCaptureProcessorsDict removeObjectForKey:[NSNumber numberWithUnsignedLongLong:processor.uniqueID]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    handlerAfterCapture(image);
                });
            });
        }];
        [self.progressPhotoCaptureProcessorsDict setObject:processor forKey:[NSNumber numberWithUnsignedLongLong:processor.uniqueID]];
        [photoOutput capturePhotoWithSettings:setting delegate:processor];
    }
}


- (AVCapturePhotoOutput *)getCaptureOutput API_AVAILABLE(ios(10.0)){
    return AVCapturePhotoOutput.new;
}


- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("bm.camera.captureProcess", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}

- (NSMutableDictionary *)progressPhotoCaptureProcessorsDict {
    if (!_progressPhotoCaptureProcessorsDict) {
        _progressPhotoCaptureProcessorsDict = NSMutableDictionary.new;
    }
    return _progressPhotoCaptureProcessorsDict;
}

@end
