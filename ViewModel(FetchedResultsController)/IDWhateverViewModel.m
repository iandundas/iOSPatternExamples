//
// Created by Ian Dundas on 09/10/14.
// Copyright (c) 2014 Ian Dundas. All rights reserved.
//

#import "IDWhateverViewModel.h"
#import "CoreDataManager.h"

// private interface:
@interface IDWhateverViewModel () <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong, readwrite) NSMutableArray *items;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation IDWhateverViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _items= [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)update {
    NSAssert([NSThread isMainThread], @"Should be using main thread");

    NSArray *newItems = self.fetchedResultsController.fetchedObjects;

    if (newItems.count == 0){
        [self setValue:[NSMutableArray array] forKeyPath:@"items"];
    }
    else{
        // for manipulating the to-many relationship of self->items
        [self.items removeAllObjects];
        [[self mutableArrayValueForKeyPath:@"items"] addObjectsFromArray:newItems];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self update];
}

- (NSFetchedResultsController *)fetchedResultsController {

    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass (Item.class)];

//        NSSortDescriptor *dateCreatedSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:NO];
//        fetchRequest.sortDescriptors = @[dateCreatedSortDescriptor];

//        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", @"isArchived", @1]];

        _fetchedResultsController = [[NSFetchedResultsController alloc]
            initWithFetchRequest:fetchRequest
            managedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]
              sectionNameKeyPath:nil cacheName:nil
        ];
        _fetchedResultsController.delegate = self;

        NSError *error;
        [_fetchedResultsController performFetch:&error];

        if (error){
            NSLog(@"FETCH ERROR: %@, %@", error, error.localizedDescription);
        }
    }
    return _fetchedResultsController;
}

@end