//
//  AppDelegate.h
//  FaceTimeConnectionMonitor
//
//  Created by Yiming Liu on 5/5/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LogMonitor.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,NSUserNotificationCenterDelegate>

@property (nonatomic, strong, readonly) LogMonitor* monitor;

@end

