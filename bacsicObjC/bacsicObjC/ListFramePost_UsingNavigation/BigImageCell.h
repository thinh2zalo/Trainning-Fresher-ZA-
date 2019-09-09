//
//  ContainerCellTableViewCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ParentsCell.h"


NS_ASSUME_NONNULL_BEGIN

@interface BigImageCell : ParentsCell

+ (float) heightOfCell:(NSString *) labelText;
+ (float)heightOfCellLandscape:(NSString *) labelText;
@end



NS_ASSUME_NONNULL_END
