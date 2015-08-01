//
//  ShareImageViewController.m
//  ShareDemo
//
//  Created by Naitong Yu on 15/7/31.
//  Copyright (c) 2015年 Naitong Yu. All rights reserved.
//

#import "ShareImageViewController.h"
#import "FXBlurView.h"
#import "UIImage+Crop.h"

@interface ShareImageViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ShareImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.data) {
        UIImage *image = [self imageFromData:self.data];
        self.scrollView.contentSize = image.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.scrollView addSubview:imageView];
    }
    
}

- (UIImage *)imageFromData:(NSDictionary *)data
{
    NSDictionary *suite = data[@"suite"];
    NSDictionary *house = suite[@"house"];
    NSDictionary *landlord = suite[@"landlord"];
    NSArray *rooms = suite[@"rooms"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGSize imageSize = CGSizeMake(CGRectGetWidth(screenBounds), 1000);
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString *backgroundImageString = rooms[0][@"imageIds"][0][@"url"];
    NSData *backgroundImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:backgroundImageString]];
    UIImage *backgroundImage = [UIImage imageWithData:backgroundImageData];
    backgroundImage = [backgroundImage blurredImageWithRadius:15.0f iterations:1 tintColor:[UIColor clearColor]];
    [backgroundImage drawInRect:CGRectMake(0, 0, CGRectGetWidth(screenBounds), 1000)];
    
    CGContextSaveGState(context);
    NSString *faviconString = landlord[@"faviconUrl"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:faviconString]];
    UIImage *favicon = [UIImage imageWithData:imageData];
    favicon = [favicon squareImage];
    CGRect faviconRect = CGRectMake(50, 50, 100, 100);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:faviconRect];
    [circle addClip];
    [favicon drawInRect:faviconRect];
    CGContextRestoreGState(context);
    circle.lineWidth = 3;
    [[UIColor whiteColor] setStroke];
    [circle stroke];
    
    CGFloat margin = 10;
    CGRect maskRect = CGRectMake(margin, 200, CGRectGetWidth(screenBounds)-2*margin, 200);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:maskRect];
    UIColor *fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [fillColor setFill];
    [maskPath fill];
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
