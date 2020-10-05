import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/pages/home/baraya/baraya_presenter.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BarayaPage extends BaseStatefulWidget {
  @override
  _BarayaPageState createState() => _BarayaPageState();
}

class _BarayaPageState extends BaseState<BarayaPage, BarayaPresenter>
    implements BarayaContract {
  final _key = UniqueKey();

  String _initialUrl;
  num _stackToView = 1;

  @override
  void initState() {
    super.initState();
    _initialUrl = "https://baraya.tasikcode.xyz";
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _stackToView,
      children: [
        _webview(context),
        _loading(context),
      ],
    );
  }

  _webview(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _initialUrl != null
              ? WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: _initialUrl,
                  onWebViewCreated: (WebViewController webViewController) {},
                  onPageFinished: handleLoad,
                  navigationDelegate: (NavigationRequest request) {
                    print('blocking navigation to $request}');
                    launchURL(request.url);
                    return NavigationDecision.prevent;
                  },
                )
              : _loading(context),
        ),
      ],
    );
  }

  _loading(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: MyColors.bluePrimary,
          valueColor: AlwaysStoppedAnimation(MyColors.yellowSecond),
        ),
      ),
    );
  }

  handleLoad(String value) async {
    setState(() {
      _stackToView = 0;
    });
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("url : could not launch $url");
    }
  }
}
