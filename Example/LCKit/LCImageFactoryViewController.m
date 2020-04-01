//
//  LCImageFactoryViewController.m
//  LCKit_Example
//
//  Created by lattecat on 2020/4/2.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCImageFactoryViewController.h"
#import <LCKit/LCImageFactory.h>

@interface LCImageFactoryViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *contenModePickerView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *clipWidth;
@property (weak, nonatomic) IBOutlet UITextField *clipHeight;
@property (weak, nonatomic) IBOutlet UITextField *radius;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@property (nonatomic, assign) kLCImageContentMode                    mode;

@property (nonatomic, strong) UIImage                               *srcImage;

@end

@implementation LCImageFactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.srcImage = [UIImage imageNamed:@"clip_image_long"];
}
- (IBAction)clipImage:(id)sender {
    CGFloat width = [self.clipWidth.text floatValue];
    CGFloat height = [self.clipHeight.text floatValue];
    CGFloat radius = [self.radius.text floatValue];
    if (width <= 0.0 || height <= 0.0) {
        NSAssert(NO, @"参数错误！");
    }
    
    // 直角矩形
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *clipedImage = [LCImageFactory clipImageAsRect:self.srcImage rectSize:CGSizeMake(width, height) contentModel:self.mode];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = clipedImage;
            self.infoLabel.text = [NSString stringWithFormat:@"图片大小：{%0.f, %0.f}", clipedImage.size.width, clipedImage.size.height];
        });
    });
    
//    // 圆角矩形
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        UIImage *clipedImage = [LCImageFactory clipImageAsRoundRect:self.srcImage rectSize:CGSizeMake(width, height) roundRadius:radius roundRectOptions:kLCImageClipRoundRectOptionLeft contentModel:self.mode];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = clipedImage;
//            self.infoLabel.text = [NSString stringWithFormat:@"图片大小：{%0.f, %0.f}", clipedImage.size.width, clipedImage.size.height];
//        });
//    });
    
//    // 圆
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        UIImage *clipedImage = [LCImageFactory clipImageAsOval:self.srcImage ovalSize:CGSizeMake(width, height) contentModel:self.mode];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = clipedImage;
//            self.infoLabel.text = [NSString stringWithFormat:@"图片大小：{%0.f, %0.f}", clipedImage.size.width, clipedImage.size.height];
//        });
//    });
}


//***********************************************************************************************************************************************************
// MARK:-                                                           UIPickerViewDataSource
//***********************************************************************************************************************************************************
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 12;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (row) {
        case 0: {
            return @"kLCImageContentModeScaleToFill";
        }
        case 1: {
            return @"kLCImageContentModeAspectFit";
        }
        case 2: {
            return @"kLCImageContentModeAspectFill";
        }
        case 3: {
            return @"kLCImageContentModeCenter";
        }
        case 4: {
            return @"kLCImageContentModeTop";
        }
        case 5: {
            return @"kLCImageContentModeBottom";
        }
        case 6: {
            return @"kLCImageContentModeLeft";
        }
        case 7: {
            return @"kLCImageContentModeRight";
        }
        case 8: {
            return @"kLCImageContentModeTopLeft";
        }
        case 9: {
            return @"kLCImageContentModeTopRight";
        }
        case 10: {
            return @"kLCImageContentModeBottomLeft";
        }
        case 11: {
            return @"kLCImageContentModeBottomRight";
        }
        default: {
            return @"";
        }
    };
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.mode = row;
}

@end
