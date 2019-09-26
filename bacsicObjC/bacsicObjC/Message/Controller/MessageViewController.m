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
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) FeedAPIMess * feedAPI;
@end

@implementation MessageViewController
CGFloat maxHeaderHeight ;
CGFloat minHeaderHeight ;
CGFloat heightOfBotTitle ;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrConversations =  [[self.feedAPI setupData] mutableCopy];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TABBAR_HEIGHT);
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT);
    minHeaderHeight = HEADER_HEIGHT - 44;
    maxHeaderHeight = HEADER_HEIGHT;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"DID STROP");

    [self scrollViewDidStopScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidStopScrolling];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float scrollDiff = scrollView.contentOffset.y  +  HEADER_HEIGHT;
    [self.headerView setHeightForBotHeader:scrollDiff];
    [self.headerView setHeightForTopHeader:scrollDiff];
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
        
        [self.headerView setHeightForBotHeader:heightOfBotTitle];
        [self.tableView setContentOffset:CGPointMake(0, - minHeaderHeight)];
    }];
}

- (void) expandHeader {

    [UIView animateWithDuration:0.2 animations:^{
        [self.headerView setHeightForBotHeader:0];
        [self.tableView setContentOffset:CGPointMake(0, - maxHeaderHeight)];
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
    ConversationCell * conversation;
    if (self.arrConversations[indexPath.row].isGroupConversation) {
        conversation = [self.tableView dequeueReusableCellWithIdentifier:GroupConversationCellIdent];
    } else {
        conversation = [self.tableView dequeueReusableCellWithIdentifier:SingleConversationCellIdent];
    }
    conversation.selectionStyle = UITableViewCellSelectionStyleNone;
    return conversation;
    
}

- (HeaderView *)headerView {
    if (!_headerView) {
        _headerView = HeaderView.new;
        [self.view addSubview:_headerView];
    }
    return _headerView;
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


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.contentInset = UIEdgeInsetsMake(HEADER_HEIGHT, 0, 0, 0);
        _tableView.separatorColor = [UIColor clearColor];

        [_tableView registerClass:SingleConversationCell.class forCellReuseIdentifier:SingleConversationCellIdent];
        [_tableView registerClass:GroupConversationCell.class forCellReuseIdentifier:GroupConversationCellIdent];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
