//
//  Restaurant+CoreDataProperties.h
//  
//
//  Created by polycom on 2016/12/12.
//
//  This file was automatically generated and should not be edited.
//

#import "Restaurant+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Restaurant (CoreDataProperties)

+ (NSFetchRequest<Restaurant *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, retain) NSData *image;
@property (nonatomic) BOOL isVisited;

@end

NS_ASSUME_NONNULL_END
