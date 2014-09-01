//
//  PictureLibraryViewController.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 31/08/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesManager.h"


@interface PictureLibraryViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ImagesManager *imagesManager;

@end
