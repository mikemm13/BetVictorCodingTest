//
//  ImportImageViewController.m
//  BetVictorCodingTest
//
//  Created by Miguel Martin Nieto on 01/09/14.
//  Copyright (c) 2014 Miguel Martín-Nieto. All rights reserved.
//

#import "ImportImageViewController.h"

@interface ImportImageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation ImportImageViewController

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
    self.nameTextField.delegate = self;
    self.urlTextField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressedDownload:(id)sender {
    if ([self.nameTextField.text isEqualToString:@""] || [self.urlTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You should fill both fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    } else {
        [self.delegate downloadImageNamed:self.nameTextField.text withURL:self.urlTextField.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (IBAction)pressedCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissKeyboard {
    [self.nameTextField resignFirstResponder];
    [self.urlTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}




@end
