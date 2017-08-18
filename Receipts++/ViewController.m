//
//  ViewController.m
//  Receipts++
//
//  Created by Elle Ti on 2017-08-17.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ViewController.h"
#import "ReceiptViewController.h"
#import "ReceiptTableViewCell.h"
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"
#import "AppDelegate.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, ReceiptViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<Tag *> *tagsArray;
@property (nonatomic, strong) NSFetchedResultsController <Receipt *>*fetchedResultsController;
@property (nonatomic, strong) NSDictionary *receiptsDataSource;

//@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// dictionary with keys: Personal, Biz, other with value arrays in each key

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers
- (void) fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Tag"];
    
    NSError *error = nil;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    self.tagsArray = [appDelegate.context executeFetchRequest:request error:&error];
    
    self.receiptsDataSource = [NSDictionary dictionaryWithDictionary:[self prepareDataSource]];
}

- (NSMutableDictionary *)prepareDataSource
{
    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    
    for (Tag* tag in self.tagsArray) {
        [tempDict setObject:tag.receipts forKey:tag.name];
    }
    
    return tempDict;
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.receiptsDataSource.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.receiptsDataSource.allKeys[section];
    NSSet *receipts = [self.receiptsDataSource objectForKey:key];
    return receipts.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"receiptCell"];
    
    NSString *key = self.receiptsDataSource.allKeys[indexPath.section];
    NSArray *receipts = [[self.receiptsDataSource objectForKey:key] allObjects];
    
    Receipt *receipt = [receipts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = receipt.note;
    
    return cell;
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toNewReceipt"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.receiptArray[indexPath.row];
        ReceiptViewController *rVC = (ReceiptViewController *)[segue destinationViewController];
    }
}

#pragma mark - Core Data
- (void)coreDataSetup
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.persistentContainer = appDelegate.persistentContainer;
    
    NSError *error = nil;
}

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
