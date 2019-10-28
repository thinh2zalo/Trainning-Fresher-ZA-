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
@property (nonatomic, strong) ContactViewController *groups;
@property (nonatomic, strong) MessageViewController *message;


@end

@implementation RootMesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self switchToViewController:self.message];
    self.tabBar.frame = CGRectMake(0, self.view.frame.size.height - TABBAR_HEIGHT, self.view.frame.size.width,   TABBAR_HEIGHT);
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
    if (toVC.view.hidden || !toVC.view.superview) {
        for (UIViewController *each in self.viewControllers) {
            [each.view setHidden:each != toVC];
        }
        if (toVC.view.superview != self.view) {
            [self addChildViewController:toVC];
            [toVC willMoveToParentViewController:self];
            [self.view insertSubview:toVC.view belowSubview:self.tabBar];
            
            toVC.view.frame = CGRectMake(0, 0 , self.view.frame.size.width ,self.view.frame.size.height - TABBAR_HEIGHT );
            [toVC didMoveToParentViewController:self];
        }
    }
}

- (MessageViewController *)message {
    if (!_message) {
        
        _message = MessageViewController.new;
    }
    return _message;
}
- (ContactViewController *)groups {
        if (!_groups) {
            _groups = ContactViewController.new;

        }
        return _groups;

}


- (UITabBar *)tabBar {
    if (!_tabBar) {
        _tabBar = UITabBar.new;
        _tabBar.delegate = self;
        
        [_tabBar setItems:@[[[UITabBarItem alloc] initWithTitle:@"Messages" image:[UIImage imageNamed:@"people"] tag:1],
                            [[UITabBarItem alloc] initWithTitle:@"Contact" image:[UIImage imageNamed:@"groups"] tag:2],
                            
                            [[UITabBarItem alloc] initWithTitle:@"Call" image:[UIImage imageNamed:@"calls"] tag:3]
                            ]];
        
        [_tabBar setSelectedItem:_tabBar.items[0]];
        
        [self.view addSubview:_tabBar ];
    }
    return _tabBar;
}


@end
