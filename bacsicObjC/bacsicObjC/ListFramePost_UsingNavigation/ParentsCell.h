//
//  AllKindOfCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#import "../compareTimeStamp/NSString+CompareTimeStamp.h"
#import <UIKit/UIKit.h>
#import "../ParseJsonForAPost/ContentModel.h"
#define PADDING 20
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CELL_WIDTH (SCREEN_MAIN_WIDTH - 2 * PADDING)
#define CELL_HEIGHT_BIG_IMG (((SCREEN_MAIN_WIDTH - 2 * PADDING) / 16) * 9)
#define SPACE 20.0
#define WITDTH_IMG 120.0
#define HEIGHT_IMG 80.0
#define WITDTH_LAB 100.0
#define HEIGHT_LAB 80.0
#define HEIGHT_TIMESTAMP 10
#define WIDTH_TIMESTAMP 100
#define CELL_SINGLE_IMG 120.0
#define CELL_THREE_IMG 200
#define WIDTH_VIEW 400.0


//#define CELL_THREE_IMG_HEIGHT

NS_ASSUME_NONNULL_BEGIN

@class ParentsCell;
@protocol ParentsCellDelegate <NSObject>
@required
-(void)onTouched:(ParentsCell *)containerView;
@end

@interface ParentsCell : UITableViewCell
@property  (nonatomic) float spaceOfTitle ;
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
