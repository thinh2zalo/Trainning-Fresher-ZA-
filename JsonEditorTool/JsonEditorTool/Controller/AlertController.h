//
//  JMAlertController.h
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "JsonModel.h"
#import "../View/AlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlertController : UIViewController
@property (nonatomic, strong) AlertView * alertView;
- (void)fadeOut;

- (void)showAlert:(UIViewController *)viewController withJsonModel:(nullable JsonModel *) jsonModel;
@end

NS_ASSUME_NONNULL_END
