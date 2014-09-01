//
//  ImportImageViewController.h
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImportImageViewDelegate <NSObject>

- (void)downloadImageNamed:(NSString *)imageName withURL:(NSString *)url;

@end

@interface ImportImageViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) id<ImportImageViewDelegate> delegate;

@end
