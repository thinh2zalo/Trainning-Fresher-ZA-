////
////  ConversationViewController+trash.m
////  bacsicObjC
////
////  Created by Steve on 9/19/19.
////  Copyright © 2019 CPU11606. All rights reserved.
////
////
////  RootMesViewController.m
////  bacsicObjC
////
////  Created by CPU11606 on 9/10/19.
////  Copyright © 2019 CPU11606. All rights reserved.
////
//
//#import "RootMesViewController.h"
//
//@interface RootMesViewController () < UITabBarControllerDelegate , UITableViewDataSource , UITableViewDelegate>
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray <ConversationModel *> *arrConversations;
//@property (nonatomic, strong) UITabBar * tabBar;
//@property (nonatomic, strong) GroupViewController *groups;
//@property (nonatomic, strong) PeopleViewController *people;
//@property (nonatomic, strong) HeaderView *headerView;
//@property (nonatomic, strong) UILabel * titleLab;
//@property (nonatomic, strong) NSLayoutConstraint *  headerHeightConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *  headerHeightTopTitle;
//@property (nonatomic, strong) FeedAPIMess * feedAPI;
//
//
//@end
//
//@implementation RootMesViewController
//
//CGFloat maxHeaderHeight ;
//CGFloat minHeaderHeight = 44;
//CGFloat previousScrollOffset = 0;
//CGFloat previousScrollViewHeight = 0;
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.arrConversations =  [[self.feedAPI setupData] copy];
//
//    self.headerHeightTopTitle = [self.headerView.titleTopConstraint.topAnchor constraintEqualToAnchor:self.view.topAnchor];
//
//    [self.headerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:88].active = YES;
//    self.headerHeightConstraint = [self.headerView.heightAnchor constraintEqualToConstant:0];
//    self.headerHeightConstraint.active = YES;
//    [self.headerView.widthAnchor constraintEqualToConstant:SCREEN_MAIN_WIDTH].active = YES;
//    //miss left constraint
//
//
//    maxHeaderHeight = 88;
//
//    [self.tableView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:0].active = YES;
//    //headerView
//    //tableView
//
//    [self.tableView.bottomAnchor constraintEqualToAnchor:self.tabBar.topAnchor constant:0].active = YES;
//
//    //Du height contraint
//    //    [self.tableView.heightAnchor constraintEqualToConstant:SCREEN_MAIN_HEIGHT - 88 * 2 ].active = YES;
//
//    [self.tableView.widthAnchor constraintEqualToConstant:SCREEN_MAIN_WIDTH].active = YES;
//    //missing left constraint
//
//    [self.tabBar.heightAnchor constraintEqualToConstant:80].active = YES;
//    [self.tabBar.widthAnchor constraintEqualToConstant:SCREEN_MAIN_WIDTH ].active = YES;
//    //missing left constraint
//    [self.tabBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
//
//    self.headerHeightConstraint.constant = maxHeaderHeight;
//
//    [self updateHeader];
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ConversationViewController * conversationViewController = ConversationViewController.new;
//    conversationViewController.conversationId = self.arrConversations[indexPath.item].conversationID;
//    [self.navigationController pushViewController:conversationViewController animated:YES];
//
//
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidEndDecelerating");
//    [self scrollViewDidStopScrolling];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (!decelerate) {
//        NSLog(@"scrollViewDidEndDragging");
//
//        [self scrollViewDidStopScrolling];
//    } else {
//        NSLog(@"else");
//    }
//
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    CGFloat absoluteTop = 0;
//    CGFloat absoluteBottom = scrollView.contentSize.height - scrollView.frame.size.height;
//    CGFloat scrollDiff = scrollView.contentOffset.y - previousScrollOffset;
//    BOOL isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop;
//    BOOL isScrollingUp =  scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom;
//
//    NSLog(@"scrollViewDidScroll: %f", scrollView.contentOffset.y );
//    if ([self canAnimateHeader:scrollView]) {
//
//        CGFloat newHeight = self.headerHeightConstraint.constant;
//        if (isScrollingDown) {
//            newHeight = MAX(minHeaderHeight, self.headerHeightConstraint.constant - fabs(scrollDiff));
//        } else if (isScrollingUp) {
//            newHeight = MIN(maxHeaderHeight, self.headerHeightConstraint.constant + fabs(scrollDiff));
//        }
//
//        if (newHeight != self.headerHeightConstraint.constant) {
//            self.headerHeightConstraint.constant = newHeight;
//            [self updateHeader];
//            [self setScrollPosition:previousScrollOffset];
//
//        }
//    }
//    NSLog(@"previousScrollOffset : %f", previousScrollOffset);
//    previousScrollOffset = scrollView.contentOffset.y;
//
//}
//
//- (void) setScrollPosition:(CGFloat) position {
//    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, position);
//}
//
//- (BOOL) canAnimateHeader:(UIScrollView *) scrollView{
//    float scrollViewMaxHeight = scrollView.frame.size.height + self.headerHeightConstraint.constant - minHeaderHeight;
//    return scrollView.contentSize.height > scrollViewMaxHeight;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0;
//}
//- (void) scrollViewDidStopScrolling {
//    CGFloat range = maxHeaderHeight - minHeaderHeight;
//    CGFloat midPoint = minHeaderHeight + (range / 2);
//
//    if (self.headerHeightConstraint.constant > midPoint) {
//        [self expandHeader];
//    } else {
//        [self collapseHeader];
//    }
//}
//
//- (void) collapseHeader {
//    [self.view layoutIfNeeded];
//
//    [UIView animateWithDuration:0.2 animations:^{
//
//        self.headerHeightConstraint.constant = minHeaderHeight;
//        [self updateHeader];
//        [self.view layoutIfNeeded];
//    }];
//}
//
//- (void) expandHeader {
//    [UIView animateWithDuration:0.2 animations:^{
//        self.headerHeightConstraint.constant = maxHeaderHeight;
//        [self updateHeader];
//        [self.view layoutIfNeeded];
//    }];
//}
//
//- (void) updateHeader {
//    float range = maxHeaderHeight - minHeaderHeight;
//    float openAmount = self.headerHeightConstraint.constant - minHeaderHeight;
//    float percent = openAmount /range;
//    self.headerView.titleBotConstraint.alpha = percent;
//    self.headerHeightTopTitle.active = true;
//
//    self.headerHeightTopTitle.constant = - openAmount * 2 + 88 ;
//    self.headerHeightTopTitle.active = YES;
//    [self.view layoutIfNeeded];
//
//
//}
//
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = UITableView.new;
//        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.contentInset = UIEdgeInsetsMake(88, 0, 0, 0);
//        _tableView.translatesAutoresizingMaskIntoConstraints = false;
//        //        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        _tableView.estimatedRowHeight = 0;
//
//        [_tableView registerClass:SingleConversationCell.class forCellReuseIdentifier:SingleConversationCellIdent];
//        [_tableView registerClass:GroupConversationCell.class forCellReuseIdentifier:GroupConversationCellIdent];
//        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}
//
//- (NSMutableArray<ConversationModel *> *)arrConversations {
//    if (!_arrConversations) {
//        _arrConversations = NSMutableArray.new;
//    }
//    return _arrConversations;
//
//}
//
//
//- (FeedAPIMess *)feedAPI {
//    if (!_feedAPI) {
//        _feedAPI = FeedAPIMess.new;
//    }
//    return _feedAPI;
//
//}
//
//- (UITabBar *)tabBar {
//    if (!_tabBar) {
//        _tabBar = UITabBar.new;
//        _tabBar.translatesAutoresizingMaskIntoConstraints = false;
//
//        [_tabBar setItems:@[
//                            [[UITabBarItem alloc] initWithTitle:@"Groups" image:[UIImage imageNamed:@"groups"] tag:1],
//                            [[UITabBarItem alloc] initWithTitle:@"People" image:[UIImage imageNamed:@"people"] tag:2],
//                            [[UITabBarItem alloc] initWithTitle:@"Call" image:[UIImage imageNamed:@"calls"] tag:3]
//                            ]];
//        [self.view addSubview:_tabBar];
//    }
//    return _tabBar;
//}
//
//- (UIView *)headerView {
//    if (!_headerView) {
//        _headerView = HeaderView.new;
//        _headerView.translatesAutoresizingMaskIntoConstraints = false;
//        //        _headerView.backgroundColor = [UIColor  blueColor];
//        [self.view addSubview:_headerView];
//    }
//    return _headerView;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    ConversationModel * contentToUpdate = self.arrConversations[indexPath.row];
//    if ([cell isKindOfClass:ConversationCell.class]) {
//        [(ConversationCell*) cell updateContentInsideCell:contentToUpdate];
//    }
//}
//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    ConversationCell * conversation;
//    if (self.arrConversations[indexPath.row].isGroupConversation) {
//        conversation = [self.tableView dequeueReusableCellWithIdentifier:GroupConversationCellIdent];
//    } else {
//        conversation = [self.tableView dequeueReusableCellWithIdentifier:SingleConversationCellIdent];
//    }
//    return conversation;
//
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.arrConversations count];
//}
//
//
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 100;
//}
//
//
//@end
