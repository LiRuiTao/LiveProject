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
    [GXLiveManager initLiveSDK];

}
- (void)openLiveListVC {
    [GXLiveManager entryLiveWithUserId:@"3" userName:@"zhuyuntest2" liveId:@"da87b0a6-f38d-439a-8d5a-9f33fe8c98d7" onCompleted:^(BOOL success) {}];
}

@end
