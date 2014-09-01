//
//  PictureLibraryTableViewManager.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 31/08/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "PictureLibraryTableViewManager.h"
#import "Image.h"
#import "PictureLibraryTableViewCell.h"

@interface PictureLibraryTableViewManager ()

@property (strong, nonatomic)NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ImagesManager *imagesManager;
@end

NSInteger const dashboardItemsHeight = 150;

@implementation PictureLibraryTableViewManager

- (instancetype)initWithMOC:(NSManagedObjectContext *)managedObjectContext imagesManager:(ImagesManager *)imagesManager
{
    self = [super init];
    if (self) {
        _managedObjectContext = managedObjectContext;
        _imagesManager = imagesManager;
        [self loadFetchedResultController];
    }
    return self;
}

- (void)setTableView:(UITableView *)tableView{
    _tableView = tableView;
    _tableView.rowHeight = dashboardItemsHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
}

- (void)loadFetchedResultController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity=[NSEntityDescription entityForName:@"Image" inManagedObjectContext:self.managedObjectContext];
    //fetchRequest.predicate=[self defaultPredicate];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate=self;
    NSError *error=nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=[[self.fetchedResultsController.sections objectAtIndex:0] numberOfObjects];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
    Image *item = (Image *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    UIImage *image = [self.imagesManager loadImageNamed:item.name];
    cell.previewImageView.image = image;
    cell.pictureLabel.text = item.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableViewRowAnimation animation = UITableViewRowAnimationFade;
    NSIndexPath *changeIndexPath=indexPath;
    NSIndexPath *newChangeIndexPath=newIndexPath;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newChangeIndexPath] withRowAnimation:animation];
            break;
        case NSFetchedResultsChangeMove:
            if ([self.tableView respondsToSelector:@selector(moveRowAtIndexPath:toIndexPath:)]) {
                [self.tableView moveRowAtIndexPath:changeIndexPath toIndexPath:newChangeIndexPath];
            } else {
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:changeIndexPath] withRowAnimation:animation];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:newChangeIndexPath.section] withRowAnimation:animation];
            }
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:changeIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:changeIndexPath] withRowAnimation:animation];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSIndexSet *indexSetWithSectionIndex = [NSIndexSet indexSetWithIndex:sectionIndex];
    
    UITableViewRowAnimation animation = UITableViewRowAnimationFade;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:indexSetWithSectionIndex withRowAnimation:animation];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:indexSetWithSectionIndex withRowAnimation:animation];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}


@end
