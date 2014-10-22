
#import "MasterViewController.h"
#import "AddMemberViewController.h"
#import "CustomTableViewCell.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *sortedCharactersArray;



@end

@implementation MasterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPlistIntoCoreData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];

}

- (void) loadPlistIntoCoreData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"tableViewPopulated"])
    {

        NSString *pathToLostPlist = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"];
        NSLog(@"%@", pathToLostPlist);
        NSArray *items = [NSArray arrayWithContentsOfFile:pathToLostPlist];

        for(NSDictionary *item in items)
        {
            NSManagedObject *castMember = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
            [castMember setValue:[item valueForKey:@"actor"] forKey:@"actorName"];
            [castMember setValue:[item valueForKey: @"passenger"] forKey:@"passengerName"];
        }

        [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"tableViewPopulated"];
        [defaults synchronize];
    }
        [self.managedObjectContext save:nil];
        [self loadData];
}


- (void)loadData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    NSSortDescriptor *actorAToZ = [[NSSortDescriptor alloc] initWithKey:@"actorName" ascending:YES];

    request.sortDescriptors = [NSArray arrayWithObjects:actorAToZ, nil];
    self.sortedCharactersArray = [self.managedObjectContext executeFetchRequest:request error:nil];

    [self.tableView reloadData];

}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sortedCharactersArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *lostCharacter = [self.sortedCharactersArray objectAtIndex:indexPath.row];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.actorNameLabel.text = [lostCharacter valueForKey:@"actorName"];
    cell.passengerNameLabel.text = [lostCharacter valueForKey:@"passengerName"];
    cell.seatNumberLabel.text = [lostCharacter valueForKey:@"planeSeat"];
    cell.genderLabel.text = [lostCharacter valueForKey:@"gender"];
    cell.hairColorLabel.text = [lostCharacter valueForKey:@"hairColor"];

    return cell;
}

-(IBAction)unwindFromAddMemberViewController:(UIStoryboardSegue *)segue
{
    AddMemberViewController *addMemberViewController = segue.sourceViewController;
    NSManagedObject *castMember = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
    [castMember setValue:addMemberViewController.actorNameField.text forKey:@"actorName"];
    [castMember setValue:addMemberViewController.castMemberField.text forKey:@"passengerName"];
    [castMember setValue:addMemberViewController.passengerSeatField.text forKey:@"planeSeat"];
    [castMember setValue:addMemberViewController.genderField.text forKey:@"gender"];
    [castMember setValue:addMemberViewController.hairColorField.text forKey:@"hairColor"];

    [self.managedObjectContext save:nil];
    [self loadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.managedObjectContext deleteObject:[self.sortedCharactersArray objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        [self loadData];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"SMOKE MONSTER!!!";
}

@end
