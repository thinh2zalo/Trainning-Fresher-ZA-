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
//@property (nonatomic, strong) HeaderView * headerView;
@property (nonatomic, strong) FeedAPIMess * feedAPI;
@end

@implementation MessageViewController
CGFloat heightOfHeader;
CGFloat maxHeaderHeight ;
CGFloat minHeaderHeight ;
CGFloat heightOfBotTitle ;
BOOL isEditting;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    heightOfHeader = [(RootMesViewController *) self.parentViewController headerView].frame.size.height;
    self.arrConversations =  [[self.feedAPI setupData] mutableCopy];
    
    
//    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, heightOfHeader);
    minHeaderHeight = heightOfHeader - 44;
    maxHeaderHeight = heightOfHeader;

}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self scrollViewDidStopScrolling];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (!decelerate) {
//        [self scrollViewDidStopScrolling];
//    }
//
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    float scrollDiff = scrollView.contentOffset.y + heightOfHeader;
//    [[(RootMesViewController *) self.parentViewController headerView] setHeightForBotHeader:scrollDiff];
//    [[(RootMesViewController *) self.parentViewController headerView] setHeightForTopHeader:scrollDiff];
//    [[(RootMesViewController *) self.parentViewController headerView].topHeaderView setHidden:YES];
//
//    if (self.tableView.contentOffset.y > - maxHeaderHeight) {
//        [[(RootMesViewController *) self.parentViewController headerView].topHeaderView setHidden:NO];
//
//    }
//}

//- (void) scrollViewDidStopScrolling {
//    CGFloat range = maxHeaderHeight - minHeaderHeight;
//    CGFloat midPoint = minHeaderHeight + (range / 2);
//    if (self.tableView.contentOffset.y < (- midPoint)) {
//        [self expandHeader];
//    } else if (self.tableView.contentOffset.y < - minHeaderHeight){
//        [self collapseHeader];
//    }
//}

//- (void) collapseHeader {
//    [[(RootMesViewController *) self.parentViewController headerView] setHidden:false];
//    [UIView animateWithDuration:0.2 animations:^{
//        [[(RootMesViewController *) self.parentViewController headerView] setHeightForBotHeader:heightOfBotTitle];
//        [self.tableView setContentOffset:CGPointMake(0, - minHeaderHeight)];
//    }];
//}

//- (void) expandHeader {
//    [UIView animateWithDuration:0.2 animations:^{
//        [[(RootMesViewController *) self.parentViewController headerView] setHeightForBotHeader:0];
//        [self.tableView setContentOffset:CGPointMake(0, - maxHeaderHeight)];
//    }];
//}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    isEditting = false;

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self.arrConversations removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }];
    isEditting = true;

    deleteAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"delete"]];
    
    UITableViewRowAction *callAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Call" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
    }];
    UITableViewRowAction *informationAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Information" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
    }];
    
    return @[deleteAction, callAction, informationAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return isEditting;
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
//- (HeaderView *)headerView {
//    if (!_headerView) {
//        _headerView = HeaderView.new;
//
//        [self.view addSubview:_headerView];
//    }
//    return _headerView;
//}

- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = UITableView.new;

        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(heightOfHeader , 0, 0, 0);

        [_tableView registerClass:SingleConversationCell.class forCellReuseIdentifier:SingleConversationCellIdent];
        [_tableView registerClass:GroupConversationCell.class forCellReuseIdentifier:GroupConversationCellIdent];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
