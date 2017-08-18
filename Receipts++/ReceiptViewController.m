//
//  ReceiptViewController.m
//  Receipts++
//
//  Created by Elle Ti on 2017-08-17.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ReceiptViewController.h"
#import "AppDelegate.h"
#import "Tag+CoreDataClass.h"
#import "Receipt+CoreDataClass.h"

@interface ReceiptViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSArray <Tag *> *tags;
@property (nonatomic, strong) NSArray <Receipt *> *receipts;
@property (nonatomic, strong) NSMutableSet *selectedTags;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

@end

@implementation ReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self fetchInformationSetup];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fetchInformationSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.amountTextField resignFirstResponder];
    [self.descriptionTextField resignFirstResponder];
}

- (IBAction)doneButton:(UIButton *)sender
{
    [self viewControllerSetup];
    [self.appDelegate saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewControllerSetup
{
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Receipt *receipt = [[Receipt alloc] initWithContext:self.appDelegate.persistentContainer.viewContext]; // create & init receipt in memory
    receipt.amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    receipt.note = self.descriptionTextField.text;
    receipt.timeStamp = self.datePicker.date;
    receipt.tags = self.selectedTags;
    
    // Load receipt and tags from persistent storage
}

- (void)fetchInformationSetup
{
    NSError *error = nil;
    
    
    NSFetchRequest<Tag *> *fetchTagsRequest = [Tag fetchRequest];
    self.tags = [self.appDelegate.persistentContainer.viewContext executeFetchRequest:fetchTagsRequest error:&error];
    
    if (self.tags == nil)
    {
        Tag *tag = [[Tag alloc] initWithContext:self.appDelegate.persistentContainer.viewContext];
        tag.name = @"Personal";
        Tag *tag2 = [[Tag alloc] initWithContext:self.appDelegate.persistentContainer.viewContext];
        tag2.name = @"Business";
        Tag *tag3 = [[Tag alloc] initWithContext:self.appDelegate.persistentContainer.viewContext];
        tag3.name = @"Family";
        [self.appDelegate saveContext];
        
        NSFetchRequest<Tag *> *fetchTagsRequest = [Tag fetchRequest];
        self.tags = [self.appDelegate.persistentContainer.viewContext executeFetchRequest:fetchTagsRequest error:&error];
    }
}

- (IBAction)cancelButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return (@"Category");
    }
    return @"Test";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedTags addObject:self.tags[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedTags removeObject:self.tags[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Category"];
    cell.textLabel.text = [self.tags objectAtIndex:indexPath.row].name;
    
    return cell;
}

@end
