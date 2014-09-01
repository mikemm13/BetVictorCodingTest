//
//  PersonalProfileViewController.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesManager.h"

@interface PersonalProfileViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ImagesManager *imagesManager;

@end
