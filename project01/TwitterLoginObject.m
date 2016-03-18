//
//  TwitterLoginObject.m
//  project01
//
//  Created by Tyaa on 3/18/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//

#import "TwitterLoginObject.h"
#import <Accounts/ACAccount.h>
#import <Accounts/ACAccountStore.h>
#import <Accounts/ACAccountType.h>

@import Social;


@implementation TwitterLoginObject

- (void)connectTwitterCompletion:(void(^)(ACAccount *))completion {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:
                                  ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSLog(@"can access twitter account");
             
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 _twitterAccount =
                 [arrayOfAccounts firstObject];
                 if (completion) {
                     completion(_twitterAccount);
                 }
             }
             
         }
     }];
}

-(NSString *)getUsername {
    return _twitterAccount.username;
}

@end
