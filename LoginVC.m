//
//  loginVC.m
//  project01
//
//  Created by Tyaa on 3/17/16.
//  Copyright © 2016 Tyaa. All rights reserved.
//

#import "LoginVC.h"
#import "FBLoginObject.h"
#import "TwitterProfileObject.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *btngplus;
@property (weak, nonatomic) IBOutlet UIButton *btntwitter;
@property (weak, nonatomic) IBOutlet UIButton *btnfacebook;

@property (strong, nonatomic) FBLoginObject *loginObject;
@property (strong, nonatomic) TwitterProfileObject *twitterProfile;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)didTappedBtnGPlus:(id)sender {
}

- (IBAction)didTappedBtnTwitter:(id)sender {
    self.twitterProfile = [[TwitterProfileObject alloc]init];
    [self.twitterProfile ConnectProfile];
}

- (IBAction)didTappedBtnFacebook:(id)sender {
    
    self.loginObject = [[FBLoginObject alloc]init];
    [self.loginObject fbLoginManager];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
