//
//  CollectionIndexView.h
//  SimpleMessage
//
//  Created by Steve on 10/1/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Utility/UIView+ZBMAutoLayout.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CollectionIndexViewDelegate <NSObject>
- (void) moveContentToIndexPath:(NSIndexPath*) indexPath;

@end
@interface CollectionIndexView : UIView

@property (nonatomic, weak) id <CollectionIndexViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray <UILabel *> * arrAlphabeticalScroll;
- (void)setupWithIndexTitles:(NSArray <NSString *> *)indexTitles;


@end

NS_ASSUME_NONNULL_END
