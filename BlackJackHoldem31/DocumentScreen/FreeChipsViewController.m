//
//  FreeChipsViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "FreeChipsViewController.h"
#import "AppDelegate.h"
#import "WebServiceInterface.h"

@interface FreeChipsViewController ()
{
    NSString *strTimeRemaining;
    UILabel  *timerLbl;
}
@end

@implementation FreeChipsViewController
@synthesize progressView;
int hours, minutes, seconds;
int secondsLeft;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /***
     * Background ImageView
     **/
    
    UIImage *image;
    if(isiPhone5())
    {
        image=[UIImage imageNamed:@"background-iphone5"];
    }
    else
    {
        image=[UIImage imageNamed:@"background-iphone4"];
    }
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    [self.view addSubview:imageViewBG];
    
    /***
     * Back Button
     **/
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor =[UIColor clearColor];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(20, 15, 60, 22);
    [self.view addSubview:backButton];
    
    UITextView *Textview = [[UITextView alloc]initWithFrame:CGRectMake(20,30,440+88*isiPhone5(),280)];
    Textview.font = [UIFont fontWithName:@"Arial-BoldMT" size:12+2*isiPhone5()];
    Textview.backgroundColor = [UIColor clearColor];
    Textview.scrollEnabled = NO;
    Textview.editable = NO;
    Textview.text=@"VIGILANCE IS VITAL\nIt is the duty of all Drones, Workers and Citizens to report any sedition that will bedetremental to the day to day operations or the safety of members of TexLon.\nInform Now\nSeen a gathering of nieghbours or friends which seems suspicious\nInform Now\nHeard whispers at night between your co-workers or your drone teammates\nInform Now\nSeen strange comings and going at night next door\nInform Now\nNo piece of information, no matter how big or small should not go unreported\nHave YOU made a report today \nRemember VIGILANCE IS VITAL for the safety of all TexLon subjects 10,000 earth credits have being deposited in your Solar Bank Account\nYour next report is due in";
    Textview.textColor = [UIColor whiteColor];
    [self.view addSubview:Textview];
    
    /***
     * Timer Labe
     **/
    
    timerLbl = [[UILabel alloc] init];
    timerLbl.frame = CGRectMake(174+23*isiPhone5(), 272+8*isiPhone5(),40+10*isiPhone5(),15);
    timerLbl.textAlignment = NSTextAlignmentCenter;
    timerLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    timerLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12+2*isiPhone5()];
    timerLbl.backgroundColor = [UIColor clearColor];
    timerLbl.adjustsFontSizeToFitWidth=YES;
    //timerLbl.text=@"00:00:00";
    [self.view addSubview:timerLbl];
    
    /***
     * Rember Button Button
     **/
    
    
    checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBox.backgroundColor =[UIColor clearColor];
     if([timerLbl.text isEqualToString:@"00:00:00"])
    [checkBox setBackgroundImage:[UIImage imageNamed:@"Withoutcheck"] forState:UIControlStateNormal];
    else
    [checkBox setBackgroundImage:[UIImage imageNamed:@"Withcheck"] forState:UIControlStateSelected];
    [checkBox addTarget:self
                       action:@selector(checkButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    checkBox.frame = CGRectMake(205+30*isiPhone5(), 230+2*isiPhone5(),15,15);
    [self.view addSubview:checkBox];
    
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Getting Info"];
    objAPI.showActivityIndicator = YES;
    NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=timer_detail&user_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
    [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonTimerInfoResponse:)];
    objAPI = nil;
   
}
-(void)jsonTimerInfoResponse:(id)responseDict
{
    //NSLog(@"responseDict....%@",responseDict);
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];

    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
        [timer invalidate];
        secondsLeft =[[[[responseDict valueForKey:@"data"] valueForKey:@"available_time"] objectAtIndex:0] intValue] ;
        [self countdownTimer];
        
    }
    else if([[responseDict valueForKey:@"success"] integerValue]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
}

-(void)checkButtonPressed
{
    if([timerLbl.text isEqualToString:@"00:00:00"])
    {
        checkBox.selected=YES;
        [checkBox setBackgroundImage:[UIImage imageNamed:@"Withcheck"] forState:UIControlStateSelected];
         
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        NSString *tzName = [timeZone name];

        
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Getting Info"];
        objAPI.showActivityIndicator = YES;
        NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
        
        NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=add_point_timer&user_id=%@&timezone=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],tzName];
        [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonInfoResponse:)];
        objAPI = nil;
        
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You have already used your free chips.Please check your timer for next chance,best of luck 👍" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)jsonInfoResponse:(id)responseDict
{
    //NSLog(@"responseDict....%@",responseDict);
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    
    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
        [timer invalidate];
        secondsLeft =[[[[responseDict valueForKey:@"data"] valueForKey:@"available_time"] objectAtIndex:0] intValue] ;
        [self countdownTimer];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:self
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
       
    }
    else if([[responseDict valueForKey:@"success"] integerValue]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
}
- (void)updateCounter:(NSTimer *)theTimer
{
    if(secondsLeft > 0 )
    {
        checkBox.selected=YES;
        [checkBox setBackgroundImage:[UIImage imageNamed:@"Withcheck"] forState:UIControlStateSelected];
        secondsLeft -- ;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        timerLbl.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    else{
        checkBox.selected=NO;
        [checkBox setBackgroundImage:[UIImage imageNamed:@"Withoutcheck"] forState:UIControlStateNormal];
        [timer invalidate];
        secondsLeft = 0;
        timerLbl.text=@"00:00:00";
    }
}

-(void)countdownTimer{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}
-(void)backButtonPressed
{
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:NO];
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
