//
//  ContainerCellTableViewCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#define PADDING 20

#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CELL_WIDTH (SCREEN_MAIN_WIDTH - 2 * PADDING)
#define CELL_HEIGHT ((SCREEN_MAIN_HEIGHT/10) * 4)

#import <UIKit/UIKit.h>
#import "../ParseJsonForAPost/ContentModel.h"
#import "../compareTimeStamp/NSString+CompareTimeStamp.h"
#import "../ListFramePost_UsingNavigation/ConnectData.h"
#import "../ParseJsonForAPost/DataModel.h"

NS_ASSUME_NONNULL_BEGIN
@class BigListContainerCell;
@protocol BigListContainerCellDelegate <NSObject>
-(void)onTouched:(BigListContainerCell *)containerView;
@required


@end

@interface BigListContainerCell : UITableViewCell
@property (nonatomic, strong) UIImageView * thumnailImg;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * timeLab;
@property (nonatomic, weak) id<BigListContainerCellDelegate> delegate;
- (void)updateContentInsideContainerView:(Content *)content;
@end

NS_ASSUME_NONNULL_END
