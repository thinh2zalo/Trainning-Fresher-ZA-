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
NS_ASSUME_NONNULL_BEGIN

@interface InforJsonCell : UICollectionViewCell
@property (nonatomic, strong)  UILabel * keyLable;
@property (nonatomic, strong)  UILabel * typeValueLabel;
@property (nonatomic, strong)  UILabel * valueLabel;
- (void) updateContentInsideCell:(JsonModel *)jsonModel;

@end

NS_ASSUME_NONNULL_END
