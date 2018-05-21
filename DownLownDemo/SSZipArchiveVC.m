//
//  SSZipArchiveVC.m
//  DownLownDemo
//
//  Created by ZhiPan Chen on 2018/5/14.
//  Copyright © 2018年 ZhiPan Chen. All rights reserved.
//

#import "SSZipArchiveVC.h"
#import "SSZipArchive.h"

@interface SSZipArchiveVC ()

@end

@implementation SSZipArchiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *paths = @[@"/Users/zhipanchen/Desktop/image1.png",@"/Users/zhipanchen/Desktop/image2.png",@"/Users/zhipanchen/Desktop/image3.png"];
    
    //压缩文件
    [SSZipArchive createZipFileAtPath:@"/Users/zhipanchen/Desktop/imageArr.zip" withFilesAtPaths:paths];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
