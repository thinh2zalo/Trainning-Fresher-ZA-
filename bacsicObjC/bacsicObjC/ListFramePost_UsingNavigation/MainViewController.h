



#import "../ParseJsonForAPost/DataModel.h"
#import "SecondViewController.h"
#import "ConnectData.h"
#import "../ParseJsonForAPost/ContentModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FeedAPI.h"
#import "BigImageCell.h"
#import "SingleImageCell.h"
#import "ThreeImageCell.h"

NS_ASSUME_NONNULL_BEGIN

#define ThreeImageCellIdenti @"ThreeImageCell"
#define SingleImageCellIdenti @"SingleImageCell"
#define BigImageCellIdenti @"BigImageCell"




@interface MainViewController : UIViewController


- (void)getDataBack:(SecondViewController *)dataInsideSecond;

@end

NS_ASSUME_NONNULL_END
