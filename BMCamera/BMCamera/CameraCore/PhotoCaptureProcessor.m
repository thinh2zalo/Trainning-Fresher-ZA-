//
//  PhotoCaptureProcessor.m
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "PhotoCaptureProcessor.h"

@implementation PhotoCaptureProcessor

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error  API_AVAILABLE(ios(11.0)){
    dispatch_async(self.queue, ^{
        
    });
}

- (void)captureOutput:(AVCapturePhotoOutput *)output willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings  API_AVAILABLE(ios(10.0)){
    
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error  API_AVAILABLE(ios(10.0)){
    
}

- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("bm.camera.processor", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}
@end
