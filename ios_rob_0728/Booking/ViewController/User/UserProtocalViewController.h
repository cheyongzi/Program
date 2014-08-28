//
//  UserProtocalViewController.h
//  Booking
//
//  Created by 1 on 14-6-30.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"

@interface UserProtocalViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    
    UIActivityIndicatorView *indicatorView;
}
@end
