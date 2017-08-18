//
//  Receipt+CoreDataProperties.m
//  Receipts++
//
//  Created by Elle Ti on 2017-08-17.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "Receipt+CoreDataProperties.h"

@implementation Receipt (CoreDataProperties)

+ (NSFetchRequest<Receipt *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Receipt"];
}

@dynamic amount;
@dynamic note;
@dynamic timeStamp;
@dynamic tags;

@end
