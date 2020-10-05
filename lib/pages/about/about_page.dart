import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesome.close,
                color: MyColors.bluePrimary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: _body(context),
              ),
            ),
          );
        },
      ),
    );
  }

  _body(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logoBody(context),
              _titleBody(context),
              _featureBody(context,
                  text: "TasikCode Website", url: "https://tasikcode.xyz/"),
              _featureBody(context,
                  text: "TasikCode GitHub",
                  url: "https://github.com/TasikCode"),
              _featureBody(context,
                  text: "TasikCode Podcast",
                  url: "https://open.spotify.com/show/2WCK5c97PBdD7qepGnpxRu"),
            ],
          ),
        ),
      ],
    );
  }

  _logoBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Hero(
        tag: 'image',
        child: WebsafeSvg.asset(
          MyApps.pathAssetsImages("tcode_logo_small.svg"),
          width: 96,
          height: 96,
        ),
      ),
    );
  }

  _titleBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Tasik ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: MyColors.bluePrimary),
          ),
          Text(
            "Code",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: MyColors.yellowSecond),
          ),
        ],
      ),
    );
  }

  _featureBody(BuildContext context, {String text, String url}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: MyColors.bluePrimary),
          ),
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () async {
                if (await canLaunch(url)) {
                  await launch(url, forceSafariVC: false, forceWebView: false);
                } else {
                  print("url - cant open url");
                }
              }),
        ],
      ),
    );
  }
}
