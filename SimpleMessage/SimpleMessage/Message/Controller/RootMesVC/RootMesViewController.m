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
    self.tabBar;
    [self.tabBar setIsAccessibilityElement: true];
    [self.tabBar setAccessibilityIdentifier:@"TabBar"];
    [self.navigationController setNavigationBarHidden:YES];
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    [self switchToViewController:self.message];

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
            [self.view addSubview:toVC.view];

            [toVC willMoveToParentViewController:self];
            [self.view addSubview:toVC.view];

            [toVC.view alignTrailingEdgeWithView:self.view predicate:@"0"];
            [toVC.view alignLeadingEdgeWithView:self.view predicate:@"0"];
            [toVC.view alignTopEdgeWithView:self.view predicate:@"0"];
            [toVC.view constrainBottomSpaceToView:self.tabBar predicate:@"0"];
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
        UITabBarItem * contactItem = [[UITabBarItem alloc] initWithTitle:@"Contact" image:[UIImage imageNamed:@"groups"] tag:2];
        if (!contactItem) {
            NSLog(@"nil");
        } else {
            [contactItem setIsAccessibilityElement:true];
            [contactItem setAccessibilityIdentifier:@"contactItem"];
        }
        
        [_tabBar setItems:@[[[UITabBarItem alloc] initWithTitle:@"Messages" image:[UIImage imageNamed:@"people"] tag:1],
                            contactItem,
                            
                            [[UITabBarItem alloc] initWithTitle:@"Call" image:[UIImage imageNamed:@"calls"] tag:3]
                            ]];
        
        [self.view addSubview:_tabBar ];
        [_tabBar setSelectedItem:_tabBar.items[0]];
        [_tabBar alignBottomEdgeWithView:self.view predicate:@"0"];
        [_tabBar alignLeadingEdgeWithView:self.view predicate:@"0"];
        [_tabBar constrainWidth:[NSString stringWithFormat:@"%f",self.view.frame.size.width] height:@"100"];
    }
    return _tabBar;
}


@end
