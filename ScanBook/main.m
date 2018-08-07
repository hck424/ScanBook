//
//  main.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 3..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanBookAppDelegate.h"
void uncaughtException(NSException *exception) {
    NSLog(@"exception : %@", [exception callStackSymbols]);
}
int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSSetUncaughtExceptionHandler(uncaughtException);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([ScanBookAppDelegate class]));
    }
}
