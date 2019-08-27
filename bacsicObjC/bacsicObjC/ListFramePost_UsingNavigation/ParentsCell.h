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

#define HEIGHT_TIMESTAMP 10
#define WIDTH_TIMESTAMP 100
#define SPACE_BETWEEN_THREE_IMG 10
#define SPACE_THUMBNAIL_LABEL 10
#define ALIGN_TOP 20
#define ALIGN_LEFT 20
#define ALIGN_RIGHT 20


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
