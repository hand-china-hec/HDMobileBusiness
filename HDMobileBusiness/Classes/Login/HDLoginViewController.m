//
//  RCLoginViewController.m
//  HRMS
//
//  Created by Rocky Lee on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDLoginViewController.h"

@implementation HDLoginViewController

@synthesize username = _username;
@synthesize password = _password;

@synthesize backgroundImage = _backgroundImage;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_backgroundImage);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setAutoresizesForKeyboard:YES];
        self.model = [[HDLoginModel alloc]init];        
        
//        NSString * path = [NSString  stringWithFormat:@"%@",kResourceRootPath,@"[@name='LOGIN_TITLE']"];
//        NSString * title = [[HDGodXMLFactory shareBeanFactory]stringFroXPath:path attributeName:@"value"];
//        [(UILabel*)[self.view viewWithTag:2] setText:title];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _username.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    _password.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
}

#pragma login functions
-(IBAction)loginBtnPressed:(id)sender{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [[(HDLoginModel *)_model loginBean] setUsername:_username.text];
    [[(HDLoginModel *)_model loginBean] setPassword:_password.text];
    [(HDLoginModel *)_model login];
}

//模型delegate方法
- (void)modelDidFinishLoad:(HDLoginModel *)model
{    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)model:(id<TTModel>)model didFailLoadWithError:(NSError*)error
{
    NSString * errorDescription = nil;
    if (!errorDescription) {
        errorDescription = [[error userInfo] valueForKeyPath:@"error"];
    }
    if (!errorDescription) {
        errorDescription = [error localizedDescription];
    }
    TTAlertNoTitle(errorDescription);
}

#pragma animations for keyborad
-(void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds
{
    [UIView beginAnimations:@"keyboardAnimation" context:NULL];
    for (UIView * subView in [self.view subviews]) {
        CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(0, -140);
        [subView.layer setAffineTransform:moveTransform];
    }
    [UIView commitAnimations];
}

-(void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds
{
    [UIView beginAnimations:@"keyboardAnimation" context:NULL];
    for (UIView * subView in [self.view subviews]) {
        CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(0, 0);
        [subView.layer setAffineTransform:moveTransform];
    }
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
    self.backgroundImage = TTIMAGE(@"documents://login_background.png");
    if (nil!= self.backgroundImage) {
        [(UIImageView *)[self.view viewWithTag:9] setImage:self.backgroundImage];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
