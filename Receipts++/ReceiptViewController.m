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

@interface ReceiptViewController ()
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSArray <Tag *> *tag;

@end

@implementation ReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneButton:(UIButton *)sender
{
    
    [self coreDataSetup];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)coreDataSetup
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate saveContext];
    
    NSPersistentContainer *persistentContainer = appDelegate.persistentContainer;
    
    // Load receipt and tags from persistent storage
    NSError *error = nil;
//    NSFetchRequest<Tag *> *fetchTagsRequest = [Tag fetchRequest];
//    self.tag = [persistentContainer.viewContext executeFetchRequest:fetchTagsRequest error:&error];
}

- (IBAction)cancelButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
