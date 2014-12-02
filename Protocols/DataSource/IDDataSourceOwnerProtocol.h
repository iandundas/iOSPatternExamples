//
// Created by Ian Dundas on 13/11/14.
// Copyright (c) 2014 Ian Dundas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDViewModelProtocol;

@protocol IDDataSourceOwnerProtocol
@property(nonatomic, strong, readonly) id<IDViewModelProtocol> viewModel;
@property(nonatomic, strong, readonly) UITableView *tableView;
@end