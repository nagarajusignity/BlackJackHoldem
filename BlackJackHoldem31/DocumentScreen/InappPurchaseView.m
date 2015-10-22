//
//  InappPurchaseView.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/10/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "InappPurchaseView.h"
#import "AppDelegate.h"
#import "StoreController.h"

@interface InappPurchaseView ()

@end

@implementation InappPurchaseView
SKProductsRequest *productsRequest;
@synthesize progressView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Listen for notification from StoreController for various IAP events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processPurchaseFailure)
                                                 name:appDelegate().IAPFailedNotification
                                               object:[StoreController sharedInstance]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processPurchaseSuccess)
                                                 name:appDelegate().IAPSuccessNotification
                                               object:[StoreController sharedInstance]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processDownloadComplete)
                                                 name:appDelegate().IAPDownloadCompleteNotification
                                               object:[StoreController sharedInstance]];
    
    /***
     * Background ImageView
     **/
    
    UIImage *image;
    if(isiPhone5())
    {
        image=[UIImage imageNamed:@"apppurchasebg_iphone5"];
    }
    else
    {
        image=[UIImage imageNamed:@"apppurchasebg_iphone4"];
    }
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    [self.view addSubview:imageViewBG];
    
    /***
     * Buy Chips Button
     **/
    
    for(int i =1;i<5;i++)
    {
        
    UIButton *priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [priceButton addTarget:self
                    action:@selector(priceButtonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    priceButton.backgroundColor =[UIColor clearColor];
    [priceButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]] forState:UIControlStateNormal];
    priceButton.frame = CGRectMake(45+15*isiPhone5(), 25+i*55, 400+44*isiPhone5(), 43);
    priceButton.tag=i;
    [self.view addSubview:priceButton];
        
    }
    
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
    buttonTag=0;
}
-(void)priceButtonPressed:(UIButton*)button
{
    objAPI = [WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Purchasing..."];
    if(button.tag==1)
    {
        SKMutablePayment *payment = [[SKMutablePayment alloc] init];
        payment.productIdentifier = IAP_PRODUCT_ID_TYPEONE;
        payment.quantity = 1;
        buttonTag=1;
        NSLog(@"Buy prouct with id %@", payment.productIdentifier);
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else if (button.tag==2)
    {
        SKMutablePayment *payment = [[SKMutablePayment alloc] init];
        payment.productIdentifier = IAP_PRODUCT_ID_TYPETWO;
        payment.quantity = 1;
        buttonTag=2;
        NSLog(@"Buy prouct with id %@", payment.productIdentifier);
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else if (button.tag==3)
    {
        SKMutablePayment *payment = [[SKMutablePayment alloc] init];
        payment.productIdentifier = IAP_PRODUCT_ID_TYPETHREE;
        payment.quantity = 1;
        buttonTag=3;
        NSLog(@"Buy prouct with id %@", payment.productIdentifier);
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else if (button.tag==4)
    {
        SKMutablePayment *payment = [[SKMutablePayment alloc] init];
        payment.productIdentifier = IAP_PRODUCT_ID_TYPEFOUR;
        payment.quantity = 1;
        buttonTag=4;
        NSLog(@"Buy prouct with id %@", payment.productIdentifier);
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

-(void)backButtonPressed

{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - SKProductsRequestDelegate

// Sent immediately before -requestDidFinish:
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    //Nslog(@"Valid products returned = %@", response.products);
    //Nslog(@"Invalid products returned = %@", response.invalidProductIdentifiers);
    
}


- (void)requestDidFinish:(SKRequest *)request
{
    //Nslog(@"requestDidFinish");
    
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    //Nslog(@"error=%@", error);
}


#pragma mark - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:^
     {
         //Nslog(@"dismissModalViewControllerAnimated completed!");
     }];
}
#pragma mark - Notifications from StoreController

- (void)processPurchaseFailure
{
    objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    
    UIAlertView* alertFailed = [[UIAlertView alloc] initWithTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
                                                          message:@"Purchase failed."
                                                         delegate:nil
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil, nil];
    [alertFailed show];
}

- (void)processPurchaseSuccess
{
    
      [objAPI hideProgressView:self.progressView];
     objAPI = [WebServiceInterface sharedManager];
    NSString *price;
    if(buttonTag==1)
    {
        price =@"100000";
    }
    else if (buttonTag==2)
    {
        price=@"250000";
    }
    else if (buttonTag==3)
    {
        price=@"1000000";
    }
    else if (buttonTag==4)
    {
        price=@"5000000";
    }
    
    self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Updating credits"];
    objAPI.showActivityIndicator = YES;
    NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=add_buy_points&user_id=%@&points=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],price];
    NSLog(@"postData---> = %@",postData);
    [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonInappResponse:)];
    objAPI = nil;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==111)
    {
        objAPI = [WebServiceInterface sharedManager];
        self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Updating credits"];
        objAPI.showActivityIndicator = YES;
        NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
        
        NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=add_buy_points&user_id=%@&points=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],@"100000"];
        NSLog(@"postData---> = %@",postData);
        [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonInappResponse:)];
        objAPI = nil;
    }
}
-(void)jsonInappResponse:(id)responseDict
{
    NSLog(@"responseDict....%@",responseDict);
    buttonTag=0;
    objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
}

- (void)processDownloadComplete
{
    UIAlertView* alertDownloadComplete = [[UIAlertView alloc] initWithTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
                                                                    message:@"The hosted content downloaded is complete. Check the app's Documents folder."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
    [alertDownloadComplete show];
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
