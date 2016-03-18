//
//  TwitterProfileObject.h
//  project01
//
//  Created by Tyaa on 3/18/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TwitterProfileObject : NSObject

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileScreenName;
@property (weak, nonatomic) IBOutlet UITableView *profileUserTimeline;
@property (weak, nonatomic) IBOutlet UIImageView *bgUserTimeline;
@property (weak, nonatomic) IBOutlet UILabel *userTweets;
@property (weak, nonatomic) IBOutlet UILabel *userFollowing;
@property (weak, nonatomic) IBOutlet UILabel *userFollowers;

-(void)ConnectProfile;

@end
