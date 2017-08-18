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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<Tag *> *tagsArray;
@property (nonatomic, strong) NSFetchedResultsController <Receipt *>*fetchedResultsController;
@property (nonatomic, strong) NSDictionary *receiptsDataSource;

//@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) AppDelegate *appDelegate;

// dictionary with keys: Personal, Biz, other with value arrays in each key

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self fetchData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Main Table View Helpers
- (void) fetchData
{
    NSFetchRequest *request = [Tag fetchRequest];// [[NSFetchRequest alloc] initWithEntityName:@"Tag"];
    
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    self.tagsArray = [appDelegate.context executeFetchRequest:request error:&error];
    
    self.receiptsDataSource = [NSDictionary dictionaryWithDictionary:[self prepareDataSource]];
}

- (NSMutableDictionary *)prepareDataSource
{
    NSMutableDictionary *tempDictionary = [NSMutableDictionary new];
    
    for (Tag *tag in self.tagsArray)
    {
        [tempDictionary setObject:tag.receipts forKey:tag.name];
    }
    
    return tempDictionary;
}

#pragma mark - Main Table View Data Source
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"receiptCell"];
    
    NSString *key = self.receiptsDataSource.allKeys[indexPath.section];
    NSArray *receipts = [[self.receiptsDataSource objectForKey:key] allObjects];
    
    Receipt *receipt = [receipts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = receipt.note;
    
    return cell;
}

#pragma mark - Main Table View Methods
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    Tag *tag = self.tagsArray[section];
    NSString *label = tag.name;
    return label;
}

#pragma mark - Main Table View Core Data

- (void)saveContext
{
    NSManagedObjectContext *context = self.appDelegate.self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
