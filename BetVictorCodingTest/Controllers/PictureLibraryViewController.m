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
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Image *imageSelected = [self.tableViewManager.fetchedResultsController objectAtIndexPath:indexPath];
    PictureDetailsViewController *detailVC = [segue destinationViewController];
    detailVC.imageItem = imageSelected;
    detailVC.imagesManager = self.imagesManager;
}


@end
