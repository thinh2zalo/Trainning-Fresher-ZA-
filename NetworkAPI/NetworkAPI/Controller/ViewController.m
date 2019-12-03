#import "ViewController.h"
#import "SingleImageCell.h"
#import "TripleImageCell.h"
#import "ParentCell.h"
#import <AFNetworking/AFNetworking.h>
#


#import "../View/NavBarView.h"
#import "../Model/ContentModel.h"
#import "../Define.h"
#import "../NetWork/FeedAPI.h"
#define SingleImageCellIdent @"SingleImageCell"
#define TripleImageCellIdent @"TripleImageCell"



@interface ViewController () <UITableViewDelegate, UITableViewDataSource > {
    NSUInteger oldNItem;
    NSUInteger newNItem;
}
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NavBarView * navbarView;
@property (nonatomic, strong) NSMutableArray <Content *> * arrContents;
@property (nonatomic, strong) FeedAPI * feedAPI;
@property (nonatomic, strong) dispatch_queue_t  queue;

@property (nonatomic, strong) AFNetworkReachabilityManager *  reachabilityManager;
@property (nonatomic) BOOL isLoading;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    self.isLoading = NO;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // handle connection
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self.feedAPI getContentsWithCompletion:^(NSArray <Content *> * contents, NSString * title ,NSString * strError) {
        if (strError == nil) {
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                self.arrContents = [NSMutableArray arrayWithArray:contents];
                self->oldNItem = self.arrContents.count;
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    
                    self.navbarView.navTitleLable.text = [title uppercaseString];
                    
                    
                    [self.tableview reloadData];
                });
            });
        } else {
            NSLog(@"error :%@", strError);
        }
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
    
}

- (void)loadUI {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    CGFloat navbarViewHeight = self.navigationController.navigationBar.frame.size.height + statusBar.frame.size.height;
    self.navbarView.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                       navbarViewHeight);
    self.tableview.frame = CGRectMake(0, self.navbarView.frame.origin.y + self.navbarView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - navbarViewHeight);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float heightOfCell;
    UILabel * titleLabel = UILabel.new;
    titleLabel.text = self.arrContents[indexPath.row].title;
    UILabel * timestampAndPublisher = UILabel.new;
    timestampAndPublisher.text = self.arrContents[indexPath.row].publicsherName;
    if ([self.arrContents[indexPath.row].images count] == 3) {
        heightOfCell = [TripleImageCell  heightOfCellWithTitle:self.arrContents[indexPath.row].title timestampAndPublisher:self.arrContents[indexPath.row].publicsherName];
    } else {
        heightOfCell = [SingleImageCell heightOfCell];
    }
    return heightOfCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Content * contentToUpdate = self.arrContents[indexPath.row];
    if ([cell isKindOfClass:ParentCell.class]) {
        [((ParentCell*)cell) updateContentInsideCell:contentToUpdate];
    }
    
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (!self.isLoading) {
//        if ((scrollView.contentOffset.y + scrollView.frame.size.height) / scrollView.contentSize.height >= 0.7 ) {
//
//            self.isLoading = YES;
//
//                NSRange range = {.location = oldNItem, oldNItem + 10 };
//                [self.feedAPI getContentsWithCompletion:^(NSArray <Content *> * contents, NSString * title ,NSString * strError) {
//                    if (strError == nil) {
//                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
//                            self->oldNItem = self.arrContents ? self.arrContents.count : 0;
//
//                            [self.arrContents addObjectsFromArray:contents];
//                            self->newNItem = self.arrContents.count;
//
//                            [self updateTableView];
//                            self.isLoading = NO;
//                            dispatch_async(dispatch_get_main_queue(), ^(void){
//
//                            });
//                        });
//                    } else {
//                        NSLog(@"error :%@", strError);
//                    }
//                }];
//            }
//        }
//
//}

- (void)updateTableView {
    NSMutableArray * arr = NSMutableArray.new;
    
    for (NSUInteger i = oldNItem ; i < newNItem ; i++) {
        [arr addObject:[NSIndexPath indexPathWithIndex:i]];
    }
    [self.tableview insertRowsAtIndexPaths:arr withRowAnimation:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParentCell * cell;
    if ([self.arrContents[indexPath.row].images count] == 3) {
        cell = [self.tableview dequeueReusableCellWithIdentifier:TripleImageCellIdent forIndexPath:indexPath];
        
    } else {
        cell = [self.tableview dequeueReusableCellWithIdentifier:SingleImageCellIdent forIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = RGB(25, 25, 25);
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrContents.count;
}

- (NSMutableArray<Content *> *)arrContents {
    if (!_arrContents) {
        _arrContents = NSMutableArray.new;
    }
    return _arrContents;
}

- (NavBarView *)navbarView {
    if (!_navbarView) {
        _navbarView = NavBarView.new;
        _navbarView.backgroundColor = RGB(25, 25, 25);
        [self.view insertSubview:_navbarView aboveSubview:self.tableview];
    }
    return _navbarView;
}

- (FeedAPI *)feedAPI {
    if (!_feedAPI) {
        _feedAPI = FeedAPI.new;
    }
    return _feedAPI;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = UITableView.new;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        
        _tableview.separatorColor = [UIColor clearColor];
        _tableview.backgroundColor = RGB(25, 25, 25);
        _tableview.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_tableview registerClass:SingleImageCell.class forCellReuseIdentifier:SingleImageCellIdent];
        [_tableview registerClass:TripleImageCell.class forCellReuseIdentifier:TripleImageCellIdent];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("tableview.reload", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}

@end
