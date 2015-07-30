LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE    := cocos_webview_plugin_static

LOCAL_MODULE_FILENAME := libwebviewplugin

LOCAL_SRC_FILES := \
	WebView.cpp \
	WebViewImpl_android.cpp \
	jni/org_cocos2dx_lib_Cocos2dxWebViewHelper.cpp


LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_static

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_EXPORT_C_INCLUDES += $(LOCAL_PATH)/../common

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../cocos2d-x/cocos2dx/base_nodes \
                    $(LOCAL_PATH)/../../cocos2d-x/cocos2dx/platform \
                    $(LOCAL_PATH)/../../cocos2d-x/cocos2dx/platform/android \
                    $(LOCAL_PATH)/../../cocos2d-x/extensions \
                    $(LOCAL_PATH)/../../cocos2d-x/extensions/CCBReader \
                    $(LOCAL_PATH)/../common \
                    $(LOCAL_PATH)/ \
                    $(LOCAL_PATH)/jni

include $(BUILD_STATIC_LIBRARY)

# $(call import-module,./)
