//
//  ViewController.m
//  ColorWithString
//
//  Created by xy on 2016/12/9.
//  Copyright © 2016年 xy. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (IBAction)ButtonEvents:(NSButton *)sender
{
    NSString *content = _txtHexStr.stringValue;
    if (content.length <= 0) {
        NSError *error = [NSError errorWithDomain:@"温馨提示" code:0 userInfo:@{NSLocalizedDescriptionKey:@"the content is nil"}];
        NSLog(@"%@",error.localizedDescription);
        NSAlert *alert = [NSAlert alertWithError:error];
        alert.messageText = @"输入内容不能为空";
        [alert addButtonWithTitle:@"确定"];
        [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
    }else{
        NSColor *color = [NSColor clearColor];
        content = [content uppercaseString];
        content = [content stringByReplacingOccurrencesOfString:@"0X" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"#" withString:@""];
        if (sender.tag == 1) {
            color = [self.class colorWithHexString:content mode:0];
        }
        else if (sender.tag == 2) {
            color = [self.class colorWithHexString:content mode:1];
        }

        _imgBGView.layer.backgroundColor = [color CGColor];
    }
}

+ (NSColor *)colorWithHexString: (NSString *) stringToConvert mode:(int)mode
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    cString = [cString stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    cString = [cString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    // strip 0X if it appears
    if ([cString length] != 6) return [NSColor redColor];
    
    unsigned int r, g, b;
    NSString *rString = @"";
    NSString *gString = @"";
    NSString *bString = @"";
    if (mode == 0) {
        // Separate into r, g, b substrings
        NSRange range = NSMakeRange(0, 2);
        rString = [cString substringWithRange:range];
        
        range.location = 2;
        gString = [cString substringWithRange:range];
        
        range.location = 4;
        bString = [cString substringWithRange:range];
    }
    else if (mode == 1) {
        NSRange range = NSMakeRange(0, 2);
        bString = [cString substringWithRange:range];
        
        range.location = 2;
        gString = [cString substringWithRange:range];
        
        range.location = 4;
        rString = [cString substringWithRange:range];
    }
    
    // Scan values
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    CGFloat t = 255.0f;
    NSColor *color = [NSColor colorWithRed:r/t green:g/t blue:b/t alpha:1.0];
    return color;
}

//#pragma mark 根据颜色、大小生成一张图片
//+ (NSImage *)imageWithColor:(NSColor *)color size:(CGSize)size
//{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    NSGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    NSImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
