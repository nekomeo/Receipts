//
//  ReceiptViewController.h
//  Receipts++
//
//  Created by Elle Ti on 2017-08-17.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol ReceiptViewControllerDelegate <NSObject>


@end

@interface ReceiptViewController : UIViewController
@property (nonatomic, weak) id<ReceiptViewControllerDelegate> delegate;

@end
