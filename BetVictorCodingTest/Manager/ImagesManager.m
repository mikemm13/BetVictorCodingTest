//
//  ImagesManager.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "ImagesManager.h"

@implementation ImagesManager

- (void) copyFolder { // Copy images to Documents directory
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    fileManager.delegate = self;
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"/Images"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:writableDBPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:writableDBPath withIntermediateDirectories:NO attributes:nil error:&error];
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"PreloadedImages"];
        NSLog(@"default path %@",defaultDBPath);
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    }
}

- (UIImage *)loadImageNamed:(NSString *)imageName{
    UIImage *image;
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Images"];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",imageName]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        //File exists
        NSData *file = [[NSData alloc] initWithContentsOfFile:path];
        if (file)
        {
            image = [UIImage imageWithData:file];
        }
    }
    else
    {
        NSLog(@"File does not exist");
    }
    return image;
}

- (void)saveImage:(UIImage *)image withName:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/Images/%@.jpg", name]];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:writableDBPath atomically:YES];
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldProceedAfterError:(NSError *)error copyingItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath{
    if ([error code] == 516) //error code for: The operation couldn’t be completed. File exists
        return YES;
    else
        return NO;
}

@end
