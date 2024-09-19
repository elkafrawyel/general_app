import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:general_app/config/helpers/logging_helper.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';

class AppWebview extends StatefulWidget {
  final String title;
  final String url;
  const AppWebview({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<AppWebview> createState() => _AppWebviewState();
}

class _AppWebviewState extends State<AppWebview> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    pullToRefreshController ??= kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              backgroundColor: context.kPrimaryColor,
              color: context.kColorOnPrimary,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );

    return Scaffold(
      appBar: AppAppbar(
        title: widget.title,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Offstage(
            offstage: progress >= 1.0,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: LinearProgressIndicator(
                value: progress,
                color: context.kPrimaryColor,
                minHeight: 5,
              ),
            ),
          ),
          Flexible(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: WebUri.uri(
                  Uri.parse(widget.url),
                ),
              ),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialSettings: InAppWebViewSettings(
                useShouldOverrideUrlLoading: false,
              ),
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) async =>
                  webViewController = controller,
              onLoadStart: (controller, uri) {},
              shouldOverrideUrlLoading: (controller, navigationAction) async =>
                  NavigationActionPolicy.ALLOW,
              onLoadStop: (controller, url) async {
                pullToRefreshController?.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController?.endRefreshing();
                }
                setState(() => this.progress = progress / 100);
              },
              onUpdateVisitedHistory: (controller, url, isReload) {},
              onConsoleMessage: (controller, consoleMessage) =>
                  AppLogger.getxLog(consoleMessage.message),
            ),
          ),
        ],
      ),
    );
  }
}
