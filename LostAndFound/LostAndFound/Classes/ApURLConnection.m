//
//  ApURLConnection.m
//  ApostekApp
//
//  Created by R on 06/10/09.
//  Copyright 2009 __Apostek__. All rights reserved.
//

#import "ApURLConnection.h"
#import "ApUtils.h"
#import "AdSupport/ASIdentifierManager.h"

//#import "JSON.h"

@implementation ApURLConnection
@synthesize userInfo,  extraInt;

-(id)initWithURL:(NSString *)url withDelegate:(id)aDelegate withOnlyCheck:(BOOL) onlyCheck withData:(NSString *)data  {
    
    if((self = [super init]) )
    {
        
        //NSLog(@"connection load received");
        delegate = aDelegate;
        justChecking = onlyCheck;
        
        //keep this the last step
        NSMutableURLRequest *mutR = [[NSMutableURLRequest alloc] init];
        [mutR setURL  :[NSURL URLWithString:url]];
        
        if(data)
        {
            [mutR setHTTPMethod:@"POST"];
            [mutR setHTTPBody:[data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        }
        
        urlConnection = [[NSURLConnection alloc] initWithRequest:mutR delegate:self];
        
        mutR = nil;
        if(!urlConnection)
        {
            goto error;
        }
        
        receivedData = [[NSMutableData alloc]initWithData:[NSMutableData data]];
        return self;
    }
error:
    self = nil;
    return nil;
    
}

-(id)initWithURL:(NSString *)url withDelegate:(id)aDelegate withOnlyCheck:(BOOL) onlyCheck {
    
    return [self initWithURL:url withDelegate:aDelegate withOnlyCheck:onlyCheck withData:nil];
}


-(id)initWithURL:(NSString *)url withDelegate:(id)aDelegate{
    
    return [self initWithURL:url withDelegate:aDelegate withOnlyCheck:FALSE];
}

-(void)stopLoading
{
    delegate  = nil;
    if(urlConnection)
    {
        [urlConnection cancel];
        urlConnection = nil;
    }
    if(receivedData)
    {
        receivedData = nil;
    }
}

-(void)endIfJustChecking:(BOOL)success
{
    if(justChecking && success)
    {
        if(urlConnection)
            [urlConnection cancel];
        [self connectionDidFinishLoading:urlConnection];
        
    }
    else if(justChecking && !success)
    {
        if(urlConnection)
            [urlConnection cancel];
        [self connection:urlConnection didFailWithError:nil];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //   NSLog(@"Response received from %@, [response statusCode] :%d",response.URL,[response statusCode]);
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
    
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    
    [receivedData setLength:0];
    //NSLog(@"[response statusCode] :%d",[response statusCode]);
    if( ! ([httpResponse statusCode] >=200 && [httpResponse statusCode] < 400))
    {
        [self endIfJustChecking:FALSE];
    }
    else
    {
        [self endIfJustChecking:TRUE];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{//NSLog(@"Resonponse failed");
    // release the connection, and the data object
    //	NSLog(@"%s",__FUNCTION__);
    
    connection = nil;
    // receivedData is declared as a method instance elsewhere
    receivedData = nil;
    urlConnection = nil;
    if([delegate respondsToSelector:@selector(connectionFailed:)])
        [delegate connectionFailed:self];
    
}

// Rahul Agarwal 18th May,2012..adding try catch
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    @try {
        if(receivedData == nil || [receivedData length]== 0)
            return;
        NSString *data = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        if([delegate respondsToSelector:@selector(connectionSuccessful:withString:withData:)])
        {
            [delegate connectionSuccessful:self withString:data withData:receivedData ];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"ApURLConnection:connectionDidFinishLoading  Reason:%@:%@", [exception name], [exception reason]);
    }
    @finally {
        
        // release the connection, and the data object
        //[connection release];
        //		[receivedData release];
        //		receivedData = nil;
        //
        //		if(urlConnection)
        //		{
        //			[urlConnection cancel];
        //			[urlConnection release];
        //			urlConnection = nil;
        //		}
        //		//urlConnection = nil;
    }
    
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    
    int port =  [[ [request URL] port ]intValue];
    if(port == 0 )
        port = 80;
    NSMutableURLRequest *newR = nil;
    if([[request URL] query])
    {
        newR =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d%@?%@",  [ [request URL] host ], port ,[[request URL] path ],[[request URL] query] ]]];
    }
    else
    {
        newR =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d%@", [ [request URL] host ],port,[[request URL] path ]]]];
    }
    
    //Deepesh 25 Apr 2013 - Removed UDID and passing Advertiser ID and Status of Advertiser Tracking instead for iOS compliance
    [newR setValue: [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] forHTTPHeaderField:@"ap-aid"];
    [newR setValue: [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ? @"1":@"0" forHTTPHeaderField:@"ap-ate"];
    
    [newR setValue: @"iphone"  forHTTPHeaderField:@"ap-platform"];
    [newR setValue: @"LOST_AND_FOUND"  forHTTPHeaderField:@"ap-appid"];
    [newR setValue: [ApUtils getAppVerAsString]  forHTTPHeaderField:@"ap-version"];
    
    //Manpreet 23 Apr 2012 - added to make header request equivalent to beacon 
    [newR setValue: [ApUtils getOdin]  forHTTPHeaderField:@"ap-odin"];    
    
    [newR  setValue:@"gzip, deflate"   forHTTPHeaderField:@"Accept-Encoding"];
    
    if([ @"POST" isEqualToString:[request HTTPMethod]  ])
    {
        [newR setHTTPMethod:@"POST"];
        [newR setHTTPBody:[request HTTPBody]];
    }
    return newR;
}

@end
