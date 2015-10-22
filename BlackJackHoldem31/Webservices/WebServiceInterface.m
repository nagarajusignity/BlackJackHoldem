//
//  WebServiceInterface.m
//  virtual
//
//  Created by Apple on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebServiceInterface.h"
#import "SBJSON.h"
#import "Reachability.h"
#import "NSNetwork.h"
#import "AppDelegate.h"

@implementation WebServiceInterface

@synthesize dataResponse;
@synthesize m_connection;
@synthesize showActivityIndicator;
@synthesize imageData;


static WebServiceInterface* sharedMyManager = nil;
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


-(void)setTarget:(id)callBackTarget withSelector:(SEL)callBackSelector
{
    m_callBackTarget = callBackTarget;
	m_callBackSelector = callBackSelector;
}

#pragma mark store
-(void)fetchDataForURL:(NSString*)connectionURL withData:(NSString*)strData withTarget:(id)callBackTarget withSelector:(SEL)callBackSelector
{
    [self closeFunction];
    appDelegate().window.userInteractionEnabled = NO;
    m_callBackTarget = callBackTarget;
	m_callBackSelector = callBackSelector;
    
	NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:connectionURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
    
    NSMutableData *data = [NSMutableData data];
    if (imageData.length) {
        NSString *boundary=@"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [theRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            NSString *filename =appDelegate().fileName;
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadfile\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[NSData dataWithData:imageData]];
        NSArray *postData = [strData componentsSeparatedByString:@"&"];
        NSLog(@"postData %@",postData);
        for (int i = 0; i < [postData count]; i++)
        {
            NSString *tempString = [postData objectAtIndex:i];
            NSArray *tempArray = [tempString componentsSeparatedByString:@"="];
            if (tempArray.count >0) {
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",tempArray[0]] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"%@",tempArray[1]] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    
    else
    [data appendData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
	[theRequest setHTTPBody:data];
	[theRequest setHTTPMethod:@"POST"];
	if(m_connection)
	{
		[m_connection release];
		 m_connection = nil;
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	reach = [Reachability reachabilityWithHostName:@"www.google.co.in"];
	
	if (reach != nil)
	{
		NetworkStatus internetStatus = [reach currentReachabilityStatus];
		
		if (( internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
		{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self hideProgressView:Alert_UesrLocation];
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"NetWorkStatus" message:@"Internet Connection Required." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            appDelegate().window.userInteractionEnabled = YES;
            [self closeFunction];
        
            return;
		}
     	m_connection = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    }
}

-(void)closeFunction
{
    if(m_connection)
	{
        [m_connection cancel];
		[m_connection release];
        m_connection = nil;
	}
}
-(void)dealloc
{
    [dataResponse release];
    [m_connection release];
    [super dealloc];
}
#pragma mark -
#pragma mark Connection Delegate Methods


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	if(dataResponse)
	{
		[dataResponse release];
		dataResponse = nil;
	}
	dataResponse = [[NSMutableData alloc]init];
	[dataResponse setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[dataResponse appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    appDelegate().window.userInteractionEnabled = YES;

	[m_connection release];
	m_connection = nil;
	NSLog(@"Connection failed: %@", [error description]);
    [self hideProgressView:Alert_UesrLocation];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server not responding." delegate:nil
                                       cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
     appDelegate().window.userInteractionEnabled = YES;
    [(UIViewController*)m_callBackTarget view].userInteractionEnabled = YES;
    if(Alert_UesrLocation !=nil)
	{
		[Alert_UesrLocation dismissWithClickedButtonIndex:0 animated:YES];
		Alert_UesrLocation = nil;
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    appDelegate().window.userInteractionEnabled = YES;
	[m_connection release];
	m_connection = nil;
	
	NSString *responseString = [[NSString alloc] initWithData:dataResponse encoding:NSUTF8StringEncoding];
	[dataResponse release];
	dataResponse = nil;
	
	SBJSON *json = [SBJSON new];
	id response = [json objectWithString:responseString error:nil];
	
	[json release];
	json = nil;
	[responseString release];
	responseString = nil;
   
    @try
    {
        [m_callBackTarget performSelector:m_callBackSelector withObject:response];
    }
    @catch (NSException *exception) {
    }
   
}

#pragma mark Loader added

- (UIAlertView *)createProgressViewToParentView:(UIView *)view withTitle:(NSString *)title
{
	Alert_UesrLocation = [[UIAlertView alloc] initWithTitle:@"" message:title delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[Alert_UesrLocation show];
	
	return Alert_UesrLocation;
	
}
- (void)hideProgressView:(UIAlertView *)inProgressView{
	if(Alert_UesrLocation !=nil){
		[Alert_UesrLocation dismissWithClickedButtonIndex:0 animated:YES];
		Alert_UesrLocation = nil;
	}
}



@end
