//
//  ViewController.m
//  ShareDemo
//
//  Created by Naitong Yu on 15/7/31.
//  Copyright (c) 2015年 Naitong Yu. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "ShareImageViewController.h"

static const NSString *baseString = @"http://107room.com/app/house/";

@interface ViewController ()

@property (nonatomic) NSArray *datas;

@end

@implementation ViewController

- (IBAction)shareButtonTapped:(UIButton *)sender {
    
    NSString *title = sender.titleLabel.text;
    int index = [title intValue];
    
    ShareImageViewController *shareImageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareImageViewController"];
    shareImageViewController.data = self.datas[index-1];
    [self showViewController:shareImageViewController sender:sender];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *datas = [self jsonData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:true];
            self.datas = datas;
        });
    });
}

- (NSArray *)jsonData
{
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *extendStrings = @[@"r17876", @"r17841", @"r19008", @"h9211"];
    for (NSString *extendString in extendStrings) {
        NSString *urlString = [baseString stringByAppendingString:extendString];
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *rawData = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
        [datas addObject:data];
    }
    return datas;
}

@end
