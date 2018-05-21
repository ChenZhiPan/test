//
//  ViewController.m
//  DownLownDemo
//
//  Created by ZhiPan Chen on 2018/5/12.
//  Copyright © 2018年 ZhiPan Chen. All rights reserved.
//

//较大文件下载  FileHandle

#import "ViewController.h"
#import "OutputStreamVC.h"

#define FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"minion_15.mp4"]


@interface ViewController ()<NSURLConnectionDataDelegate>

//下载进度条
@property (nonatomic, strong) UIProgressView *progressView;

//下载总长度
@property (nonatomic, assign) NSInteger contentLength;

//下载当前长度
@property (nonatomic, assign) NSInteger currentLength;

//文件柄路对象
@property (nonatomic, strong) NSFileHandle *handle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    
//    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(50, 100, 200, 30)];
//    [self.view addSubview:_progressView];
//    
//    
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
//    
//    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 180, 30)];
    [btn setTitle:@"OutputStream_DownLow" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


#pragma mark - <NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response{
    self.contentLength = [response.allHeaderFields[@"Content-Length"] integerValue];
    
    //创建一个空的文件夹
    [[NSFileManager defaultManager]createFileAtPath:FILE_PATH contents:nil attributes:nil];
    
    //创建一个文件柄路对象
    self.handle = [NSFileHandle fileHandleForWritingAtPath:FILE_PATH];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    //指定数据写入位置 -- 文件的最后面
    [self.handle seekToEndOfFile];
    
    //写入数据
    [self.handle writeData:data];
    
    self.currentLength += data.length;
    
    float flag = 1.0 * self.currentLength / self.contentLength;
    NSLog(@"%.2f",flag);
    self.progressView.progress =  flag;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"---- 下载完毕 ---- %@", FILE_PATH);
    //关闭文件句柄
    [self.handle closeFile];
    self.handle = nil;
}


-(void)btnClick{
    OutputStreamVC *vc = [[OutputStreamVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
