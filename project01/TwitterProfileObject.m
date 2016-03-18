//
//  TwitterProfileObject.m
//  project01
//
//  Created by Tyaa on 3/18/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//

#import "TwitterProfileObject.h"
#import "TwitterLoginObject.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define PROFILE_API @"https://api.twitter.com/1.1/users/show.json"
@import Social;

@interface TwitterProfileObject()

@property (nonatomic, strong) TwitterLoginObject *profileConnector;

@end

@implementation TwitterProfileObject

//connect
-(void)ConnectProfile {
    if(!self.profileConnector)
    {
        self.profileConnector = [[TwitterLoginObject alloc] init];
    }
    NSLog(@"request profile data");
    [self.profileConnector connectTwitterCompletion:^(ACAccount *account) {
        [self requestData:account];
    }];
}

- (void)requestData:(ACAccount *)account
{
    NSLog(@"requestData");
    
    NSURL *requestURL = [NSURL URLWithString:PROFILE_API];
    
    NSString *userName = [self.profileConnector getUsername];
    
    
    SLRequest *getRequest = [SLRequest
                             requestForServiceType:SLServiceTypeTwitter
                             requestMethod:SLRequestMethodGET
                             URL:requestURL parameters:[NSDictionary dictionaryWithObject:userName forKey:@"screen_name"]];
    
    getRequest.account = account;
    
    [getRequest
     performRequestWithHandler:^(NSData *responseData,
                                 NSHTTPURLResponse *urlResponse, NSError *error)
     {
         NSLog(@"Twitter Profile HTTP response: %li",
               (long)[urlResponse statusCode]);
         
         if (responseData) {
             NSError *error = nil;
             
             NSDictionary *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
             
             // Text data (fast, so in main queue)
             dispatch_async(dispatch_get_main_queue(), ^{
//                 NSUInteger followers = [[TWData objectForKey:@"followers_count"] integerValue];
//                 NSUInteger following = [[TWData objectForKey:@"friends_count"] integerValue];
//                 NSUInteger totalTweet = [[TWData objectForKey:@"statuses_count"]integerValue];
                 
                 self.profileScreenName.text = [NSString stringWithFormat:@"@%@",[TWData objectForKey:@"screen_name"]];
                 self.profileName.text = [TWData objectForKey:@"name"];
//                 self.userTweets.text = [NSString stringWithFormat:@"%lu", totalTweet];
//                 self.userFollowing.text= [NSString stringWithFormat:@"%lu", following];
//                 self.userFollowers.text = [NSString stringWithFormat:@"%lu", followers];
                 
                 NSLog(@"%@", self.profileName.text);
                 
             });
             
             NSLog(@"Seharusnya sudah keluar nama dkk");
             
             // Get the profile image in the original resolution
             
             NSString *profileImageStringURL = [TWData objectForKey:@"profile_image_url_https"];
             NSString *bannerImageStringURL =[TWData objectForKey:@"profile_banner_url"];
             profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
             
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 [self getProfileImageForURLString:profileImageStringURL];
                 
                 NSLog(@"%@", profileImageStringURL);
             });
             
             // Get the banner image, if the user has one
             if (bannerImageStringURL) {
                 NSString *bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
                 
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     [self getBannerImageForURLString:bannerURLString];
                 });
             }
             else {
                 self.bgUserTimeline.backgroundColor = [UIColor colorWithRed:22 green:227 blue:227 alpha:1];
             }
         }
     }];
}

- (void) getProfileImageForURLString:(NSString *)urlString;
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.profileImage sd_setImageWithURL:url];
    });
}

- (void) getBannerImageForURLString:(NSString *)urlString;
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.bgUserTimeline sd_setImageWithURL:url];
    });
}

@end
