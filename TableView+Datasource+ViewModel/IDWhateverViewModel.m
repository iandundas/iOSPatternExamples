//
// Created by Ian Dundas on 02/12/14.
// Copyright (c) 2014 Ian Dundas. All rights reserved.
//

#import "IDWhateverViewModel.h"

// private interface:
@interface IDWhateverViewModel ()
@property (nonatomic, strong, readwrite) NSMutableArray *items;
@end

@implementation IDWhateverViewModel
- (id)init{
    if (self= [super init]){
        _items= [[NSMutableArray alloc] initWithArray:@[@"Test",@"Data"]];
    }
    return self;
}
@end