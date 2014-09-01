//
//  PictureLibraryViewController.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 31/08/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "PictureLibraryViewController.h"
#import "PictureLibraryTableViewManager.h"
#import "PictureDetailsViewController.h"
#import "Image.h"
#import "ImportImageViewController.h"
#import "RequestManager.h"
#import "Image+Model.h"

@interface PictureLibraryViewController ()
@property (strong, nonatomic) PictureLibraryTableViewManager *tableViewManager;

@end

@implementation PictureLibraryViewController

- (PictureLibraryTableViewManager *)tableViewManager{
    if (!_tableViewManager) {
        _tableViewManager = [[PictureLibraryTableViewManager alloc] initWithMOC:self.managedObjectContext imagesManager:self.imagesManager];
    }
    return _tableViewManager;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    self.tableViewManager.tableView = self.tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Image *imageSelected = [self.tableViewManager.fetchedResultsController objectAtIndexPath:indexPath];
        PictureDetailsViewController *detailVC = [segue destinationViewController];
        detailVC.imageItem = imageSelected;
        detailVC.imagesManager = self.imagesManager;
    } else if ([segue.identifier isEqualToString:@"importSegue"]){
        ImportImageViewController *importImageViewController = [segue destinationViewController];
        importImageViewController.delegate = self;
    }
}

#pragma mark - ImportImageViewDelegate method

- (void)downloadImageNamed:(NSString *)imageName withURL:(NSString *)url {
    __block Image *imageToSave = [Image createImageInMOC:self.managedObjectContext withName:imageName];
    
    [RequestManager downloadImageUsingUrl:url completion:^(UIImage *image) {
        [self.imagesManager saveImage:image withName:imageName];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        NSInteger size = [imageData length]/1024;
        imageToSave.size = [NSString stringWithFormat:@"%i KB", size];
        [self saveContext];
    }];
}

- (void) saveContext {
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}



@end
