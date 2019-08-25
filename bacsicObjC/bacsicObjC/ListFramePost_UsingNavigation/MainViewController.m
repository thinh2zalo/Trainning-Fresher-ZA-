#import "TwoKindOfCellVC.h"

@protocol PassData <NSObject>
@required
- (void)passData;
@end

@interface TwoKindOfCellVC () < PassDataBack,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <Content *> *arrContents;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TwoKindOfCellVC
int getCurrentIndex = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViewFlowOrientation];

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [self layoutViewFlowOrientation];

    }completion:^(id<UIViewControllerTransitionCoordinatorContext> context){

    }];
}
- (void)layoutViewFlowOrientation{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self updateUI:UIInterfaceOrientationIsPortrait(orientation)];

}
- (void)updateUI:(BOOL)isPortrait{
    _tableView = self.tableView;
    float originX = 0.0f;
    if (!isPortrait) {
        originX = 25;
    }
    self.tableView.frame = CGRectMake(originX , 0, SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);

}

- (void)onTouched:(ParentsCell*) containerCell {
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.data = containerCell.titleLab.text;
    NSIndexPath *path = [self.tableView indexPathForCell:containerCell];
    secondVC.indexPath = path;

    secondVC.delegate = self;

    [self.navigationController pushViewController:secondVC animated:YES];
}

//
//- (void)getDataBack:(SecondViewController *)dataInsideSecond{
//    ContainerCell * cellToUpdate = [self.tableView cellForRowAtIndexPath:dataInsideSecond.indexPath];
//    Content * contentToUpdate = [self.arrContents objectAtIndex:[dataInsideSecond.indexPath row]/2];
//    contentToUpdate.title = dataInsideSecond.data;
//    [cellToUpdate updateContentInsideContainerView:contentToUpdate];
//    [self.navigationController popViewControllerAnimated:YES];
//}

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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
        ThreeImageCell * cell  = [self.tableView dequeueReusableCellWithIdentifier:@"ThreeImageCell" forIndexPath:indexPath];
        NSInteger index = indexPath.row/3;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateContentInsideCell:[self.arrContents objectAtIndex:index]];
        return cell;
    } else if (indexPath.row % 3 == 1) {
        SingleImageCell * cell  = [self.tableView dequeueReusableCellWithIdentifier:@"SingleImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        NSInteger index = indexPath.row/3;
        [cell updateContentInsideCell:[self.arrContents objectAtIndex:index]];
     
        return cell;
    }
    else {
        BigImageCell * cell  = [self.tableView dequeueReusableCellWithIdentifier:@"BigImageCell " forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        NSInteger index = indexPath.row/3;
        [cell updateContentInsideCell:[self.arrContents objectAtIndex:index]];
       
        return cell;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.row % 2 != 0) {
        [self onTouched:[self.tableView cellForRowAtIndexPath:indexPath]];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContents count] * 3 ;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
         return HEIGHT_THREE_IMG;
    } else if (indexPath.row % 3 == 1) {
         return HEIGHT_VIEW;
    }   else {
        return CELL_HEIGHT_BIG_IMG;
    }
    
   
}
@end

