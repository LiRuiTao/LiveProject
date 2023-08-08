//
//  ViewController.m
//  GXInteractionLive
//
//  Created by liruitao on 2023/7/19.
//

#import "ViewController.h"
#import "GXLiveManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 300, 101, 101);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(openLiveListVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
    [GXLiveManager initLiveSDK:@"1" onCompleted:^(BOOL success) {}];

}
- (void)openLiveListVC {
    [GXLiveManager entryLiveWithUserId:@"1" liveId:@"c1697ca5-bfca-4df3-be21-c0c3c7166c54"];
}

@end
