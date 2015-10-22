//
//  WebServiceInterface.h
//  virtual
//
//  Created by Apple on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndicatorView.h"
@class Reachability;
@interface WebServiceInterface : NSObject
{
    NSMutableData *dataResponse;
	NSURLConnection *m_connection;
	
	id m_callBackTarget;
	SEL m_callBackSelector;
     Reachability *reach;
    
    UIAlertView *av;
    IndicatorView *activityIndicatorView;
    BOOL showActivityIndicator;
    UIAlertView *Alert_UesrLocation;
}
@property(nonatomic,retain)NSMutableData *dataResponse;
@property(nonatomic,retain)NSURLConnection *m_connection;
@property(nonatomic)BOOL showActivityIndicator;
@property(nonatomic,retain)NSData *imageData;
@property(nonatomic,retain)IndicatorView *activityIndicatorView;

-(void)fetchDataForURL:(NSString*)connectionURL withData:(NSString*)strData withTarget:(id)callBackTarget withSelector:(SEL)callBackSelector;
-(void)setTarget:(id)callBackTarget withSelector:(SEL)callBackSelector;
-(void)LoadingView;
-(void)removeLoadingView;
- (UIAlertView *)createProgressViewToParentView:(UIView *)view withTitle:(NSString *)title;

- (void)hideProgressView:(UIAlertView *)inProgressView;
+ (id)sharedManager;
-(void)closeFunction;
@end
