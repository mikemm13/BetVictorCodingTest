//
//  RequestManager.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+ (void)downloadImageUsingUrl:(NSString *)url completion:(void(^)(UIImage *image))completion {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:url]
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      UIImage *img = [UIImage imageWithData:data];
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          completion(img);
                                      });
                                      
                                      
                                  }];
    
    [task resume];
}

@end
