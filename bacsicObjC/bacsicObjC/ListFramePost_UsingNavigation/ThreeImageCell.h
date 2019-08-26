

#import "ParentsCell.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreeImageCell : ParentsCell
@property (nonatomic, strong) UIImageView * centerImg;
@property (nonatomic, strong) UIImageView * rightImg;
+ (float) heightOfCell:(NSString *)labelText;
@end

NS_ASSUME_NONNULL_END
