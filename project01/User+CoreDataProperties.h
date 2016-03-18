//
//  User+CoreDataProperties.h
//  project01
//
//  Created by Tyaa on 3/18/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSManagedObject *userMusic;

@end

NS_ASSUME_NONNULL_END
