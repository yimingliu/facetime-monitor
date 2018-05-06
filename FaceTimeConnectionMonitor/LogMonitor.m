//
//  LogMonitor.m
//  FaceTimeConnectionMonitor
//
//  Created by Yiming Liu on 5/5/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import "LogMonitor.h"


#define DEBUG_PREDICATE_SUBSYSTEM @"com.apple.WebInspector"
#define DEBUG_PREDICATE_MESSAGE_FILTER @"RWIServiceDeviceConnection"

@implementation LogMonitor

- (id)initWithSubsystemAndMessageFilter:(NSString*)subsystem messageFilter:(NSString *)messageFilter
{
    self = [super init];
    if (self != nil) {
        _subsystem = subsystem;
        _messageFilter = messageFilter;
    }
    return self;
}

- (NSTask*)createNewLogReader:(NSString*)subsystem keyPath:(NSString *)messageFilter
{
    NSTask* reader_task;
    reader_task = [[NSTask alloc] init];
    reader_task.standardOutput = [NSPipe pipe];
    reader_task.launchPath = @"/usr/bin/log";
    reader_task.arguments = @[@"stream", @"--predicate", [NSString stringWithFormat:@"(subsystem == \"%@\") && (eventMessage contains \"%@\")", subsystem, messageFilter]];
    
    [reader_task setTerminationHandler:^(NSTask *task) {
        // subprocess exited. handle cleanup
        [task.standardOutput fileHandleForReading].readabilityHandler = nil;
        NSLog(@"Task terminated");
    }];
    
    [reader_task.standardOutput fileHandleForReading].readabilityHandler = ^(NSFileHandle *file) {
        // read all available bytes
        [self parseLogData:file];
        
        // [buffer appendData:data];
    };
    return reader_task;
}

- (void)parseLogData:(NSFileHandle*)file
{
    NSData *data = [file availableData];
    NSString *log_output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *log_lines = [log_output componentsSeparatedByString:@"\n"];
    for (NSString* line in log_lines)
    {
        if ([line containsString:self.messageFilter])
        {
            NSLog(@"Output: %@", line);
            if (self.num_occurrences == NOTIFY_THRESHOLD)
            {
                // notify
                NSLog(@"FIRING NOTIFICATION");
                [self sendUserNotification];
            }
            _num_occurrences += 1;
            NSLog(@"Lines matched: %ld", (unsigned long)self.num_occurrences);
        }
        
    }
}

-(void)sendUserNotification
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Poor Facetime Connection!";
    notification.informativeText = [NSString stringWithFormat:@"Your FaceTime partner is seeing \"poor connection\" from you.  Restart your call to fix."];
    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

-(void)start
{
    _logreader = [self createNewLogReader:self.subsystem keyPath:self.messageFilter];
    [_logreader launch];
//    [_logreader waitUntilExit];
}

-(void)stop
{
    [_logreader interrupt];
//    [_logreader waitUntilExit];
    NSLog(@"Termination status: %d", [_logreader terminationStatus]);
    NSLog(@"Goodbye, beautiful world!");
    _logreader = NULL;
}

@end
