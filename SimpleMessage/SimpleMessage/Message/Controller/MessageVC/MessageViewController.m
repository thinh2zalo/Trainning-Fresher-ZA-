//
//  MessageViewController.m
//  bacsicObjC
//
//  Created by Steve on 9/19/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()  < UITabBarControllerDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <ConversationModel *> *arrConversations;
@property (nonatomic, strong) UITabBar * tabBar;
@property (nonatomic, strong) HeaderView * headerView;
@property (nonatomic, strong) FeedAPIMess * feedAPI;

 

@end

@implementation MessageViewController

BOOL isEditting;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrConversations =  [[self.feedAPI setupData] mutableCopy];
    self.headerView;
    
     [self.view layoutIfNeeded];
    heightOfHeader = self.headerView.frame.size.height;
    minHeaderHeight = heightOfHeader - 44;
    maxHeaderHeight = heightOfHeader;
    self.tableView;

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidStopScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidStopScrolling];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float scrollDiff = scrollView.contentOffset.y + heightOfHeader;
    [self.headerView  setHeightForBotHeader:scrollDiff];
    [self.headerView  setHeightForTopHeader:scrollDiff];
    [self.headerView.topHeaderView setHidden:YES];
    if (self.tableView.contentOffset.y > - maxHeaderHeight) {
        [self.headerView.topHeaderView setHidden:NO];

    }
}

- (void) scrollViewDidStopScrolling {
    CGFloat range = maxHeaderHeight - minHeaderHeight;
    CGFloat midPoint = minHeaderHeight + (range / 2);
    if (self.tableView.contentOffset.y < (- midPoint)) {
        [self expandHeader];
    } else if (self.tableView.contentOffset.y < - minHeaderHeight){
        [self collapseHeader];
    }
}

- (void) collapseHeader {
    [self.headerView setHidden:false];
    [UIView animateWithDuration:0.2 animations:^{
        [self.headerView setHeightForBotHeader:self->heightOfBotTitle];
        [self.tableView setContentOffset:CGPointMake(0, - self->minHeaderHeight)];
    }];
}

- (void) expandHeader {
    [UIView animateWithDuration:0.2 animations:^{
        [self.headerView setHeightForBotHeader:0];
        [self.tableView setContentOffset:CGPointMake(0, - self->maxHeaderHeight)];
    }];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self.arrConversations removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }];

    deleteAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"delete"]];
    
    UITableViewRowAction *callAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Call" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
    }];
    UITableViewRowAction *informationAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Information" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
    }];
    
    return @[deleteAction, callAction, informationAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return true;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversationModel * contentToUpdate = self.arrConversations[indexPath.row];
    if ([cell isKindOfClass:ConversationCell.class]) {
        [(ConversationCell*) cell updateContentInsideCell:contentToUpdate];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ConversationCell * conversationCell;
    if (self.arrConversations[indexPath.row].isGroupConversation) {
        conversationCell = [self.tableView dequeueReusableCellWithIdentifier:GroupConversationCellIdent];
    } else {
        conversationCell = [self.tableView dequeueReusableCellWithIdentifier:SingleConversationCellIdent];
    }
    
    conversationCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return conversationCell;
    
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrConversations count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (NSMutableArray<ConversationModel *> *)arrConversations {
    if (!_arrConversations) {
        _arrConversations = NSMutableArray.new;
    }
    return _arrConversations;
    
}

- (FeedAPIMess *)feedAPI {
    if (!_feedAPI) {
        _feedAPI = FeedAPIMess.new;
    }
    return _feedAPI;
    
}
- (HeaderView *)headerView {
    if (!_headerView) {
        _headerView = HeaderView.new;
        [self.view addSubview:_headerView];
        _headerView.titleBotLab.text = @"MESSAGE";
        _headerView.titleTopLab.text = @"Message";
        [_headerView alignTop:@"0" leading:@"0" toView:self.view];
        [_headerView alignTrailingEdgeWithView:self.view predicate:@"0"];
        [_headerView constrainHeight:@"132"];
    }
    return _headerView;
}

- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = UITableView.new;

        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(heightOfHeader , 0, 0, 0);

        [_tableView registerClass:SingleConversationCell.class forCellReuseIdentifier:SingleConversationCellIdent];
        [_tableView registerClass:GroupConversationCell.class forCellReuseIdentifier:GroupConversationCellIdent];
        [self.view insertSubview:_tableView belowSubview:self.headerView];
        [_tableView alignToView:self.view];

   }
    
    return _tableView;

}


@end
