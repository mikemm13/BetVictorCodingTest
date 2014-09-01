//
//  PictureDetailsViewController.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"
#import "ImagesManager.h"

@interface PictureDetailsViewController : UIViewController

@property (strong, nonatomic) Image *imageItem;
@property (strong, nonatomic) ImagesManager *imagesManager;

@end
