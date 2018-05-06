//
//  AppDelegate.m
//  FaceTimeConnectionMonitor
//
//  Created by Yiming Liu on 5/5/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    //reader_task.arguments = @[@"stream", @"--predicate", @"(subsystem == \"com.apple.AVConference\") && ((eventMessage contains \"CalculateVideoTimestamp FORCE\") || (eventMessage contains \"Stream successfully stopped\"))"];

    //_monitor = [[LogMonitor alloc] initWithSubsystemAndMessageFilter:@"com.apple.WebInspector" messageFilter:@"CURRENTMACHINE"];
    _monitor = [[LogMonitor alloc] initWithSubsystemAndMessageFilter:@"com.apple.AVConference" messageFilter:@"CalculateVideoTimestamp FORCE"];
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    [_monitor start];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [_monitor stop];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}


@end
