//
//  ViewController.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 30/08/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesManager.h"
@interface MainViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ImagesManager *imagesManager;
@end
