//
//  RootMesViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "RootMesViewController.h"

@interface RootMesViewController () < UITabBarControllerDelegate , UITableViewDataSource , UITableViewDelegate, UITabBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <ConversationModel *> *arrConversations;
@property (nonatomic, strong) UITabBar * tabBar;
@property (nonatomic, strong) GroupViewController *groups;
@property (nonatomic, strong) MessageViewController *message;


@end

@implementation RootMesViewController


- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.view.frame =  CGRectMake(0, KEY_WINDOW_SAFE_AREA_INSETS.top, SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT - KEY_WINDOW_SAFE_AREA_INSETS.top);

    [self switchToViewController:self.message];
    self.tabBar.frame = CGRectMake(0, SCREEN_MAIN_HEIGHT - TABBAR_HEIGHT, SCREEN_MAIN_WIDTH,   TABBAR_HEIGHT);
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    switch (item.tag) {
        case 1:
            [self switchToViewController:self.message];

            break;
        case 2:
            [self switchToViewController:self.groups];
            break;
      
        default:
            break;
    }
}

- (void)switchToViewController:(UIViewController *)toVC {
    if (toVC != nil) {
        [self addChildViewController:toVC];

        [toVC willMoveToParentViewController:self];
        
        [self.view addSubview:toVC.view];
        toVC.view.frame = CGRectMake(0, 0, SCREEN_MAIN_WIDTH ,SCREEN_MAIN_HEIGHT - TABBAR_HEIGHT );

        [toVC didMoveToParentViewController:self];
    }
}

- (MessageViewController *)message {
    if (!_message) {
        
        _message = MessageViewController.new;
    }
    return _message;
}
- (GroupViewController *)groups {
        if (!_groups) {
            _groups = GroupViewController.new;

        }
        return _groups;

}


- (UITabBar *)tabBar {
    if (!_tabBar) {
        _tabBar = UITabBar.new;
        _tabBar.delegate = self;
        _tabBar.translatesAutoresizingMaskIntoConstraints = false;
        
        [_tabBar setItems:@[[[UITabBarItem alloc] initWithTitle:@"Messages" image:[UIImage imageNamed:@"people"] tag:1],
                            [[UITabBarItem alloc] initWithTitle:@"Groups" image:[UIImage imageNamed:@"groups"] tag:2],
                            
                            [[UITabBarItem alloc] initWithTitle:@"Call" image:[UIImage imageNamed:@"calls"] tag:3]
                            ]];
        
        [_tabBar setSelectedItem:_tabBar.items[0]];

        [self.view addSubview:_tabBar];
    }
    return _tabBar;
}




@end
