//
//  PictureDetailsViewController.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "PictureDetailsViewController.h"

@interface PictureDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@property (weak, nonatomic) IBOutlet UILabel *imageSize;
@property (weak, nonatomic) IBOutlet UILabel *imageImportDate;
@property (nonatomic) BOOL zoomed;

@end

@implementation PictureDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.selectedImage setUserInteractionEnabled:YES];
    [self loadDetailData];
    [self addZoomingCapabilities];
}

- (void)loadDetailData
{
    // Do any additional setup after loading the view.
    UIImage *image = [self.imagesManager loadImageNamed:self.imageItem.name];
    self.selectedImage.image = image;
    self.imageName.text = self.imageItem.name;
    self.imageSize.text = self.imageItem.size;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.imageImportDate.text = [dateFormatter stringFromDate:self.imageItem.importDate];
}

- (void)addZoomingCapabilities{
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinch:)];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    tapGestureRecognizer.numberOfTapsRequired = 2; // Need a double tap
    [self.selectedImage addGestureRecognizer:pinchGestureRecognizer];
    [self.selectedImage addGestureRecognizer:tapGestureRecognizer];
    [self.selectedImage addGestureRecognizer:panGestureRecognizer];
}

- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.scale >1.0f && recognizer.scale < 2.5f) {
        CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
        self.selectedImage.transform = transform;
    }
}

- (void)doubleTap:(UITapGestureRecognizer *)recognizer {
    CGAffineTransform transform;
    if (!self.zoomed) {
        transform = CGAffineTransformMakeScale(2.5f, 2.5f);
        self.zoomed = YES;
    } else {
        transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.zoomed = NO;
    }
    self.selectedImage.transform = transform;
}

- (void)onPan:(UIPanGestureRecognizer *)recognizer {
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
    else if(state==UIGestureRecognizerStateEnded){
        UIView *imageView = recognizer.view;
        UIView *container = imageView.superview;
        
        CGFloat targetX = CGRectGetMinX(imageView.frame);
        CGFloat targetY = CGRectGetMinY(imageView.frame);
        
        
        if(targetX>0){
            targetX = 0;
        }else if(CGRectGetMaxX(imageView.frame)<CGRectGetWidth(container.bounds)){
            targetX = CGRectGetWidth(container.bounds)-CGRectGetWidth(imageView.frame);
        }
        
        if(targetY>0){
            targetY = 0;
        }else if(CGRectGetMaxY(imageView.frame)<CGRectGetHeight(container.bounds)){
            targetY = CGRectGetHeight(container.bounds)-CGRectGetHeight(imageView.frame);
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.frame = CGRectMake(targetX, targetY, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame));
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedShare:(id)sender {
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[self.selectedImage.image] applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    [self presentViewController:controller animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
