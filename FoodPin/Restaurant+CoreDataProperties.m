//
//  Restaurant+CoreDataProperties.m
//  
//
//  Created by polycom on 2016/12/12.
//
//  This file was automatically generated and should not be edited.
//

#import "Restaurant+CoreDataProperties.h"

@implementation Restaurant (CoreDataProperties)

+ (NSFetchRequest<Restaurant *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Restaurant"];
}

@dynamic phoneNumber;
@dynamic type;
@dynamic name;
@dynamic location;
@dynamic image;
@dynamic isVisited;

@end
