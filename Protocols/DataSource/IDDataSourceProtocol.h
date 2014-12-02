//
// Created by Ian Dundas on 13/11/14.
// Copyright (c) 2014 Ian Dundas. All rights reserved.
//

@import UIKit;
@protocol IDDataSourceOwnerProtocol;

// For now, coupled to UITableView. TODO: extend for CollectionView or whatever.
@protocol IDDataSourceProtocol <UITableViewDataSource>

-(id)initWithOwner:(id<IDDataSourceOwnerProtocol>)owner;
-(void)registerCellTypesForTableView:(UITableView *)view;
- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak, readonly) id<IDDataSourceOwnerProtocol> owner;
@end