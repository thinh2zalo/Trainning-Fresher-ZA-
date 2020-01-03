//
//  ViewController.h
//  JsonEditorTool
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Model/DictionaryJM.h"
#import "../View/AlertView.h"

@interface JETViewController : UIViewController  <AlertViewProtocol>
@property (nonatomic, strong) JsonModel * jsonModel;


@end

