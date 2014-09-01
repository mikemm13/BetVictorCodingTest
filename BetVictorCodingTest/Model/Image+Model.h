//
//  Image+Model.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "Image.h"

@interface Image (Model)

+ (instancetype) createImageInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

@end
