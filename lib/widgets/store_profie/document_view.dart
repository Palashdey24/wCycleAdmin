import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({
    super.key,
    required this.content,
    required this.getUri,
  });

  final FutureOr<Uint8List> content;
  final String getUri;

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  late PlatformWebViewController _controller;
  bool isLoading = true;
  @override
  void initState() {
    _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          uri: Uri.parse(widget.getUri),
        ),
      ).whenComplete(
        () {
          setState(() {
            isLoading = false;
          });
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(widget.getUri);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : PlatformWebViewWidget(
                PlatformWebViewWidgetCreationParams(controller: _controller),
              ).build(context),
      ),
    );
  }
}
