//
//  groupViewController.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/12/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../View/ContactCell.h"
#import "FeedAPIContact.h"
#import "../../define.h"
#import "../../Utility/UIView+ZBMAutoLayout.h"
#import "../../View/HeaderView.h"
#import "../../Utility/UICollectionView+ScrollItemToTop.h"
#import "../../View/HeaderAlphabet.h"
#import "../../View/CollectionIndexView.h"
#import "NSString+GetLastName.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContactViewController : UIViewController {
    CGFloat heightOfHeader;
    CGFloat maxHeaderHeight ;
    CGFloat minHeaderHeight ;
    CGFloat heightOfBotTitle ;
}

@end

NS_ASSUME_NONNULL_END
