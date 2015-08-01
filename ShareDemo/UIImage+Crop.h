//
//  UIImage+Crop.h
//  ShareDemo
//
//  Created by Naitong Yu on 15/8/1.
//  Copyright (c) 2015年 Naitong Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

- (UIImage *)crop:(CGRect)rect;

- (UIImage *)squareImage;

@end
