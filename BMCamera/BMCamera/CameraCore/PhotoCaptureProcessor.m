//
//  PhotoCaptureProcessor.m
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "PhotoCaptureProcessor.h"
#import "../Utilities/BMImageUtils.h"



@interface PhotoCaptureProcessor()
typedef void(^BlockOfBackground)(PhotoCaptureProcessor * photoCaptureProcessor);

@end

@implementation PhotoCaptureProcessor


- (instancetype)initWithUniqueID:(int64_t) uniqueID photoCaptureOptions:(struct photoCaptureOptions) options willCapturePhotoAnimation:(willCapturePhotoAnimation)willCapturePhotoAnimation  andCompleteHandler:(completeHandler) completeHandler {
    self = [super init];
    if (self) {
        _uniqueID = uniqueID;
        _photoCaptureOptions = options;
        _willCapturePhotoAnimation = willCapturePhotoAnimation;
        _completeHandler = completeHandler;
    }
    return self;
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error  API_AVAILABLE(ios(11.0)){
    [self async:^(PhotoCaptureProcessor * photoCaptureProcessor) {
        if (error == nil) {
            CGImageRef cgImage = [photo CGImageRepresentation];
            if (cgImage) {
                photoCaptureProcessor.completeHandler(photoCaptureProcessor,[BMImageUtils finalizeUIImage:cgImage andOptions:photoCaptureProcessor.photoCaptureOptions]);
            } else {
                photoCaptureProcessor.completeHandler(photoCaptureProcessor, UIImage.new);
            }
        }
    }];
}

- (void)captureOutput:(AVCapturePhotoOutput *)output willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings  API_AVAILABLE(ios(10.0)){
    [self async:^(PhotoCaptureProcessor * photoCaptureProcessor) {
        if (photoCaptureProcessor.willCapturePhotoAnimation) {
                photoCaptureProcessor.willCapturePhotoAnimation();
            }
    }];
    
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error  API_AVAILABLE(ios(10.0)){
    [self async:^(PhotoCaptureProcessor * photoCaptureProcessor) {
        if (error == nil) {
            NSData *imageData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:nil];
            if (imageData) {
                CGDataProviderRef  dataProvider = CGDataProviderCreateWithCFData((CFDataRef)imageData);
                if (dataProvider) {
                    CGImageRef cgImage = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault);
                    photoCaptureProcessor.completeHandler(photoCaptureProcessor, [BMImageUtils finalizeUIImage:cgImage andOptions:self.photoCaptureOptions]);
                    return;
                }
            }
        }
        self.completeHandler(self, UIImage.new);
    }];
 
}

- (void)async:(BlockOfBackground)blockOfBackground {
    PhotoCaptureProcessor * __weak weakSelf = self;
    dispatch_async(weakSelf.queue, ^(void){
        if (weakSelf) {
            blockOfBackground(weakSelf);
        } else {
            NSLog(@"CamneraView has been deallocated in the meantime.");
        }
    });
}

- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("bm.camera.processor", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}
@end
