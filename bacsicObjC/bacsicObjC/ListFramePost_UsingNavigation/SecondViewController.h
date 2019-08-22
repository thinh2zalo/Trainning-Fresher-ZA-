


#define HEIGHT_TEXTVIEW 100.0
#define WIDTH_TEXTVIEW 400.0

#define HEIGHT_BTN 30
#define WIDTH_BTN 90
#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ContainerCell.h"
NS_ASSUME_NONNULL_BEGIN
@class SecondViewController;
@protocol PassDataBack <NSObject>

@required
- (void)getDataBack:(SecondViewController *)dataInsideSecond;

@end
@interface SecondViewController : UIViewController
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, weak) id<PassDataBack> delegate;

@end

NS_ASSUME_NONNULL_END
