#import "MainViewController.h"

@protocol PassData <NSObject>
@required
- (void)passData;
@end

@interface MainViewController () < PassDataBack,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) float heightOfString;
@property (nonatomic, strong) NSArray <Content *> *arrContents;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MainViewController
int getCurrentIndex = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.tableView.frame = CGRectMake(originX , 0, SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);
    
}

- (void)onTouched:(NSIndexPath*) indexPath {
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.data = [self.arrContents objectAtIndex:indexPath.row].title;
    secondVC.indexPath = indexPath;
    secondVC.delegate = self;
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)getDataBack:(SecondViewController *)dataInsideSecond{
    
    Content * contentToUpdate = self.arrContents[dataInsideSecond.indexPath.row];
    contentToUpdate.title = dataInsideSecond.data;
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:dataInsideSecond.indexPath];
    if ([cell isKindOfClass:ParentsCell.class]) {
        [((ParentsCell*)cell) updateContentInsideCell:contentToUpdate];
    }
    [self.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray<Content *> *)arrContents{
    if (!_arrContents){
        _arrContents = [ConnectData connectData].contents;
    }
    return _arrContents;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:ThreeImageCell.class forCellReuseIdentifier:@"ThreeImageCell"];
        [_tableView registerClass:SingleImageCell.class forCellReuseIdentifier:@"SingleImageCell"];
        [_tableView registerClass:BigImageCell.class forCellReuseIdentifier:@"BigImageCell"];
        
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    if (indexPath.row % 3 == 0) {
        ThreeImageCell * cell  = [self.tableView dequeueReusableCellWithIdentifier:@"ThreeImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
        return cell;
    } else if (indexPath.row % 3 == 1) {
        SingleImageCell * cell  = [self.tableView dequeueReusableCellWithIdentifier:@"SingleImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    else {
        BigImageCell * cell  = [self.tableView dequeueReusableCellWithIdentifier:@"BigImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContents count] ;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
        //TODO: dynamic height
        NSString * titleToCal = [self.arrContents objectAtIndex:indexPath.row].title;
        CGFloat heightOfTitle = [ParentsCell heightOfLabel:titleToCal];
        return HEIGHT_IMG + heightOfTitle + 10  + 4 * PADDING;
    } else if (indexPath.row % 3 == 1) {
        return CELL_SINGLE_IMG;
    } else {
        //TODO: dynamic height
        NSString * titleToCal = [self.arrContents objectAtIndex:indexPath.row].title;
        CGFloat heightOfTitle = [ParentsCell heightOfLabel:titleToCal];
        return CELL_HEIGHT_BIG_IMG + heightOfTitle + 10 + 4  * PADDING;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self onTouched:indexPath];
}

@end

