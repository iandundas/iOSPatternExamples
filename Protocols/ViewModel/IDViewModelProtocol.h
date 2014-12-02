//
// Created by Ian Dundas on 22/10/14.
// Copyright (c) 2014 Ian Dundas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDViewModelProtocol <NSObject>
@property (nonatomic, strong, readonly) NSMutableArray *items;

@optional
- (void)update;
@end