//
//  TwitterLoginObject.h
//  project01
//
//  Created by Tyaa on 3/18/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ACAccount;

@interface TwitterLoginObject : NSObject

@property (nonatomic, strong) ACAccount *twitterAccount;

-(void)connectTwitterCompletion:(void(^)(ACAccount *account))completion;
-(NSString *)getUsername;

@end
