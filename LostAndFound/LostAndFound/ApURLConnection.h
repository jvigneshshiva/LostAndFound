//
//  ApURLConnection.h
//  ApostekApp
//
//  Created by R on 06/10/09.
//  Copyright 2009 __Apostek__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApUtils.h"

@class ApURLConnection;

@protocol ApURLConnectionDelegate
-(void)connectionSuccessful:(ApURLConnection *)apURLConnection withString:(NSString *)str withData:(NSData *)data;
-(void)connectionFailed:(ApURLConnection *)apURLconnection;
@end

@interface ApURLConnection : NSObject {
	id delegate;
	NSURLConnection *urlConnection;
	NSMutableData *receivedData;
	BOOL justChecking ;
	NSObject *userInfo;
	int extraInt;
}
/*
-(void)endIfJustChecking:(BOOL)success;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse;*/
-(void)stopLoading;
-(id)initWithURL:(NSString *)url withDelegate:(id)aDelegate;
-(id)initWithURL:(NSString *)url withDelegate:(id)aDelegate withOnlyCheck:(BOOL) onlyCheck  withData:(NSString *)data  ;
-(id)initWithURL:(NSString *)url withDelegate:(id)aDelegate withOnlyCheck:(BOOL) onlyCheck;
@property (nonatomic,retain) NSObject *userInfo;
@property (nonatomic,assign) int extraInt;

@end
