//
//  HomeView.m
//  JsonEditorTool
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "HomeView.h"
#import "../Define.h"
#import "TextField.h"

@interface HomeView()

@end
@implementation HomeView

- (void)layoutSubviews {
    float padding = 50;
    self.backgroundColor = [UIColor whiteColor];
//    self.oSVField.frame = CGRectMake(padding, SCREEN_MAIN_HEIGHT/3, (SCREEN_MAIN_WIDTH - 3 * padding) /2, 50);
    self.verField.frame = CGRectMake(self.oSVField.frame.origin.x +   self.oSVField.frame.size.width + padding, self.oSVField.frame.origin.y, 200, 50);
    self.verField.center =  CGPointMake(self.frame.size.width/2, self.frame.size.height/3);
    self.commitBtn.frame = CGRectMake(padding,  self.oSVField.frame.origin.y + 50 + padding, (SCREEN_MAIN_WIDTH - 3 * padding) /2, 50);


}



-(void) loadDataForMainScreen {
    [self.delegate loadData];
}

- (TextField *)oSVField {
    if (!_oSVField) {
        _oSVField = UITextField.new;
        _oSVField.backgroundColor = [UIColor redColor];
        [self addSubview:_oSVField];
    }
    return _oSVField;
}

- (TextField *)verField {
    if (!_verField) {
        _verField = TextField.new;
//        _verField.backgroundColor = [UIColor redColor];
        [self addSubview:_verField];
    }
    return _verField;
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = UIButton.new;
        _commitBtn.backgroundColor = [UIColor redColor];
        [_commitBtn addTarget:self action:@selector(loadDataForMainScreen) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitBtn];
    }
    return _commitBtn;
}



@end
