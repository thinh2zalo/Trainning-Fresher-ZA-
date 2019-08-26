//
//  AllKindOfCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#import "../compareTimeStamp/NSString+CompareTimeStamp.h"
#import <UIKit/UIKit.h>
#import "Define.h"
#import "../ParseJsonForAPost/ContentModel.h"



NS_ASSUME_NONNULL_BEGIN

@class ParentsCell;
@protocol ParentsCellDelegate <NSObject>
@required
-(void)onTouched:(ParentsCell *)containerView;
@end

@interface ParentsCell : UITableViewCell
@property  (nonatomic) float spaceBetweentElement ;
@property (nonatomic) NSInteger contentID;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel *timeStampLab;
@property (nonatomic, strong) UIImageView * thumbnailImg;

+ (CGFloat) heightOfLabel:(NSString *)lableText;
+ (CGFloat) heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize maxSize:(CGSize) maxSize ;
- (void)updateContentInsideCell:(Content *)content;

@end


NS_ASSUME_NONNULL_END
