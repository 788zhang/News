//
//  UINetWorkEngine.h
//  UINetWebRequired
//
//  Created by scjy on 15/12/23.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>



//3.创建一个网络请求类型的枚举
typedef enum {
    
    NetWorkEngineTypeGET,   //get网络请求
    NetWorkEngineTypePOST,  //post网络请求
    NetWorkEngineTypePUT,   //PUT网络请求
    NetWorkEngineTypeDELETE //DELETE网络请求
    
}NetWorkEngineType;




//告诉程序有这个类，只需要代理程序有UINetWorkEngine这个类，而不需要编译里面的内容
@class UINetWorkEngine;
//1.创建网络请求代理
@protocol NetWorkEngineDelegate <NSObject>
//
@required
//网络请求开始

- (void)netWorkDidStartLoading:(UINetWorkEngine *)netWorkEngine;


//网络请求结束

- (void)netWorkDidFinishLoading:(UINetWorkEngine *)netWorkEngine withResponseObject:(id)responseObject;

@end


@interface UINetWorkEngine : NSObject

//2。创建类方法，传入网络请求的必要数据
//第一个参数：urlString  网络请求的网址
//第二个参数：parameters:post类型的网络请求需要传入的参数列表(字典)
//第三个参数： 遵循网络请求协议的类（代理对象）
//第四个参数： 网络请求类型

+ (instancetype)netWorkEngineWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters requestDelegate:(id<NetWorkEngineDelegate>)delegate
    httpMethodType:(NetWorkEngineType)netWorkType;

//4.开始网络请求

- (void)startRequestNetWork;






@end
