#import "MainViewController.h"

@protocol PassData <NSObject>
@required
- (void)passData;
@end

@interface MainViewController () < FeedAPIDelegate, PassDataBack,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) BOOL isLoadingData;
@property (nonatomic) BOOL isLoadingPreviousData;
@property (nonatomic) FeedAPI * feedAPI;

@property (strong) NSMutableArray <Content *> *arrContents;
@property (nonatomic, strong) UITableView *tableView;

@end

float contentSizeHeightAfterUpdated;
float currentContentSizeHeight;
float oldContentSizeHeight;
float previousContentSizeHeight;
float postionScrollInCurrentContent;
@implementation MainViewController
@synthesize arrContents = _arrContens;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    oldContentSizeHeight = 0;
    contentSizeHeightAfterUpdated = 0;
    currentContentSizeHeight = 0;
    previousContentSizeHeight = 0;
    _isLoadingPreviousData = true;
    _isLoadingData = true;
    [self updateUI];
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [self updateUI];
    }completion:nil];
}

- (void)updateUI{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float originX = 0.0f;
    if (!UIInterfaceOrientationIsPortrait(orientation)) {
        originX = 25;
    }
    self.tableView.frame = CGRectMake(originX , 88 , SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT - 88);
    
}

- (void)getDataBack:(SecondViewController *)dataInsideSecond{
    
    Content * contentToUpdate = self.arrContents[dataInsideSecond.indexPath.row];
    contentToUpdate.title = dataInsideSecond.data;
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:dataInsideSecond.indexPath];
    if ([cell isKindOfClass:ParentsCell.class]) {
        [((ParentsCell*)cell) updateContentInsideCell:contentToUpdate];
    }
    [self.tableView reloadRowsAtIndexPaths:@[dataInsideSecond.indexPath] withRowAnimation:YES];
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)setArrContents:(NSMutableArray<Content *> *)arrContents{
    self.arrContents = arrContents;
}
- (NSMutableArray <Content *> *)arrContents{
    if (!_arrContens){
        _arrContens = NSMutableArray.new;
        [self callFeedAPI];
    }
    return _arrContens;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        [_tableView registerClass:ThreeImageCell.class forCellReuseIdentifier:ThreeImageCellIdenti];
        [_tableView registerClass:SingleImageCell.class forCellReuseIdentifier:SingleImageCellIdenti];
        [_tableView registerClass:BigImageCell.class forCellReuseIdentifier:BigImageCellIdenti];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Content * contentToUpdate = self.arrContents[indexPath.row];
    if ([cell isKindOfClass:ParentsCell.class]) {
        [((ParentsCell*)cell) updateContentInsideCell:contentToUpdate];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    if (postionScrollInCurrentContent >= currentContentSizeHeight && _isLoadingData) {
        _isLoadingPreviousData = true;
        previousContentSizeHeight = previousContentSizeHeight + currentContentSizeHeight;
        currentContentSizeHeight = contentSizeHeightAfterUpdated;
    }

    postionScrollInCurrentContent = scrollView.contentOffset.y - previousContentSizeHeight;
    float percent = 100 * (postionScrollInCurrentContent / currentContentSizeHeight);
    
    if ( percent >= 100  && _isLoadingPreviousData && _isLoadingData) {
        
        _isLoadingPreviousData = false;
        [self callFeedAPI];
    }
    
    if (percent >=0) {
        NSLog(@"percent : %f", percent);
    }
    
}
- (FeedAPI *)feedAPI {
    if (!_feedAPI) {
        _feedAPI = FeedAPI.new;
    }
    return _feedAPI;
}
- (void)callFeedAPI {
    NSLog(@"called");
    _isLoadingData = false;
    self.feedAPI.delegate = self;
    [self.feedAPI callAPI:10];
    
}

- (void)updateArrContents:(NSArray *)arrContentsBack {
    [self.arrContents addObjectsFromArray:arrContentsBack];
    [self.tableView reloadData];
    
    
    contentSizeHeightAfterUpdated = self.tableView.contentSize.height - oldContentSizeHeight - SCREEN_MAIN_HEIGHT;
    NSLog(@"contentSizeHeightAfterUpdated : %f", contentSizeHeightAfterUpdated);
    oldContentSizeHeight = oldContentSizeHeight + contentSizeHeightAfterUpdated ;
    _isLoadingData = true;
 }

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ParentsCell * cell;
    if (indexPath.row % 3 == 1) {
        cell  = [self.tableView dequeueReusableCellWithIdentifier:SingleImageCellIdenti forIndexPath:indexPath];
        
    } else if (indexPath.row % 3 == 2){
        cell  = [self.tableView dequeueReusableCellWithIdentifier:BigImageCellIdenti        forIndexPath:indexPath];
    } else {
        cell  = [self.tableView dequeueReusableCellWithIdentifier:ThreeImageCellIdenti forIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContents count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * titleToCal = [self.arrContents objectAtIndex:indexPath.row].title;
    if (indexPath.row % 3 == 0) {
        
        return [ThreeImageCell heightOfCell:titleToCal];
    } else if (indexPath.row % 3 == 1 ) {
        return [SingleImageCell heightOfCell];
        
    } else {
        return [BigImageCell heightOfCell:titleToCal];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.data = [self.arrContents objectAtIndex:indexPath.row].title;
    secondVC.indexPath = indexPath;
    secondVC.delegate = self;
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end

