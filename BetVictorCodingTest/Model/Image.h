//
//  Image.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 31/08/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Image : NSManagedObject

@property (nonatomic, retain) NSDate * importDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * size;

@end
