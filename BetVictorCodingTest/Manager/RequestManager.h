//
//  RequestManager.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

+ (void)downloadImageUsingUrl:(NSString *)url completion:(void(^)(UIImage *image))completion;

@end
