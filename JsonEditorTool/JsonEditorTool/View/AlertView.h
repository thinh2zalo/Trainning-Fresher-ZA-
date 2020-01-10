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

//#import "AlertController.h"
#import "../Model/JsonModel.h"
NS_ASSUME_NONNULL_BEGIN

@class AlertView;
@class AlertController;


typedef NS_ENUM(NSInteger, TypeEditJson){
    ktypeAddNewJson,
    ktypeEditNameJson,
    ktypeEditJson
};

@protocol AlertViewProtocol <NSObject>

- (void)cancelAlert:(AlertView *)alertView;
- (void)performUpdate:(AlertView *) alertView;

@end

@interface AlertView : UIView
@property (nonatomic, assign) id <AlertViewProtocol> delegate;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, strong) JsonModel * parentJsonModel;
@property (nonatomic, strong) JsonModel * JSNew;
@property (nonatomic, assign) TypeEditJson  typeEditJson;
@property (nonatomic, strong) UILabel * keyAlertLabel;
@property (nonatomic, strong) UILabel * valueAlertLabel;
@property (nonatomic, strong) TextField * keyTextField;
@property (nonatomic, strong) UITextView * valueTextView;
@property (nonatomic, strong) UILabel * typeAlert;
@property (nonatomic, strong) UILabel * errorLable;
@property (nonatomic, strong) AlertController * alertController;
@property (nonatomic, strong) JsonModel * JSOld;
@property (nonatomic, strong) Button * cancelBtn;
@property (nonatomic, strong) Button * saveBtn;
- (void)updateContentInside:(JsonModel *) jsonModel withAlert:(NSString*)typeAlert;


@end

NS_ASSUME_NONNULL_END
