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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    minHeaderHeight = HEADER_HEIGHT / 2;
    maxHeaderHeight = HEADER_HEIGHT;
    self.arrConversations =  [[self.feedAPI setupData] copy];
   
    self.tableView.frame = CGRectMake(0, 0, SCREEN_MAIN_WIDTH, self.view.frame.size.height - TABBAR_HEIGHT);
    self.headerView.frame = CGRectMake(0, 0, SCREEN_MAIN_WIDTH, HEADER_HEIGHT);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self scrollViewDidStopScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidStopScrolling];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float scrollDiff = scrollView.contentOffset.y  +  HEADER_HEIGHT;
    [self.headerView setHeightForBotHeader: HEADER_HEIGHT / 2 - scrollDiff];
    NSLog(@"height of top : %f", - HEADER_HEIGHT / 2 + scrollDiff);
    [self.headerView setHeightForTopHeader: - HEADER_HEIGHT / 2 + scrollDiff];
}

- (void) scrollViewDidStopScrolling {
    CGFloat range = maxHeaderHeight - minHeaderHeight; 
    CGFloat midPoint = minHeaderHeight + (range / 2);
    if (self.tableView.contentOffset.y < (- midPoint) - 1) {
            NSLog(@"do you go here when i scroll down %f", self.tableView.contentOffset.y);
        [self expandHeader];
    } else if (self.tableView.contentOffset.y < 0){
        NSLog(@"do you go here when i scroll upppp");
        [self collapseHeader];
    }
}

- (void) collapseHeader {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.headerView setHeightForBotHeader:minHeaderHeight];
        [self.tableView setContentOffset:CGPointMake(0, - minHeaderHeight)];
    }];
}

- (void) expandHeader {
    [UIView animateWithDuration:3 animations:^{
        [self.headerView setHeightForBotHeader:maxHeaderHeight/2];
        [self.tableView setContentOffset:CGPointMake(0, - maxHeaderHeight)];
    }];
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
        _tableView.contentInset = UIEdgeInsetsMake(TABBAR_HEIGHT, 0, 0, 0);

        [_tableView registerClass:SingleConversationCell.class forCellReuseIdentifier:SingleConversationCellIdent];
        [_tableView registerClass:GroupConversationCell.class forCellReuseIdentifier:GroupConversationCellIdent];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
