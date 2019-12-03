//
//  ViewController.m
//  JsonEditorTool
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ViewController.h"
#import "View/HomeView.h"
#import "Define.h"
#import "Model/Container.h"
#import "Network/NetworkManager.h"
#import "Model/DictContainer.h"
@interface ViewController ()
@property (nonatomic, strong) HomeView * homeView;
@property (nonatomic, strong) NSDictionary * dict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * dict = NSDictionary.new;
    self.homeView.frame = CGRectMake(0, 0, SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);
    NSURL * url = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NetworkManager.shareInstance request:request completion:^(id  _Nullable response, NSString * _Nullable errorMsg){
        
        if ([response isKindOfClass:NSDictionary.class]) {
            
            self->_dict = [NSDictionary dictionaryWithDictionary:response];
//            Container * container = [[Container alloc]  initWithDict:response andKey:@"thi container"];

            DictContainer * container = [[DictContainer alloc] initWithObject:response andKey:@"thi"];
            NSLog(@"%@", container);
           
        } else {
            
        }
        
    }];
   
}


- (NSDictionary *)dict {
    if (!_dict) {
        _dict = NSDictionary.new;
    }
    return _dict;
}

- (HomeView *)homeView {
    if (!_homeView) {
        _homeView = HomeView.new;
        [self.view addSubview:_homeView];
    }
    return _homeView;
}




@end
