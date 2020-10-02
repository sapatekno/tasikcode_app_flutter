import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/detail/blog_detail_presenter.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BlogDetailPage extends BaseStatefulWidget {
  final PostModel postData;

  BlogDetailPage({this.postData});

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState
    extends BaseState<BlogDetailPage, BlogDetailPresenter>
    implements BlogDetailContract {
  PostModel postData;
  String dateFormatted;

  @override
  void initState() {
    super.initState();

    postData = widget.postData;
    dateFormatted = DateFormat("dd MMMM yyyy").format(postData.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: WebsafeSvg.asset(
              MyApps.pathAssetsImages("tcode_logo_small.svg"),
            ),
          ),
          Text(
            "Tasik",
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w600,
              color: MyColors.bluePrimary,
            ),
          ),
          Text(
            "code",
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w600,
              color: MyColors.yellowSecond,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            FontAwesome.bell_o,
            color: MyColors.bluePrimary,
          ),
          onPressed: () => null,
        )
      ],
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          FontAwesome.arrow_left,
          color: Colors.black,
        ),
      ),
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HtmlWidget(
              postData.title.rendered ?? "-",
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                color: MyColors.blueSoft,
                height: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                "Posted on $dateFormatted by ${postData.embedded.author.first.name}",
                style: TextStyle(fontSize: 12, color: MyColors.bluePrimary),
              ),
            ),
            HtmlWidget(postData.content.rendered ?? "-"),
          ],
        ),
      ),
    );
  }
}
