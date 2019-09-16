//
//  MessageCell.h
//  bacsicObjC
//
//  Created by Steve on 9/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../define.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UICollectionViewCell
+ (CGFloat) heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize maxSize:(CGSize) maxSize;
+ (CGFloat) heightOfLabel:(NSString *)lableText;

@end

NS_ASSUME_NONNULL_END
