//
//  OutputStreamVC.m
//  DownLownDemo
//
//  Created by ZhiPan Chen on 2018/5/14.
//  Copyright © 2018年 ZhiPan Chen. All rights reserved.

//较大文件下载  outputStream

#import "OutputStreamVC.h"

@interface OutputStreamVC ()<NSURLConnectionDataDelegate>

//下载进度条
@property (nonatomic, strong) UIProgressView *progressView;

//下载总长度
@property (nonatomic, assign) NSInteger contentLength;

//下载当前长度
@property (nonatomic, assign) NSInteger currentLength;

//输出流对象
@property (nonatomic, strong) NSOutputStream *stream;

@end

@implementation OutputStreamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(50, 100, 200, 30)];
    [self.view addSubview:_progressView];
    
    
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"]] delegate:self];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 45 - 80, 40, 80, 30)];
    [btn setTitle:@"Down" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

#pragma mark - <NSURLConnectionDataDelegat>
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response{
    self.contentLength = [response.allHeaderFields[@"Content-Length"] integerValue];
    
//    NSLog(@"%@",response.suggestedFilename);//服务器那边的文件名
    
    //文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *fileStr = [caches stringByAppendingPathComponent:response.suggestedFilename];
    NSLog(@"%@",fileStr);
    
    //利用NSOutputStream往Path中写入数据append为每次写入是否要追加在文件尾部
    self.stream = [[NSOutputStream alloc]initToFileAtPath:fileStr append:YES];
    [self.stream open];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.stream write:[data bytes] maxLength:data.length];
    
    self.currentLength += data.length;
    
    float flag = 1.0 * self.currentLength / self.contentLength;
    NSLog(@"%.2f",flag);
    self.progressView.progress =  flag;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.stream close];
    NSLog(@"下载完成✅");
}

-(void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
