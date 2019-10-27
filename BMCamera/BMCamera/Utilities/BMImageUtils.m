//
//  BMImageUtils.m
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "BMImageUtils.h"
#import "../View/CameraView.h"
#import "../Define.h"

@implementation BMImageUtils

+ (UIImageOrientation)imageOrientationWithInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation posCam:(BMCamPosition)posCam {
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            if (posCam == kBMCamPositionBack) {
                return UIImageOrientationLeft;
            } else {
                return SYSTEM_VERSION_LESS_THAN(@"11") ? UIImageOrientationLeftMirrored : UIImageOrientationRightMirrored;
            }
            
        case UIInterfaceOrientationLandscapeLeft:
            return posCam == kBMCamPositionBack ? UIImageOrientationDown : UIImageOrientationUpMirrored;
        case UIInterfaceOrientationLandscapeRight:
            return posCam == kBMCamPositionBack ? UIImageOrientationUp : UIImageOrientationDownMirrored;
        case UIInterfaceOrientationPortrait:
            if (posCam == kBMCamPositionBack) {
                return UIImageOrientationRight;
            } else {
                return SYSTEM_VERSION_LESS_THAN(@"11") ? UIImageOrientationRightMirrored : UIImageOrientationLeftMirrored;
            }

        default:
           return  UIImageOrientationUp;
    }
}
+ (UIImage *)finalizeUIImage:(CGImageRef )cgImage andOptions:(struct photoCaptureOptions) options {
    // cut and
    CGSize originalSize = CGSizeMake((CGFloat)CGImageGetWidth(cgImage), (CGFloat)CGImageGetHeight(cgImage));
    
    CGSize previewSize = [self getSizeBaseOnRatio:originalSize ratio:options.ratio];
    NSLog(@"originalSize w:%f, h:%f", originalSize.width, originalSize.height);
    NSLog(@"previewSize w:%f, h:%f", previewSize.width, previewSize.height);
    CGImageRef finalCGImage = NULL;
    finalCGImage =  CGImageCreateWithImageInRect(cgImage, CGRectMake(0, 0, previewSize.width, previewSize.height));

    UIImage * img = [UIImage imageWithCGImage:finalCGImage scale:1.0 orientation:[BMImageUtils imageOrientationWithInterfaceOrientation:options.interfaceOrientation posCam:options.camPos]];
    NSLog(@"width %f height  %f", img.size.width, img.size.height );
    return  img;

}

+ (CGSize )getSizeBaseOnRatio:(CGSize) size ratio:(BMRatioCamera)ratio {
    float height = size.height;
    float width = size.width;
    switch (ratio) {
        case kBMTHREE_FOUR: return CGSizeMake(width, (width / 3 ) * 4);
        
        case kBMFULL: return CGSizeMake(width, height);
            
        default: return CGSizeMake(width, width);
    }
    
    
}

@end
