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
   
    self.indicator.frame= CGRectMake(50,
       100,40,40);
    [self.indicator startAnimating];
    [ManagerRecord.shareInstance start:^(NSMutableArray <JsonModel *> * response) {
        [self.indicator setHidden:YES];
        if (response) {
    
            [ManagerRecord.shareInstance removeModelFormTableName:@"settings" andKey:@"applicationId" andCompletion:^(NSMutableArray <JsonModel *>*  results){
            }];
            JsonModel *jm = [JsonModelFactory getJsonModel:@"value" andKey:@"key"];
            [ManagerRecord.shareInstance insertJsonModel:jm inTableName:@"settings" completion:^(NSMutableArray <JsonModel *>*  results){
                
            }];
            
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
