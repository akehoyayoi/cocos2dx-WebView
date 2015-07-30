//
// Created by gin0606 on 2014/07/30.
//

#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS

#include "WebViewImpl_iOS.h"
#import "UIWebViewWrapper.h"
#include "WebView.h"
#include "CCDirector.h"
#include "CCEGLView.h"
#include "platform/CCFileUtils.h"

#import "EAGLView.h"

namespace cocos2d {
namespace plugin {

WebViewImpl::WebViewImpl(WebView *webView)
        : _uiWebViewWrapper([UIWebViewWrapper webViewWrapper]), _webView(webView) {
    [_uiWebViewWrapper retain];
    _uiWebViewWrapper.shouldStartLoading = [this](std::string url) {
        if (this->_webView->shouldStartLoading) {
            return this->_webView->shouldStartLoading(this->_webView, url);
        }
        return true;
    };
    _uiWebViewWrapper.didFinishLoading = [this](std::string url) {
        if (this->_webView->didFinishLoading) {
            this->_webView->didFinishLoading(this->_webView, url);
        }
    };
    _uiWebViewWrapper.didFailLoading = [this](std::string url) {
        if (this->_webView->didFailLoading) {
            this->_webView->didFailLoading(this->_webView, url);
        }
    };
    _uiWebViewWrapper.onJsCallback = [this](std::string url) {
        if (this->_webView->onJsCallback) {
            this->_webView->onJsCallback(this->_webView, url);
        }
    };
}

WebViewImpl::~WebViewImpl() {
    [_uiWebViewWrapper release];
    _uiWebViewWrapper = nullptr;
}

void WebViewImpl::setJavascriptInterfaceScheme(const std::string &scheme) {
    [_uiWebViewWrapper setJavascriptInterfaceScheme:scheme];
}

void WebViewImpl::loadData(cocos2d::extension::CCData &data, const std::string &MIMEType, const std::string &encoding, const std::string &baseURL) {
    const auto bytes = data.getBytes();
    const auto size = data.getSize();
    std::string dataString(reinterpret_cast<char *>(bytes), static_cast<unsigned int>(size));
    [_uiWebViewWrapper loadData:dataString MIMEType:MIMEType textEncodingName:encoding baseURL:baseURL];
}

void WebViewImpl::loadHTMLString(const std::string &string, const std::string &baseURL) {
    [_uiWebViewWrapper loadHTMLString:string baseURL:baseURL];
}

void WebViewImpl::loadUrl(const std::string &url) {
    [_uiWebViewWrapper loadUrl:url];
}

void WebViewImpl::loadFile(const std::string &fileName) {
    auto fullPath = cocos2d::CCFileUtils::sharedFileUtils()->fullPathForFilename(fileName.c_str());
    [_uiWebViewWrapper loadFile:fullPath];
}

void WebViewImpl::stopLoading() {
    [_uiWebViewWrapper stopLoading];
}

void WebViewImpl::reload() {
    [_uiWebViewWrapper reload];
}

bool WebViewImpl::canGoBack() {
    return _uiWebViewWrapper.canGoBack;
}

bool WebViewImpl::canGoForward() {
    return _uiWebViewWrapper.canGoForward;
}

void WebViewImpl::goBack() {
    [_uiWebViewWrapper goBack];
}

void WebViewImpl::goForward() {
    [_uiWebViewWrapper goForward];
}

void WebViewImpl::evaluateJS(const std::string &js) {
    [_uiWebViewWrapper evaluateJS:js];
}

void WebViewImpl::setScalesPageToFit(const bool scalesPageToFit) {
    [_uiWebViewWrapper setScalesPageToFit:scalesPageToFit];
}

void WebViewImpl::draw() {
    auto director = CCDirector::sharedDirector();
    auto glView = director->getOpenGLView();
    auto frameSize = glView->getFrameSize();
    auto scaleFactor = [[EAGLView sharedEGLView] contentScaleFactor];

    auto winSize = director->getWinSize();
    auto wv = this->_webView;
    auto wvSize = wv->getContentSize();

    auto leftBottom = wv->convertToWorldSpace(cocos2d::CCPointZero);
    auto rightTop = wv->convertToWorldSpace(cocos2d::CCPoint(wvSize.width,wvSize.height));
    auto x = (frameSize.width / 2 + (leftBottom.x - winSize.width / 2) * glView->getScaleX()) / scaleFactor;
    auto y = (frameSize.height / 2 - (rightTop.y - winSize.height / 2) * glView->getScaleY()) / scaleFactor;
    auto width = (rightTop.x - leftBottom.x) * glView->getScaleX() / scaleFactor;
    auto height = (rightTop.y - leftBottom.y) * glView->getScaleY() / scaleFactor;
    
    [_uiWebViewWrapper setFrameWithX:x
                                   y:y
                               width:width
                              height:height];
}

void WebViewImpl::setVisible(bool visible) {
    [_uiWebViewWrapper setVisible:visible];
}
} // namespace cocos2d
} // namespace plugin

#endif // CC_TARGET_PLATFORM == CC_PLATFORM_IOS
