//
//  AlertView.h
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"
#import "Button.h"
#import "../Model/JsonModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol  AlertViewProtocol <NSObject>

- (void)cancelAlert;
- (void)saveAfterConfig:(JsonModel *)jsonModel;

@end

@interface AlertView : UIView
@property (nonatomic, weak) id<AlertViewProtocol> delegate;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, strong) JsonModel * parentJsonModel;

@property (nonatomic, strong) UILabel * keyAlertLabel;
@property (nonatomic, strong) UILabel * valueAlertLabel;
@property (nonatomic, strong) TextField * keyTextField;
@property (nonatomic, strong) UITextView * valueTextView;
@property (nonatomic, strong) UILabel * typeAlert;
@property (nonatomic, strong) Button * cancelBtn;
@property (nonatomic, strong) Button * saveBtn;
- (void)updateContentInside:(JsonModel *) jsonModel;


@end

NS_ASSUME_NONNULL_END
