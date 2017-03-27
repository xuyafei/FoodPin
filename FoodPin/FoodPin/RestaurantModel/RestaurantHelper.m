//
//  RestaurantHelper.m
//  FoodPin
//
//  Created by polycom on 2017/3/17.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "RestaurantHelper.h"
#import "Restaurants.h"
#import <CoreData/CoreData.h>
#import "Restaurant.h"

@implementation RestaurantHelper

- (instancetype)init {
    self = [super init];
    
    if(self) {
        _testArray = [NSMutableArray arrayWithObjects:
                                 [Restaurants restaurantWithName:@"Cafe Deadend" type:@"Coffee & Tea Shop" location:@"G/F,72 Po Hing Fong, Sheung Wan, Hong Kong" phoneNumber: @"232-923423" image:@"cafedeadend.jpg" isVisited:YES],
                                 [Restaurants restaurantWithName:@"Homei" type:@"Cafe" location:@"Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong" phoneNumber: @"348-233423" image:@"homei.jpg" isVisited:YES],
                                 [Restaurants restaurantWithName:@"Teakha" type:@"Tea House" location:@"Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong" phoneNumber: @"354-243523" image:@"teakha.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Cafe Loisl" type:@"Austrian Causual Drink" location:@"Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong" phoneNumber: @"453-333423" image:@"cafeloisl.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"PetiteOyster" type:@"French" location:@"24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong" phoneNumber: @"983-284334" image:@"petiteoyster.jpg" isVisited:YES],
                                 [Restaurants restaurantWithName:@"For Kee Restaurant" type:@"Bakery" location:@"Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong" phoneNumber:@"232-434222" image:@"forkeerestaurant.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Po's Atelier" type:@"Bakery" location:@"G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong" phoneNumber:@"234-834322" image:@"posatelier.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Bourke Street Bakery" type:@"Chocolate" location:@"633 Bourke St Sydney New South Wales 2010 Surry Hills" phoneNumber:@"982-434343" image:@"bourkestreetbakery.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Haigh'sChocolate" type:@"Cafe" location:@"412-414 George St Sydney New South Wales" phoneNumber:@"734-232323" image:@"haighschocolate.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Palomino Espresso" type:@"American Seafood" location:@"Shop 1 61 York St Sydney New South Wales" phoneNumber: @"872-734343" image:@"palominoespresso.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Upstate" type:@"American" location:@"95 1st Ave New York, NY 10003" phoneNumber:@"343-233221" image:@"upstate.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Traif" type:@"American" location:@"229 S 4th St Brooklyn, NY 11211" phoneNumber:@"985-723623" image:@"traif.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Graham Avenue Meats AndDeli" type:@"Breakfast & Brunch" location:@"445 Graham Ave Brooklyn, NY 11211" phoneNumber: @"455-232345" image:@"grahamavenuemeats.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Waffle & Wolf" type:@"Coffee & Tea" location:@"413 Graham Ave Brooklyn, NY 11211" phoneNumber:@"434-232322" image:@"wafflewolf.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Five Leaves" type:@"Coffee& Tea" location:@"18 Bedford Ave Brooklyn, NY 11222" phoneNumber:@"343-234553" image:@"fiveleaves.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Cafe Lore" type:@"Latin American" location:@"Sunset Park 4601 4th Ave Brooklyn, NY 11220" phoneNumber:@"342-455433" image:@"cafelore.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Confessional" type:@"Spanish" location:@"308 E 6th St New York, NY 10003" phoneNumber:@"643-332323" image:@"confessional.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Barrafina" type:@"Spanish" location:@"54 Frith Street London W1D 4SL United Kingdom" phoneNumber:@"542-343434" image:@"barrafina.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Donostia" type:@"Spanish" location:@"10 Seymour Place London W1H 7ND United Kingdom" phoneNumber:@"722-232323" image:@"donostia.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"Royal Oak" type:@"British" location:@"2 Regency Street London SW1P 4BZ United Kingdom" phoneNumber:@"343-988834" image:@"royaloak.jpg" isVisited:NO],
                                 [Restaurants restaurantWithName:@"CASK Pub and Kitchen" type:@"Thai" location:@"22 Charlwood Street London SW1V 2DY Pimlico" phoneNumber:@"432-344050" image:@"thaicafe.jpg" isVisited:NO], nil];
        
        _restaurantMOC = [self contextWithModelName:@"FoodPin"];
    }
    return self;
}

- (void)createTestCoreData {
    for(int i = 0; i < _testArray.count; i++)  {
        Restaurant *restaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.restaurantMOC];
        restaurant.name = ((Restaurants *)_testArray[i]).name;
        restaurant.location = ((Restaurants *)_testArray[i]).location;
        restaurant.type = ((Restaurants *)_testArray[i]).type;
        restaurant.phoneNumber = ((Restaurants *)_testArray[i]).phoneNumber;
        restaurant.isVisited = [NSNumber numberWithBool:((Restaurants *)_testArray[i]).isVisited];
        restaurant.image = UIImagePNGRepresentation([UIImage imageNamed:((Restaurants *)_testArray[i]).iamge]);
    }
    
    NSError *error = nil;
    if(self.restaurantMOC.hasChanges) {
        [self.restaurantMOC save:&error];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"hasDidLoadCoreData"];
}

- (NSManagedObjectContext *)contextWithModelName:(NSString *)modelName {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", modelName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    context.persistentStoreCoordinator = coordinator;
    
    return context;
}

@end
