//
//  groupViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/12/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <ConversationModel *> *arrConversations;
@property (nonatomic, strong) UITabBar * tabBar;
@property (nonatomic, strong) GroupViewController *groups;

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) NSLayoutConstraint *  headerHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *  headerHeightTopTitle;
@property (nonatomic, strong) FeedAPIMess * feedAPI;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(10, 10, 300, 300);
    self.view.backgroundColor = [UIColor blueColor];
    self.titleLab;

}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"title";
        _titleLab.frame = CGRectMake(150, 100, 100, 100);
        [self.view addSubview:_titleLab];

    
    }
    return _titleLab;
}



@end
