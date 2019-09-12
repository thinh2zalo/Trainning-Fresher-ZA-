//
//  RootMesViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "RootMesViewController.h"

@interface RootMesViewController () < UITabBarControllerDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <ConversationModel *> *arrConversations;
@property (nonatomic, strong) UITabBar * tabBar;
@property (nonatomic, strong) GroupViewController *groups;
@property (nonatomic, strong) PeopleViewController *people;

@end

@implementation RootMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ConversationModel * conversation = ConversationModel.new;
    conversation.nameUser = @"Hoai Thi";
    conversation.lastMessage = @"nothinghere nothinghere nothinghere nothinghere nothinghere nothinghere";
    conversation.time = @"12:12";
    conversation.isGroupConversation = false;
    conversation.countNewMessage = 10;
    
    ConversationModel * conversation2 = conversation;
    ConversationModel * conversation3 = conversation;
    ConversationModel * conversation4 = conversation;
    
    self.tableView.frame = CGRectMake(0, 88 , SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);
    [self.arrConversations  addObject:conversation];
     [self.arrConversations  addObject:conversation2];
    [self.arrConversations  addObject:conversation3];
    [self.arrConversations  addObject:conversation4];
    
    float originY = KEY_WINDOW_SAFE_AREA_INSETS.top + self.navigationController.navigationBar.frame.size.height;
    self.tableView.frame = CGRectMake(0 , originY , SCREEN_MAIN_WIDTH , SCREEN_MAIN_HEIGHT - originY);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversationModel * contentToUpdate = self.arrConversations[indexPath.row];
    if ([cell isKindOfClass:ConversationCell.class]) {
        [(ConversationCell*) cell updateContentInsideCell:contentToUpdate];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ConversationCell * conversation;
    if (self.arrConversations[indexPath.row].isGroupConversation) {
        conversation = [self.tableView dequeueReusableCellWithIdentifier:GroupConversationCellIdent];
    } else {
        conversation = [self.tableView dequeueReusableCellWithIdentifier:SingleConversationCellIdent];
    }
    return conversation;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrConversations count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        
        [_tableView registerClass:SingleConversationCell.class forCellReuseIdentifier:SingleConversationCellIdent];
        [_tableView registerClass:GroupConversationCell.class forCellReuseIdentifier:GroupConversationCellIdent];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<ConversationModel *> *)arrConversations {
    if (!_arrConversations) {
        _arrConversations = NSMutableArray.new;
    }
    return _arrConversations;
    
}

- (GroupViewController *)groups {
    if (!_groups) {
       
        _groups = GroupViewController.new;
       
    }
    return  _groups;
}

- (PeopleViewController *)people {
    if (!_people) {
        _people = PeopleViewController.new;
     
    }
    return _people;
}

- (UITabBar *)tabBar {
    if (!_tabBar) {
        _tabBar = UITabBar.new;
        [_tabBar setItems:@[
                            [[UITabBarItem alloc] initWithTitle:@"Groups" image:[UIImage imageNamed:@"groups"] tag:1],
                            [[UITabBarItem alloc] initWithTitle:@"People" image:[UIImage imageNamed:@"people"] tag:1]
                            ]];
        [self.view addSubview:_tabBar];
    }
    return _tabBar;
}

@end
