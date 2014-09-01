//
//  PictureLibraryTableViewManager.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 31/08/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagesManager.h"


@interface PictureLibraryTableViewManager : NSObject<NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic)NSFetchedResultsController *fetchedResultsController;


- (instancetype)initWithMOC:(NSManagedObjectContext *)managedObjectContext imagesManager:(ImagesManager *)imagesManager;
- (void)loadFetchedResultController;

@end
