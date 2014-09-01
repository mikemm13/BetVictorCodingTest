//
//  PersonalProfileViewController.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "PersonalProfileViewController.h"

@interface PersonalProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkedinLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *githubLabel;

@end

@implementation PersonalProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2.0;
    self.profileImage.layer.borderWidth = 2.0;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self loadDataFromPlist];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataFromPlist {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UserProfileInfo" ofType:@"plist"];
    NSDictionary *userFromFile = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    self.nameLabel.text = [userFromFile valueForKey:@"name"];
    self.twitterLabel.text = [userFromFile valueForKey:@"twitter"];
    self.linkedinLabel.text = [userFromFile valueForKey:@"linkedin"];
    self.githubLabel.text = [userFromFile valueForKey:@"github"];
    self.emailLabel.text = [userFromFile valueForKey:@"email"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
