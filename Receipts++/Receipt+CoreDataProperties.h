//
//  Receipt+CoreDataProperties.h
//  Receipts++
//
//  Created by Elle Ti on 2017-08-17.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "Receipt+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Receipt (CoreDataProperties)

+ (NSFetchRequest<Receipt *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *amount;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSDate *timeStamp;
@property (nullable, nonatomic, retain) NSSet<Tag *> *tags;

@end

@interface Receipt (CoreDataGeneratedAccessors)

- (void)addTagObject:(Tag *)value;
- (void)removeTagObject:(Tag *)value;
- (void)addTag:(NSSet<Tag *> *)values;
- (void)removeTag:(NSSet<Tag *> *)values;

@end

NS_ASSUME_NONNULL_END
