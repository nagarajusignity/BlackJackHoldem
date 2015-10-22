//
//  SelectViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/25/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "SelectViewController.h"
#import "GameAreaViewController.h"
#import "DocumentViewController.h"
#import "LevelselectionViewController.h"
#import "AppDelegate.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /***
     * Background ImageView
     **/
    
    UIImage *image;
    if(isiPhone5())
    {
    image=[UIImage imageNamed:@"select-space"];
    }
    else
    {
        image =[UIImage imageNamed:@"select-space_iphone4"];
    }
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    [self.view addSubview:imageViewBG];
    
    
    /***
     * Login Button
     **/
    
    UIButton *playNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playNowButton addTarget:self
                    action:@selector(playNowPressed)
          forControlEvents:UIControlEventTouchUpInside];
    playNowButton.backgroundColor =[UIColor clearColor];
    [playNowButton setBackgroundImage:[UIImage imageNamed:@"playnow"] forState:UIControlStateNormal];
    
    playNowButton.frame = CGRectMake(158+48*isiPhone5(), 180, 170, 56);//206
    [self.view addSubview:playNowButton];
    
    /***
     * Id Document Button
     **/
    
    UIButton *docButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [docButton addTarget:self
                      action:@selector(docButtonPressed)
            forControlEvents:UIControlEventTouchUpInside];
    docButton.backgroundColor =[UIColor clearColor];
    [docButton setBackgroundImage:[UIImage imageNamed:@"document"] forState:UIControlStateNormal];
    docButton.frame = CGRectMake(158+48*isiPhone5(), 240, 170, 56);
    [self.view addSubview:docButton];
    
    
    /***
     * Back Button
     **/
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor =[UIColor clearColor];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    //[backButton setTitle:@"Back" forState:UIControlStateNormal];
    //[backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //backButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:20];
    backButton.frame = CGRectMake(20, 15, 60, 22);
    [self.view addSubview:backButton];

}

#pragma mark Back Button Action

-(void)backButtonPressed

{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark Play Button Action

-(void)playNowPressed
{
//    GameAreaViewController *gameArea =[[GameAreaViewController alloc]init];
//    [self.navigationController pushViewController:gameArea animated:NO];
    
    LevelselectionViewController *levelSelect =[[LevelselectionViewController alloc]init];
    [self.navigationController pushViewController:levelSelect animated:NO];
}

#pragma mark Document Button Action

-(void)docButtonPressed
{
    DocumentViewController *documentView =[[DocumentViewController alloc]init];
    [self.navigationController pushViewController:documentView animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
