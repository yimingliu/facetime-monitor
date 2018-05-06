//
//  LogMonitor.h
//  FaceTimeConnectionMonitor
//
//  Created by Yiming Liu on 5/5/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

# define NOTIFY_THRESHOLD 5

@interface LogMonitor : NSObject

@property (nonatomic, strong, readonly) NSTask* logreader;
@property (nonatomic, strong, readonly) NSString* subsystem;
@property (nonatomic, strong, readonly) NSString* messageFilter;
@property (assign, nonatomic, readonly) NSUInteger num_occurrences;

-(id)initWithSubsystemAndMessageFilter:(NSString*)subsystem messageFilter:(NSString *)messageFilter;
-(void)start;
-(void)stop;

@end
