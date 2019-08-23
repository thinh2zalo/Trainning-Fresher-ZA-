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
#import "RootViewController.h"

#define PADDING 20

#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CELL_WIDTH (SCREEN_MAIN_WIDTH - 2 * PADDING)
#define CELL_HEIGHT_BIG_IMG ((SCREEN_MAIN_HEIGHT/10) * 4)
#define SPACE 20.0
#define WITDTH_IMG 120.0
#define HEIGHT_IMG 80.0
#define WITDTH_LAB 100.0
#define HEIGHT_LAB 80.0
#define HEIGHT_TIMESTAMP 20
#define WIDTH_TIMESTAMP 100
#define HEIGHT_VIEW 100.0
#define WIDTH_VIEW 400.0
#define HEIGHT_TIMESTAMP 20

#define HEIGHT_THREE_IMG  (HEIGHT_VIEW + HEIGHT_TIMESTAMP + HEIGHT_LAB)

#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height
NS_ASSUME_NONNULL_BEGIN

@class AllKindOfCell;
@protocol AllKindOfCellDelegate <NSObject>
@required
-(void)onTouched:(AllKindOfCell *)containerView;
@end

@interface ParentsCell : UITableViewCell
@property (nonatomic) NSInteger contentID;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel *timeStampLab;
@property (nonatomic, strong) UIImageView * thumbnailImg;


- (void)updateContentInsideCell:(Content *)content;

@end


NS_ASSUME_NONNULL_END
