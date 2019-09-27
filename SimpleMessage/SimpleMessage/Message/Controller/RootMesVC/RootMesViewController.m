//
//  RootMesViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "RootMesViewController.h"

@interface RootMesViewController () < UITabBarControllerDelegate, UITabBarDelegate>

@property (nonatomic, strong) ContactViewController *groups;
@property (nonatomic, strong) MessageViewController *message;
@end

@implementation RootMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT );
    self.tabBar.frame = CGRectMake(0, self.view.frame.size.height - TABBAR_HEIGHT, self.view.frame.size.width,   TABBAR_HEIGHT);
    [self.navigationController setNavigationBarHidden:YES];
    
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    [self switchToViewController:rootViewController];
    return self;
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
            toVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - self.tabBar.frame.size.height + self.headerView.frame.size.height);
            [self.view insertSubview:toVC.view belowSubview:self.headerView];

            [toVC didMoveToParentViewController:self];
        }
    }
}

- (HeaderView *)headerView {
    if (!_headerView) {
        _headerView = HeaderView.new;
        
        [self.view addSubview:_headerView];
    }
    return _headerView;
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
        _tabBar.translatesAutoresizingMaskIntoConstraints = false;
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
