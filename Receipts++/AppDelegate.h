//
//  AppDelegate.h
//  Receipts++
//
//  Created by Elle Ti on 2017-08-17.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) NSManagedObjectContext *context;

- (void)saveContext;


@end

