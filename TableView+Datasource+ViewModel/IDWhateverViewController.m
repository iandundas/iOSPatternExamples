#import "IDWhateverViewController.h"
#import "IDWhateverViewModel.h"
#import "IDWhateverDataSource.h"
#import "UIView+FLKAutoLayout.h"

static CGFloat CellHeight = 44;

// private interface:
@interface IDWhateverViewController () <UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) IDWhateverViewModel *viewModel;
@property (nonatomic, strong) IDWhateverDataSource *dataSource;

- (NSDictionary *)views;
- (void)configureViews;
- (void)placeViews;
- (void)constrainViews;
@end

@implementation IDWhateverViewController

- (instancetype)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _viewModel = [[IDWhateverViewModel alloc] init];
        _dataSource = [[IDWhateverDataSource alloc] initWithOwner:self];

        _tableView = UITableView.new;
        _tableView.delegate = self;
        _tableView.dataSource = _dataSource;

        [_dataSource registerCellTypesForTableView:_tableView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Whatever"];

    [self configureViews];
    [self placeViews];
    [self constrainViews];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector (didTapCancel:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector (didTapSave:)];
}

#pragma mark AutoLayout:
- (NSDictionary *)views {
    return NSDictionaryOfVariableBindings (
        _tableView
    );
}

- (void)configureViews {
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.separatorColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
}

- (void)placeViews {
    [self.views.allValues enumerateObjectsUsingBlock:^(UIView *childView, NSUInteger idx, BOOL *stop) {
        [childView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:childView];
    }];
}

- (void)constrainViews {
    [self.tableView alignToView:self.view];
}


#pragma mark - TabBar buttons

- (void)didTapCancel:(id)sender {
//    [self.viewModel.item delete]; // if needed
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapSave:(id)sender {
    //[self.viewModel.item save]; // if needed
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end