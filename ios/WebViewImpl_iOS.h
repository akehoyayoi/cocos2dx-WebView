//
// Created by gin0606 on 2014/07/30.
//

#ifndef __cocos2d_plugin_WebViewImpl_IOS_H_
#define __cocos2d_plugin_WebViewImpl_IOS_H_

#include <iosfwd>

#include "CCData.h"

@class UIWebViewWrapper;

namespace cocos2d {

namespace plugin {
class WebView;

class WebViewImpl {
public:
    WebViewImpl(cocos2d::plugin::WebView *webView);

    virtual ~WebViewImpl();

    void setJavascriptInterfaceScheme(const std::string &scheme);

    void loadData(cocos2d::extension::CCData &data, const std::string &MIMEType, const std::string &encoding, const std::string &baseURL);

    void loadHTMLString(const std::string &string, const std::string &baseURL);

    void loadUrl(const std::string &url);

    void loadFile(const std::string &fileName);

    void stopLoading();

    void reload();

    bool canGoBack();

    bool canGoForward();

    void goBack();

    void goForward();

    void evaluateJS(const std::string &js);

    void setScalesPageToFit(const bool scalesPageToFit);

    virtual void draw();

    virtual void setVisible(bool visible);

private:
    UIWebViewWrapper *_uiWebViewWrapper;
    WebView *_webView;
};

} // namespace cocos2d
} // namespace plugin

#endif //__cocos2d_plugin_WebViewImpl_IOS_H_
