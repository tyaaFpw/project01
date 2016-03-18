//
//  FBLoginObject.m
//  project01
//
//  Created by Tyaa on 3/18/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//

#import "FBLoginObject.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "LoginVC.h"

@interface FBLoginObject()

@property (nonatomic, strong) LoginVC *loginView;

@end

@implementation FBLoginObject

- (void)fbLoginManager {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc]init];
    
    [loginManager logInWithReadPermissions:@[@"public_profile"] fromViewController:self.loginView handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if ([FBSDKAccessToken currentAccessToken]) {
            NSLog(@"Token is Available: %@", [[FBSDKAccessToken currentAccessToken]tokenString]);
            [self fetchingFBUserInfo];
        } else {
            [loginManager logInWithReadPermissions:@[@"email"] fromViewController:self.loginView handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                if (error) {
                    NSLog(@"Login process error. Desc: %@", error);
                    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                } else if (result.isCancelled) {
                    NSLog(@"User Cancelled login");
                } else {
                    NSLog(@"Login Success..!!");
                    [SVProgressHUD showSuccessWithStatus:@"Login Success.."];
                    
                    if ([result.grantedPermissions containsObject:@"email"]) {
                        NSLog(@"result is: %@", result);
                        [self  fetchingFBUserInfo];
                    } else {
                        [SVProgressHUD showErrorWithStatus:@"Facebook email permission error.."];
                    }
                }
            }];
        }
    }];
}

- (void)fetchingFBUserInfo {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Token is Available: %@", [[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email, picture.type(normal)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSLog(@"Results: %@", result);
                
                self.userEmail = [result objectForKey:@"email"];
                self.userID = [result objectForKey:@"id"];
                self.userName = [result objectForKey:@"name"];
                self.pictureURL = [NSString stringWithFormat:@"%@", [result objectForKey:@"picture"]];
                
                //                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.pictureURL]];
                //                self.mainHall.facebookProfilePict.image = [UIImage imageWithData:data];
                //
                //                self.mainHall.profilePictureView = [[FBSDKProfilePictureView alloc]initWithFrame:self.mainHall.facebookProfilePict.frame];
                //                [self.mainHall.profilePictureView setProfileID:result[@"id"]];
                
                if (self.userEmail.length > 0) {
                    NSLog(@"%@", self.userName);
                    NSLog(@"%@", self.userEmail);
                    NSLog(@"%@", self.userID);
                    
                    //                    self.mainHall = [[MainNavC alloc]initWithNibName:@"MainNavC" bundle:nil];
                    //                    self.mainHall.name = self.userName;
                    //                    self.mainHall.email= self.userEmail;
                    //                    self.mainHall.accountID = self.userID;
                    
                    //                    [self.navigationController pushViewController:self.mainHall animated:YES];
                    
                } else {
                    NSLog(@"Facebook email is not verified");
                }
            } else {
                NSLog(@"ERROR: %@", error);
            }
        }];
    }
}

@end
