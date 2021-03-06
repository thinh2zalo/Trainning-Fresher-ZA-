//
//  InforJSonCell.h
//  JsonEditorTool
//
//  Created by Steve on 12/4/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../Model/JsonModel.h"
#import "../View/AlertView.h"
#import "JETCell.h"
#import "../SwipeCell/SwipeCellKit/ZASwipeCellKit.h"
NS_ASSUME_NONNULL_BEGIN
@protocol InformationCellDelegate <NSObject>

- (void)deleteJson:(JsonModel *)js;

@end
@interface InforJsonCell : JETCell

@property (nonatomic, strong)  UILabel * keyLable;
@property (nonatomic, strong)  UILabel * typeValueLabel;
@property (nonatomic, strong)  UILabel * valueLabel;
@property (nonatomic, strong)  id<InformationCellDelegate>  delegate;
@property (nonatomic, strong)  UILabel * hierarchiLabel;


- (void) updateContentInsideCell:(JsonModel *)jsonModel isSearching:(BOOL) isSearching;



@end

NS_ASSUME_NONNULL_END
