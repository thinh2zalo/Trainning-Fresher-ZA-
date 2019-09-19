//
//  MessageCell.h
//  bacsicObjC
//
//  Created by Steve on 9/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ModelMessage/Message.h"
#import "../define.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UICollectionViewCell
+ (CGSize) heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize maxSize:(CGSize) maxSize;
+ (CGFloat) heightOfLabel:(NSString *)lableText;
+ (CGFloat) widthOfLabel:(NSString *)lableText;

- (void) updateDataForCell:(Message *) message;

@end

NS_ASSUME_NONNULL_END
