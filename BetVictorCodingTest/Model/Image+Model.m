//
//  Image+Model.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "Image+Model.h"

@implementation Image (Model)

+ (instancetype)createImageInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name {
    Image *image = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:managedObjectContext];
    image.name = name;
    image.importDate = [NSDate date];
    return image;
}

@end
