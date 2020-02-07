//
//  ViewController.m
//  JsonEditorTool_BM
//
//  Created by vincent on 1/15/20.
//  Copyright © 2020 vincent. All rights reserved.
//
#import "ManagerRecord.h"
#import "NetworkManager.h"
#import "ViewController.h"
#import "EndPoint.h"
#import "LunarSolarCalendarConverter.h"

@interface ViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EndPoint * endPoint = EndPoint.new;
    endPoint.osStr = @"ios";
    endPoint.verStr = @"99.99.99";
    
    [ManagerRecord.shareInstance setEndpoint:endPoint];
    [self.indicator startAnimating];
    [ManagerRecord.shareInstance start:^(JsonModel * response, NSString * errorMSG) {
        [self.indicator setHidden:YES];
        if (!errorMSG) {
            JsonModel * modelToShow = [ManagerRecord.shareInstance fetchJsonModel:@"settings"];
            [ManagerRecord.shareInstance setCurrentJsonModelWithKey:@"settings"];
            JsonModel *JMM  = [ManagerRecord.shareInstance  fetchJsonModel:@"settings.applicationId"];
         
        } else {
            // handle error
        }
    }];
   
    
}


- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.hidden = NO;
        [self.view addSubview:_indicator];
    }
    return _indicator;
}
    
//    [ManagerRecord.shareInstance removeModelFormTableName:@"stub" andKey:@"stub" andCompletion:^(id results){
//        NSLog(@"count : %tu", [(NSMutableArray *)results count]) ;
//    }];

    

    
    



@end
