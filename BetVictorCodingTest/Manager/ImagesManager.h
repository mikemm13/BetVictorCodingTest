//
//  ImagesManager.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesManager : NSObject <NSFileManagerDelegate>

- (void)copyFolder;
- (UIImage *)loadImageNamed:(NSString *)imageName;
- (void)saveImage:(UIImage *)image withName:(NSString *)name;

@end
