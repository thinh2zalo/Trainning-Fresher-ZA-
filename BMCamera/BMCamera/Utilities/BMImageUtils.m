//
//  BMImageUtils.m
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "BMImageUtils.h"
#import "../View/CameraView+Execute.h"
#import "../View/CameraView.h"

@implementation BMImageUtils
+ (UIImage *) finalizeUIImage:(UIImage *)image andOptions:(struct photoCaptureOptions)options {
    CGImageRef  cgImage = image.CGImage;
    CGSize previewSize;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        previewSize = [CameraView getPreviewSize];
    }
    CGRect cropRect = CGRectMake(0, 0, CGImageGetWidth(cgImage), CGImageGetHeight(cgImage));
    CGRect croppedSize = AVMakeRectWithAspectRatioInsideRect(previewSize, cropRect);
    image = [BMImageUtils cropImage:image toRect:croppedSize];
    return image;
}

+ (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect
{
    CGImageRef takenCGImage = image.CGImage;
    CGImageRef cropCGImage = CGImageCreateWithImageInRect(takenCGImage, rect);
    image = [UIImage imageWithCGImage:cropCGImage scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(cropCGImage);
    return image;
}

+ (NSString *)writeImage:(NSData *)image toPath:(NSString *)path
{
    [image writeToFile:path atomically:YES];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    return [fileURL absoluteString];
}
@end
