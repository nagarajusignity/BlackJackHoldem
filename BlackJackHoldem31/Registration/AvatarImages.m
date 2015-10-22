//
//  AvatarImages.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "AvatarImages.h"
#import "AppDelegate.h"
#import "WebServiceInterface.h"
#import "UIImageView+WebCache.h"

@implementation AvatarImages
static  AvatarImages * sharedMyManager = nil;
@synthesize callBack;
@synthesize imageName;
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
-(void)ShowViewWithImages:(UIView*)view

{
   // imagesArray =[[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"First.jpg"],[UIImage imageNamed:@"Second.jpg"],[UIImage imageNamed:@"Third.jpg"],[UIImage imageNamed:@"Fourth.jpg"],[UIImage imageNamed:@"Fifth.jpg"],[UIImage imageNamed:@"Sixth.jpg"],[UIImage imageNamed:@"Seventh.jpg"],[UIImage imageNamed:@"Eighth.jpg"], nil];
    imagesArray =[[NSMutableArray alloc]init];
    
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:view withTitle:@"Loading"];
    objAPI.showActivityIndicator = YES;
    NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=avtar_images"];
    [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataImagesResponse:)];
    objAPI = nil;
    
    
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
    alert_width = 442+70*isiPhone5();
    alert_height = 304;//270
    
    customiseAlertView.frame = CGRectMake(((bgView.frame.size.width-alert_width)/2.0), ((bgView.frame.size.height-alert_height)/2.0), alert_width, alert_height);
    customiseAlertView.backgroundColor = [UIColor clearColor];
    customiseAlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customiseAlertView.layer.masksToBounds = NO;
    //[customiseAlertView addSubview:mainbgView];
    
    /***
     * Background Image
     **/
    
    UIImage *backgroundImage =[UIImage imageNamed:@"pop-back.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithImage:backgroundImage];
    backgroundImageView.frame=CGRectMake(0,0,alert_width , alert_height);
    [customiseAlertView addSubview:backgroundImageView];
    
    
    UIImage *avatarImage =[UIImage imageNamed:@"Avatar"];
    UIImageView *avatarImageImageView=[[UIImageView alloc]initWithImage:backgroundImage];
    avatarImageImageView.frame=CGRectMake(alert_width/3+20+10*isiPhone5(),25,110 , 18);
    avatarImageImageView.image=avatarImage;
    [customiseAlertView addSubview:avatarImageImageView];
    
    /***
     * male Button
     **/
    
    UIButton *maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maleButton addTarget:self
                       action:@selector(maleButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    maleButton.backgroundColor =[UIColor clearColor];
    [maleButton setBackgroundImage:[UIImage imageNamed:@"male"] forState:UIControlStateNormal];
    maleButton.frame = CGRectMake(360+35*isiPhone5(), 17, 30, 30);
    [customiseAlertView addSubview:maleButton];
    
    /***
     * Female Button
     **/
    
    UIButton *femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [femaleButton addTarget:self
                   action:@selector(femaleButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    femaleButton.backgroundColor =[UIColor clearColor];
    [femaleButton setBackgroundImage:[UIImage imageNamed:@"female"] forState:UIControlStateNormal];
    femaleButton.frame = CGRectMake(50+35*isiPhone5(), 17, 30, 30);
    [customiseAlertView addSubview:femaleButton];
    
    
    pageControl = [[DDPageControl alloc] init] ;
    [pageControl setCenter: CGPointMake(customiseAlertView.frame.size.width/2, 260)] ;
    [pageControl setNumberOfPages: 10] ;
    [pageControl setCurrentPage: 0] ;
    [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
    
    [pageControl setDefersCurrentPageDisplay: NO] ;
    [pageControl setType: DDPageControlTypeOnFullOffFull] ;
    [pageControl setOnColor: [UIColor redColor]] ;
    [pageControl setOffColor: [UIColor  colorWithRed:19.0/255.0f green:81.0/255.0f blue:97.0/255.0f alpha:1.0f]];
    [pageControl setIndicatorDiameter: 8.0f] ;
    [pageControl setIndicatorSpace: 6.0f] ;
    [customiseAlertView addSubview: pageControl] ;
    
    /***
     * Previous Button
     **/
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousButton addTarget:self
                     action:@selector(previousButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    previousButton.backgroundColor =[UIColor clearColor];
    [previousButton setBackgroundImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
    previousButton.frame = CGRectMake(40+30*isiPhone5(), 250, 53, 22);
    [customiseAlertView addSubview:previousButton];
    
    /***
     * Next Button
     **/
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton addTarget:self
                       action:@selector(nextButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    nextButton.backgroundColor =[UIColor clearColor];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    nextButton.frame = CGRectMake(350+35*isiPhone5(), 250, 53, 22);
    [customiseAlertView addSubview:nextButton];
    
    /***
     * Close Button
     **/
    
    UIButton  *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateNormal];
    //[CancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(402+70*isiPhone5(),10, 30, 30);//135
    closeButton.backgroundColor=[UIColor clearColor];
    [customiseAlertView addSubview:closeButton];
    
   
    
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
-(void)jsonDataImagesResponse:(id)responseDict
{
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    
    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
        imagesArray=[[NSMutableArray alloc]init];
        [imagesArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50+35*isiPhone5(), 60,340, 170) collectionViewLayout:layout];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        //layout.minimumInteritemSpacing =0.1;
        //layout.sectionInset = UIEdgeInsetsMake(5,5, 0, 0);;
        layout.minimumLineSpacing = 0;
         _collectionView.pagingEnabled = YES;
        _collectionView.layer.borderWidth=1;
        _collectionView.layer.borderColor=[[UIColor whiteColor] CGColor];
        [_collectionView setCollectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [_collectionView setBackgroundColor:[UIColor  clearColor]];
        [customiseAlertView addSubview:_collectionView];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        [bgView addSubview:customiseAlertView];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Unable to fetch Images." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self closeButtonPressed]; 
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imagesArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0,0,85,80)];
    viewbg.backgroundColor = [UIColor  clearColor];
    [cell.contentView addSubview:viewbg];
    
    UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(5,5, 70,70)];
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrl,[[imagesArray valueForKey:@"image_name"] objectAtIndex:indexPath.row]]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
    //imageView.image=[imagesArray objectAtIndex:indexPath.row];
    imageView.backgroundColor=[UIColor clearColor];
    imageView.layer.cornerRadius =  5.0;
    imageView.layer.masksToBounds = YES;
    [viewbg addSubview:imageView];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(85 ,80);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    imageName=[NSString stringWithFormat:@"%@",[[imagesArray valueForKey:@"image_name"] objectAtIndex:indexPath.row]];
    [self closeButtonPressed];
    callBack(imageName);
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _collectionView.frame.size.width;
    pageControl.currentPage = _collectionView.contentOffset.x / pageWidth;
}
#pragma mark -
#pragma mark DDPageControl triggered actions

- (void)pageControlClicked:(id)sender
{
    
    DDPageControl *thePageControl = (DDPageControl *)sender ;
    
    [_collectionView setContentOffset: CGPointMake(_collectionView.bounds.size.width * thePageControl.currentPage, _collectionView.contentOffset.y) animated: YES] ;
}
-(void)previousButtonPressed
{
    
    pageControl.currentPage=pageControl.currentPage-1;
    [_collectionView setContentOffset: CGPointMake(_collectionView.bounds.size.width * pageControl.currentPage, _collectionView.contentOffset.y) animated: YES] ;
}
-(void)nextButtonPressed
{
    pageControl.currentPage=pageControl.currentPage+1;
    [_collectionView setContentOffset: CGPointMake(_collectionView.bounds.size.width * pageControl.currentPage, _collectionView.contentOffset.y) animated: YES] ;
}
-(void)maleButtonPressed
{
    pageControl.currentPage=0;
    [_collectionView setContentOffset: CGPointMake(_collectionView.bounds.size.width * pageControl.currentPage, _collectionView.contentOffset.y) animated: YES] ;
}
-(void)femaleButtonPressed
{
    pageControl.currentPage=6;
    [_collectionView setContentOffset: CGPointMake(_collectionView.bounds.size.width * pageControl.currentPage, _collectionView.contentOffset.y) animated: YES] ;
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



@end
