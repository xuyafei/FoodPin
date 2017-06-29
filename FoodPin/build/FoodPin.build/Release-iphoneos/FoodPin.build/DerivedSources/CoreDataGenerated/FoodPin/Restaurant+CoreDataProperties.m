//
//  Restaurant+CoreDataProperties.m
//  
//
//  Created by polycom on 2017/6/13.
//
//  This file was automatically generated and should not be edited.
//

#import "Restaurant+CoreDataProperties.h"

@implementation Restaurant (CoreDataProperties)

+ (NSFetchRequest<Restaurant *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Restaurant"];
}

@dynamic image;
@dynamic isVisited;
@dynamic location;
@dynamic name;
@dynamic phoneNumber;
@dynamic type;

@end
