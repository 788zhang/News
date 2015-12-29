//
//  UINetWorkEngine.m
//  UINetWebRequired
//
//  Created by scjy on 15/12/23.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import "UINetWorkEngine.h"
//第五步：定义私有属性,用于保护用户传递的数据（因为网络请求需要的参数都通过初始化方法传递过来了，所有这个属性没必要公开，防止误操作修改属性）
@interface UINetWorkEngine ()
//请求网址
@property(nonatomic, copy) NSString *urlString;
//请求参数
@property(nonatomic, retain) NSDictionary *parameters;
//代理对象
@property(nonatomic, assign) id<NetWorkEngineDelegate>delegate;

//请求方式
@property(nonatomic, assign) NetWorkEngineType netWorkType;


@end

@implementation UINetWorkEngine

//第6步：完成类方法


+ (instancetype)netWorkEngineWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters requestDelegate:(id<NetWorkEngineDelegate>)delegate httpMethodType:(NetWorkEngineType)netWorkType{
    
    
    UINetWorkEngine *netWrokEngine=[[[UINetWorkEngine alloc]initWithNetWorkEngineWithUrlString:urlString parameters:parameters requestDelegate:delegate httpMethodType:netWorkType]autorelease];
    
    return netWrokEngine;
    
    
}

- (instancetype)initWithNetWorkEngineWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters requestDelegate:(id<NetWorkEngineDelegate>)delegate httpMethodType:(NetWorkEngineType)netWorkType{
    
    self=[super init];
    if (self) {
        
        self.urlString=urlString;
        self.parameters=parameters;
        self.delegate=delegate;
        self.netWorkType=netWorkType;
        
        
    }
    
    return self;
    
}



- (void)dealloc{
    
    [_urlString release], _urlString =nil;
    [_parameters release], _parameters =nil;
    [_delegate release], _delegate= nil;
    
    [super dealloc];
    
}



//7.开始网络请求方法的实现

- (void)startRequestNetWork{
    
   //1.把请求网址字符串转化成nsurl
    
    NSURL *url=[NSURL URLWithString:self.urlString];
    //2.创建一个网络请求对象,初始值为nil；
    
    NSMutableURLRequest *request=nil;
    
    //3.判断网络类型
    
    if (self.netWorkType ==NetWorkEngineTypeGET) {
        //get请求
        //添加请求网址
        request=[NSMutableURLRequest requestWithURL:url];
        //设置请求类型
        [request setHTTPMethod:@"GET"];
        
        
    }else if (self.netWorkType==NetWorkEngineTypePOST){
        //post请求
        
        request=[NSMutableURLRequest requestWithURL:url];
        //设置请求类型
        [request setHTTPMethod:@"POST"];
        //设置post请求参数
        
        if (self.parameters) {
            [request setHTTPBody:[self parametersTransformToHTTPBody]];
        }
        
        
        
    }
    
    
    
    //12.设置请求超时时间,时间请求超过10秒就返回失败
    
    [request setTimeoutInterval:10.0];
    
    
    
    
    
    //9.在网络请求开始的时候把网络请求开始方法传给代理对象
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(netWorkDidStartLoading:)]) {
        
        
        [self.delegate netWorkDidStartLoading:self];
        
    }
    
    
    
    
    
    
    
    //8.异步链接实现网络请求
    __block UINetWorkEngine *weakEngine=self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            NSLog(@"connectionError=%@",connectionError);
        }else
        
        //判断代理是否存在，切执行
        if (self.delegate && [self.delegate respondsToSelector:@selector(netWorkDidFinishLoading:withResponseObject:)]) {
            //json解析
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //把数据传给代理对象
            [self.delegate netWorkDidFinishLoading:weakEngine withResponseObject:dic];
            
        }
        
        
        
    }];
    
    
    
    }
     




//11.把用户传递的post请求参数转换为NSdata类型


-(NSData *) parametersTransformToHTTPBody{
    //self.parameters字典
     //获取字典中所有的key
    NSArray *keyArray=self.parameters.allKeys;
    
   //创建一个可变数组存放所有的键值
    NSMutableArray *keyValueArray=[NSMutableArray new];
    
    
    for (NSString *key in keyArray) {
        NSString *param=[NSString stringWithFormat:@"%@=%@",key,self.parameters[key]];
        
        [keyValueArray addObject:param];
        
    }
    
    //将数组元素之间拼接上&符号
    NSString *paramster=[keyValueArray componentsJoinedByString:@"&"];
    
    //把字符串类型转换成nsdate
    
    NSData *httpBodyDaTa=[paramster dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    return httpBodyDaTa;
    
}










@end
