//
//  SKRPBssicWebViewController.m
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKRPBssicWebViewController.h"
#import "SKBssicWebErrorView.h"
#import <WebKit/WebKit.h>
@interface SKRPBssicWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, strong) SKBssicWebErrorView *errorView;
@property (nonatomic, copy) refreshWebViewController result;
@end

@implementation SKRPBssicWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isShow = YES;
        self.isFollowChange = NO;
        self.isAutoScreen = YES;
    }
    return self;
}

+ (instancetype)webViewControl {
    return [[self alloc] init];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return nil;
}

- (void)back:(UIBarButtonItem *)btn
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self blockRefresh];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, 0, 20, 18);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self initWebView];
    
    NSString *html = !self.htmlString ? @"" : self.htmlString;
    html = [self removeSpaceAndNewline:html];
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *url = [html stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    url = [url stringByReplacingOccurrencesOfString:@"%20" withString:@""];

    if ([url hasPrefix:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }

    if ([self isLinkToURL:url])
    {
        self.requestUrl = url;
        self.navigationItem.title = self.webTitle.length ? self.webTitle : @"加载中 ...";
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
//        self.webview.scrollView.delegate = self;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                  timeoutInterval:6];
        [self.webView loadRequest:request];

//                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

//        self.errorView.hidden = YES;

    } else
    {

        if ([url hasPrefix:@"<"] && [url hasSuffix:@"/>"]) {
            self.navigationItem.title = self.webTitle.length ? self.webTitle : @"详情";
            self.requestUrl = @"";
            self.webView.navigationDelegate = self;
            [self.webView loadHTMLString:url baseURL:nil];
//            self.errorView.hidden = YES;

        } else
        {
            self.requestUrl = @"";
            self.navigationItem.title = @"网页找不到";
            self.progressView.hidden = YES;
            if (self.isShow) {
//                self.errorView.hidden = NO;
//                [self.errorView configErrorHtml:url];
            }
        }
    }
}

- (void)didRefresh:(refreshWebViewController)handler{
    self.result = handler;
}

- (void)blockRefresh{
    !self.result ?: self.result(self);
}


- (BOOL)isLinkToURL:(NSString *)url {
    NSString *reg = @"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [urlPredicate evaluateWithObject:url];
}


- (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return text;
}





- (BOOL)isUrlAddress:(NSString*)url {
    
    NSString *reg =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [urlPredicate evaluateWithObject:url];
}

- (BOOL)urlValidation:(NSString *)string {
    
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    //    for (NSTextCheckingResult *match in arrayOfAllMatches) {
    //        NSString *substringForMatch = [string substringWithRange:match.range];
    //        NSLog(@"匹配--%@",substringForMatch);
    //        return YES;
    //    }
    
    if (arrayOfAllMatches.count) {
        return YES;
    }
    return NO;
}

- (void)dealloc
{
    @try {
        if (self.webView) {
            [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
            [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"phone"];
            [self.webView removeObserver:self forKeyPath:@"title"];
        }
    } @catch (NSException *exception) { }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            self.progressView.hidden = YES;
        }
        
    } else if ([keyPath isEqualToString:@"title"])
    {
        if (self.isFollowChange) {
            self.navigationItem.title = self.webView.title;
        } else
        {
            self.navigationItem.title = self.webTitle.length ? self.webTitle : @"详情";
        }
        
    } else { }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if (self.isAutoScreen) {
        
        NSString *javascript = @"var meta = document.createElement('meta');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);";
        
        [webView evaluateJavaScript:javascript completionHandler:nil];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = YES;
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
//    self.errorView.hidden = YES;
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error - %@", error.description);
    
    self.navigationItem.title = @"网页找不到";
    self.progressView.hidden = YES;
    
    if (self.isShow) {
//        self.errorView.hidden = NO;
//        [self.errorView configErrorHtml:self.requestUrl];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    self.errorView.hidden = YES;
    self.progressView.hidden = NO;
}


//服务器返回200以外的状态码时，都调用请求失败的方法，从而可以做一些处理。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSInteger statusCode = ((NSHTTPURLResponse *)navigationResponse.response).statusCode;
    
    if (statusCode == 404 || statusCode == 403) {
        
//        self.errorView.hidden = NO;
        self.progressView.hidden = YES;
        decisionHandler(WKNavigationResponsePolicyCancel);
        
    } else
    {
//        self.errorView.hidden = YES;
        decisionHandler (WKNavigationResponsePolicyAllow);
    }
}



- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    // 获取完整url并进行UTF-8转码
    self.requestUrl = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    
    //    NSLog(@"requestUrl = %@", self.requestUrl);
    
    if ([self.requestUrl hasPrefix:@"itms-"] || [self.requestUrl hasPrefix:@"https://itunes.apple.com"])
    {
        NSURL *url = [NSURL URLWithString:self.requestUrl];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            
        } else
        {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    }
    
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

/** 初始化 WebView */
- (void)initWebView {
    
    if (self.isAutoScreen) {
        
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';} ";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        [wkUController addScriptMessageHandler:self name:@"phone"];
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        wkWebConfig.allowsInlineMediaPlayback = YES;
        if (@available(iOS 9.0, *)) {
            wkWebConfig.allowsPictureInPictureMediaPlayback = YES;
        }
        
        WKPreferences *preference = [[WKPreferences alloc]init];
        preference.minimumFontSize = 14.5;
        wkWebConfig.preferences = preference;
        self.webView = [[WKWebView alloc]initWithFrame:CGRectNull configuration:wkWebConfig];
    } else
    {
        self.webView = [[WKWebView alloc]init];
    }
    
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = YES;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}



#pragma mark - Lazy
- (UIProgressView *)progressView {
    if(_progressView == nil) {
        _progressView = [[UIProgressView alloc] init];
        //        _progressView.progressTintColor = KRGB16HEX(0xffc936);
        _progressView.trackTintColor = KRGB16HEX(0xf4f4f4);
        _progressView.progress = 0;
        _progressView.hidden = YES;
        [self.view addSubview:_progressView];
        [self.view bringSubviewToFront:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(2);
        }];
    }
    return _progressView;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"phone"]) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",message.body];
        
        NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
        
        if (compare == NSOrderedDescending || compare == NSOrderedSame) {
            
            /// 大于等于10.0系统使用此openURL方法
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            
        } else {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            
        }
    }
}

@end
