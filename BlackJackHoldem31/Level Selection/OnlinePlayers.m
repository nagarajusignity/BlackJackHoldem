//
//  OnlinePlayers.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "OnlinePlayers.h"
#import "AppDelegate.h"
#import "WebServiceInterface.h"

@implementation OnlinePlayers
static  OnlinePlayers * sharedMyManager = nil;
@synthesize progressView;

+ (id)sharedManager
{
    @synchronized(self)
    {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}
-(void)ShowViewWithPlayersWhoAreOnline:(UIView*)view
{
    
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:appDelegate().window withTitle:@"Loading"];
    objAPI.showActivityIndicator = YES;
    NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=Players_playingCount"];
    NSLog(@"postData---> = %@",postData);
    [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataPlayerInfoResponse:)];
     objAPI = nil;
    
    levelsArray =[[NSMutableArray alloc]initWithObjects:@"EARTH",@"LUNA",@"MARS",@"CERES",@"IOA",@"TITAN", nil];

    
    view_Background = [[UIView alloc] init];
    view_Background.frame = view.bounds;
    [view addSubview:view_Background];
    [view bringSubviewToFront:view_Background];
    view_Background.backgroundColor = [UIColor blackColor];
    view_Background.alpha = 0.60;
    
    bgView = [[UIView alloc] init];
    bgView.frame = view.bounds;
    [view addSubview:bgView];
    [view bringSubviewToFront:bgView];
    
    
    customiseAlertView = [[UIView alloc] init];
    alert_width = 442;
    alert_height = 250;//270
    
    customiseAlertView.frame = CGRectMake(((bgView.frame.size.width-alert_width)/2.0), ((bgView.frame.size.height-alert_height)/2.0), alert_width, alert_height);
 customiseAlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customiseAlertView .backgroundColor=[UIColor clearColor];
    customiseAlertView.layer.masksToBounds = NO;
    
    /***
     * Background Image
     **/
    
    UIImage *backgroundImage =[UIImage imageNamed:@"pop-back.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithImage:backgroundImage];
    backgroundImageView.frame=CGRectMake(0,0,alert_width , alert_height);
    [customiseAlertView addSubview:backgroundImageView];
    
    
    /***
     * Top Bar ImageView
     **/
    
    UIImage *TitleImage =[UIImage imageNamed:@"solerbank"];
    UIImageView *TitleImageView=[[UIImageView alloc]initWithImage:TitleImage];
    TitleImageView.frame=CGRectMake(55,35,TitleImage.size.width , TitleImage.size.height);
    [customiseAlertView addSubview:TitleImageView];
    
    
    UILabel* LevelLbl = [[UILabel alloc] init];
    LevelLbl.frame = CGRectMake(10,0,TitleImage.size.width-100 , TitleImage.size.height);
    LevelLbl.textAlignment = NSTextAlignmentLeft;
    LevelLbl.textColor = [UIColor  whiteColor];
    LevelLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
    LevelLbl.backgroundColor = [UIColor clearColor];
    LevelLbl.text=@"LEVELS";
    [TitleImageView addSubview:LevelLbl];
    
    UILabel* playingLbl = [[UILabel alloc] init];
    playingLbl.frame = CGRectMake(220,0,100 , TitleImage.size.height);
    playingLbl.textAlignment = NSTextAlignmentRight;
    playingLbl.textColor = [UIColor  whiteColor];
    playingLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
    playingLbl.backgroundColor = [UIColor clearColor];
    playingLbl.text=@"PLAYING NOW";
    [TitleImageView addSubview:playingLbl];
    
    levelsTableView = [[UITableView alloc] initWithFrame:CGRectMake(55, 70,TitleImage.size.width,150)];    levelsTableView.dataSource = self;
    levelsTableView.delegate = self;
    levelsTableView.backgroundColor = [UIColor blackColor];
    levelsTableView.separatorColor = [UIColor whiteColor];
    levelsTableView.layer.borderWidth = 1;
    levelsTableView.layer.borderColor = [[UIColor whiteColor] CGColor];
    levelsTableView.scrollEnabled = NO;
    if(isios7())
    {
        [levelsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    levelsTableView.hidden=YES;
    [customiseAlertView addSubview:levelsTableView];
    
    /***
     * Close Button
     **/
    
    UIButton  *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(402,10, 30, 30);//135
    closeButton.backgroundColor=[UIColor clearColor];
    [customiseAlertView addSubview:closeButton];
    
    [bgView addSubview:customiseAlertView];

    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    animation.fillMode = kCAFillModeRemoved;
    animation.removedOnCompletion = NO;
    animation.duration = 0.5;
    [bgView.layer addAnimation:animation forKey:@"show"];
}
-(void)jsonDataPlayerInfoResponse:(id)responseDict
{
    //NSLog(@"responseDict....%@",responseDict);
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
        detailsArray=[[NSMutableArray alloc]init];
        [detailsArray addObject:[responseDict valueForKey:@"data"]];
        levelsTableView.hidden=NO;
        [levelsTableView reloadData];
    }
}
-(void)closeButtonPressed
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    CATransform3D scale2 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.0, 0.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.2;
    [bgView.layer addAnimation:animation forKey:@"hide"];
    
    [self performSelector:@selector(removeFromSuperview:) withObject:bgView afterDelay:0.105];
}
-(void)removeFromSuperview:(UIView*)bg_View
{
    [bg_View removeFromSuperview];
    [view_Background removeFromSuperview];
}

#pragma mark ------------------------------TableViewDelegate and UITableViewDatasource methods--------------------------------------

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return levelsArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ListCellIdentifier";
    UITableViewCell *cell = [levelsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        /***
         *Customize Table Cell Label
         */
        cell.textLabel.font=[UIFont fontWithName:@"ArialMT" size:14.0];
        cell.textLabel.textColor=[UIColor whiteColor];
        
    }
    else{
        
        NSArray *cellSubs = cell.contentView.subviews;
        for (int i = 0 ; i < [cellSubs count] ; i++)
        {
            [[cellSubs objectAtIndex:i] removeFromSuperview];
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text =[NSString stringWithFormat:@"%@",[levelsArray objectAtIndex:indexPath.row]];
    cell.contentView.backgroundColor = [UIColor blackColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(230,0, 80, 25)];
    if(indexPath.row==0)
    countLabel.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"EARTH"]objectAtIndex:0]];
    else if (indexPath.row==1)
    countLabel.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"LUNA"]objectAtIndex:0]];
    else if (indexPath.row==2)
        countLabel.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"MARS"]objectAtIndex:0]];
    else if (indexPath.row==3)
        countLabel.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"CERES"]objectAtIndex:0]];
    else if (indexPath.row==4)
        countLabel.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"IOA"]objectAtIndex:0]];
    else if (indexPath.row==5)
        countLabel.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"TITAN"]objectAtIndex:0]];
    else
    countLabel.text=@"0";
    
    countLabel.textAlignment =NSTextAlignmentCenter ;
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textColor =  [UIColor whiteColor];
    [cell.contentView addSubview:countLabel];
    
    return cell;
    
}


@end
