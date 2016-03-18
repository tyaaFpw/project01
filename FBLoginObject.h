//
//  FBLoginObject.h
//  project01
//
//  Created by Tyaa on 3/18/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface FBLoginObject : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) FBSDKProfilePictureView *profilePictureView;


- (void)fbLoginManager;

@end
