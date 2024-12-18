import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../features/livechat/view/widgets/im_video_viewer.dart';
import '../../features/settings/viewmodel/user_viewmodel.dart';
import '../config.dart';
import '../global_data.dart';
import '../widgets/cached_image.dart';
import '../widgets/expanded_children_row.dart';
import '../widgets/innovay_text.dart';
import '../widgets/share_container_widget.dart';
import 'debug_utils.dart';

class CommonUtils {
  static void setLightStatusText({Color backgroundColor = Colors.transparent}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor, // background
      statusBarIconBrightness: Brightness.light, // Android
      statusBarBrightness: Brightness.dark, // iOS
    ));
  }

  static void setDarkStatusText({Color backgroundColor = Colors.transparent}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor, // background
      statusBarIconBrightness: Brightness.dark, // Android
      statusBarBrightness: Brightness.light, // iOS
    ));
  }

  // static bool isValidMobile(String mobile) {
  //   bool isMobile = true;
  //   if (int.tryParse(mobile) == null) {
  //     isMobile = false;
  //   } else if (mobile.length != 11) {
  //     isMobile = false;
  //   }
  //   if (!isMobile) {
  //     SnackBarManager.displayMessage('请输入有效的手机号');
  //   }
  //   return isMobile;
  // }

  static void sendSms(String mobile, String event) {
    // if (mobile.isEmpty) {
    //   return SnackBarManager.displayMessage('请输入有效的手机号');
    // }
    // NetworkManager.getRequest(InnovayConfig.mainNetworkConfig.sendSms(mobile, event), (res) {
    //   SnackBarManager.displayMessage('验证码已发送, 10分钟内有效');
    // }, (res) {});
  }

  static void verifySms(String mobile, String event, String content, Function() successCallback) {
    // NetworkManager.postRequest(
    //     InnovayConfig.mainNetworkConfig.verifySms(), {'mobile': mobile, 'event': event, 'content': content},
    //         (res) {
    //       successCallback();
    //     }, (res) {});
  }

  static Future navigateToHomeTab0AndClearHistory(BuildContext context) {
    DebugManager.log('navigateToHomeAndClearHistory');
    return Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (r) => false);
  }

  static Future navigateToPage(
    BuildContext context,
    String pageRoute, {
    Map<String, dynamic> params = const {},
    bool shouldPop = false,
  }) {
    DebugManager.log('navigateToPage: $pageRoute');
    // DebugManager.Log(params.toString());

    if (pageRoute.isEmpty) {
      DebugManager.log('pageRoute is empty');
      return Future<bool>.value(true);
    }
    var screenNameComponents = pageRoute.split('?');
    if (screenNameComponents.length > 1) {
      if (params.isEmpty) {
        params = {};
      }
      var screenNameParams = screenNameComponents[1].split('&');
      for (var i = 0; i < screenNameParams.length; i++) {
        var parts = screenNameParams[i].split('=');
        if (parts.length != 2) continue;
        params[parts[0]] = parts[1];
      }
    }

    DebugManager.log(params.toString());

    if (shouldPop) {
      return Navigator.of(context).popAndPushNamed('/${screenNameComponents[0]}', arguments: params);
    }
    return Navigator.of(context).pushNamed('/${screenNameComponents[0]}', arguments: params);
  }

  static Future navigateToImGroupPage(BuildContext context, dynamic imGroupData) {
    final user = UserViewmodel().currentUser;
    var imGroupId = imGroupData['id'];
    var memberList = imGroupData['member_list'];
    var chatterIndex = 0;
    if (memberList[chatterIndex]['user_id'] == user.id) {
      chatterIndex = 1;
    }
    return navigateToPage(context, 'PersonalChatRoomScreen',
        params: {'pageTitle': memberList[chatterIndex]['name'], 'chatterUserId': memberList[chatterIndex]['id']});
  }

  static Future navigateToFilePreview(BuildContext context, String fileUrl) {
    return navigateToPage(
      context,
      'WebFileViewScreen',
      params: {'fileUrl': fileUrl, 'pageTitle': AppLocalizations.of(context)!.preview},
    );
  }
  //
  // static void openAppMarket(String deviceBrand) async {
  //   String targetUrl = '';
  //   Map<String, String> brandUrlMapping = {
  //     'apple': InnovayGlobalData.appleMarket,
  //     'vivo': InnovayGlobalData.vivoMarket,
  //     'oppo': InnovayGlobalData.oppoMarket,
  //     'xiaomi': InnovayGlobalData.xiaomiMarket,
  //     'huawei': InnovayGlobalData.huaweiMarket,
  //     'honor': InnovayGlobalData.huaweiMarket,
  //     'meizhu': InnovayGlobalData.meizuMarket,
  //   };
  //   if (brandUrlMapping.containsKey(deviceBrand)) {
  //     targetUrl = brandUrlMapping[deviceBrand]!;
  //   } else {
  //     targetUrl = InnovayGlobalData.appDownloadPage;
  //   }
  //
  //   DebugManager.log('onRateTap');
  //   DebugManager.log(targetUrl);
  //
  //   if (await canLaunchUrl(Uri.parse(targetUrl))) {
  //     await launchUrl(Uri.parse(targetUrl));
  //   } else {
  //     DebugManager.log('Cannot launch url: $targetUrl');
  //     await launchUrl(Uri.parse(InnovayGlobalData.appDownloadPage));
  //   }
  // }

  // static void checkForUpdate(BuildContext context, String deviceBrand, String os, String version) {
  //   InnovayGlobalData.switchLoadingOverlay(true);
  //   NetworkManager.getRequest(InnovayConfig.mainNetworkConfig.checkForUpdate(os, version), (res) {
  //     InnovayGlobalData.switchLoadingOverlay(false);
  //     if (!res['data']['has_update']) {
  //       SnackBarManager.displayMessage('未检测到新版本');
  //       // } else if (res['data']['force_update']) {
  //       //
  //     } else {
  //       openAppMarket(deviceBrand);
  //     }
  //   }, (res) {
  //     InnovayGlobalData.switchLoadingOverlay(false);
  //     SnackBarManager.displayMessage('暂无更新');
  //   });
  // }

  static void displayCustomDialog(
    BuildContext context,
    String contentText,
    List<Widget> extraContents,
    Icon? cancelIcon,
    Icon? rejectIcon,
    Icon? confirmIcon,
    Function() rejectCallback,
    Function() confirmCallback,
    bool barrierDismissible, {
    Alignment alignment = Alignment.center,
  }) {
    List<Widget> actions = [];
    if (cancelIcon != null) {
      actions.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: IconButton(
            color: cancelIcon.color,
            icon: cancelIcon,
            onPressed: () {
              Navigator.pop(context);
            },
          )));
    }
    if (rejectIcon != null) {
      actions.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: IconButton(
            color: rejectIcon.color,
            icon: rejectIcon,
            onPressed: () {
              Navigator.pop(context);
              rejectCallback();
            },
          )));
    }
    if (confirmIcon != null) {
      actions.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: IconButton(
            color: confirmIcon.color,
            icon: confirmIcon,
            onPressed: () {
              Navigator.pop(context);
              confirmCallback();
            },
          )));
    }

    Dialog alert = Dialog(
      alignment: alignment,
      insetPadding: const EdgeInsets.only(bottom: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: InnoConfig.colors.backgroundColorTinted3,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        width: MediaQuery.of(context).size.width * 0.9,
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            contentText.isEmpty
                ? const SizedBox.shrink()
                : Text(contentText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 2,
                      color: InnoConfig.colors.textColorDark2,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 10),
            extraContents.isEmpty ? const SizedBox.shrink() : Column(children: extraContents),
            const SizedBox(height: 30),
            ExpandedChildrenRow(children: actions),
          ],
        )),
      ),
    );

    // show the dialog
    showDialog(
      barrierDismissible: barrierDismissible,
      // barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void displayLoginAlert(BuildContext context) {
    displayCustomDialog(context, AppLocalizations.of(context)!.loginRequired, [], const Icon(Icons.cancel_outlined),
        null, const Icon(Icons.check_circle_outline), () {}, () {
      navigateToPage(context, 'LoginSignupScreen?isFromDialog=yes');
    }, true);
  }

  static void displayBottomPicker(BuildContext context, String title, List<Widget> childrenWidgets) {
    showModalBottomSheet(
      backgroundColor: InnoConfig.colors.backgroundColor,
      elevation: 0,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        side: BorderSide.none,
      ),
      builder: (BuildContext context) {
        var children = <Widget>[
          if (title.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(15),
              child: InnoText(title, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ...childrenWidgets,
          Row(children: [
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ]),
        ];
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
            // child: Column(children: [SingleChildScrollView(child: Wrap(children: children))])),
            child: SingleChildScrollView(child: Wrap(children: children)),
          ),
        );
      },
    );
  }

  static void displayShareOptions(String shareFileUrl, String shareText) {
    CommonUtils.displayBottomPicker(InnoGlobalData.bottomNavigatorContext!, '',
        [ShareContainer(shareFilePath: shareFileUrl, shareText: shareText)]);
  }

  static void displayImageFullScreenBottomSheet(BuildContext targetContext, List<String> imageList, int startingIndex) {
    showModalBottomSheet(
      backgroundColor: Colors.black87,
      context: targetContext,
      isScrollControlled: true,
      isDismissible: true,
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  InteractiveViewer(
                    child: ExpandedChildrenRow(
                      children: [
                        InnovayCachedImage(
                          imageList[startingIndex],
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //     left: 0,
                  //     right: 0,
                  //     bottom: MediaQuery.of(targetContext).padding.bottom + 10,
                  //     child: Center(
                  //         child: IconButton(
                  //             onPressed: () {
                  //               Navigator.pop(targetContext);
                  //             },
                  //             icon: const Icon(Icons.close, color: Colors.black38, size: 32)))),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static void displayVideoFullScreenBottomSheet(
      BuildContext targetContext, String localThumbnailPath, String videoUrl, Map<String, String> videoHeaders) {
    showModalBottomSheet(
      backgroundColor: Colors.black87,
      context: targetContext,
      isScrollControlled: true,
      isDismissible: true,
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ImVideoViewerWidget(
                    localThumbnailPath: localThumbnailPath,
                    videoUrl: videoUrl,
                    videoUrlHeaders: videoHeaders,
                  ),
                  // Positioned(
                  //   left: 0,
                  //   right: 0,
                  //   bottom: MediaQuery.of(targetContext).padding.bottom + 10,
                  //   child: Center(
                  //     child: IconButton(
                  //       onPressed: () {
                  //         Navigator.pop(targetContext);
                  //       },
                  //       icon: const Icon(Icons.close, color: Colors.black38, size: 32),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static WebViewController createWebViewController(
    String startingUrl,
    Map<String, String> headers,
    String jsChannelName,
    Function(JavaScriptMessage) jsChannelCallback,
    Function(String) onPageFinished,
  ) {
    const PlatformWebViewControllerCreationParams params = PlatformWebViewControllerCreationParams();
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            DebugManager.log('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            DebugManager.log('Page started loading');
          },
          onPageFinished: (String url) {
            DebugManager.log('Page finished loading: $url, $headers');
            onPageFinished(url);
          },
          onWebResourceError: (WebResourceError error) {
            DebugManager.log('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     DebugManager.log('blocking navigation to ${request.url}');
          //     return NavigationDecision.prevent;
          //   }
          //   DebugManager.log('allowing navigation to ${request.url}');
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..addJavaScriptChannel(
        jsChannelName.isEmpty ? 'test' : jsChannelName,
        onMessageReceived: jsChannelCallback,
      )
      ..loadRequest(Uri.parse(startingUrl), headers: headers);

    controller.setBackgroundColor(Colors.transparent);
    return controller;
  }
}
