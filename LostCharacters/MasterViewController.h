//
//  MasterViewController.h
//  LostCharacters
//
//  Created by Wade Sellers on 10/21/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

