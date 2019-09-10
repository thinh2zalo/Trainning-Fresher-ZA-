//
//  RootMesViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "RootMesViewController.h"

@interface RootMesViewController () < UITableViewDataSource , UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <ConversactionModel *> *arrConversations;

@end

@implementation RootMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ConversactionModel * contentToUpdate = self.arrConversations[indexPath.row];
    if ([cell isKindOfClass:ConversactionModel.class]) {
        [((ConversactionModel*)cell) updateContentInsideCell:contentToUpdate];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ConversationCell * conversation;
    if (self.arrConversations[indexPath.row].isGroupConversation) {
        conversation = [self.tableView dequeueReusableCellWithIdentifier:GroupConversationCell];
    } else {
        conversation = [self.tableView dequeueReusableCellWithIdentifier:SingleConversationCell];
    }
    return conversation;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrConversations count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT_BIG_IMG;
    }


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        [_tableView registerClass:SingleConversationCell.class forCellReuseIdentifier:SingleConversationCell];
        [_tableView registerClass:GroupConversationCell.class forCellReuseIdentifier:SingleConversationCell];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray<ConversactionModel *> *)arrConversations {
    if (!_arrConversations) {
        _arrConversations = NSArray.new;
    }
    return _arrConversations;
    
}




@end
