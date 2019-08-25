

#define HEIGHT_TEXTVIEW 100.0
#define WIDTH_TEXTVIEW 400.0
#define HEIGHT_BTN 30
#define WIDTH_BTN 90
#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]


#import "../ParseJsonForAPost/DataModel.h"
#import "SecondViewController.h"
#import "ConnectData.h"
#import "../ParseJsonForAPost/ContentModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BigImageCell.h"
#import "SingleImageCell.h"
#import "ThreeImageCell.h"

NS_ASSUME_NONNULL_BEGIN

#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NAV_HEIGHT 44



@interface TwoKindOfCellVC : UIViewController


@end

NS_ASSUME_NONNULL_END
