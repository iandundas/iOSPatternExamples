//
// Created by Ian Dundas on 02/12/14.
// Copyright (c) 2014 Ian Dundas. All rights reserved.
//

#import "IDWhateverDataSource.h"
#import "IDWhateverViewModel.h"
#import "IDWhateverViewController.h"

static NSString *CellIdentifier = @"IDWhateverDataSource";

// private interface:
@interface IDWhateverDataSource ()
@property (nonatomic, weak, readwrite) id<IDDataSourceOwnerProtocol> owner;
@end

@implementation IDWhateverDataSource
- (id)initWithOwner:(id <IDDataSourceOwnerProtocol>)owner {
    if (self = [super init]) {
        _owner= owner;
    }
    return self;
}

#pragma mark - IDDataSourceProtocol
- (void)registerCellTypesForTableView:(UITableView *)tableView {
    [self.owner.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.owner.viewModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.owner.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end