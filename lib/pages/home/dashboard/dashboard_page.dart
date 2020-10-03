import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/detail/blog_detail_page.dart';
import 'package:tasikcode_app_flutter/pages/home/dashboard/dashboard_presenter.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:websafe_svg/websafe_svg.dart';

class DashboardPage extends BaseStatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseState<DashboardPage, DashboardPresenter>
    implements DashboardContract {
  DashboardPresenter _presenter;
  String _imageURL =
      "https://blog.tasikcode.xyz/wp-content/uploads/2019/10/DSC00280.jpg";

  @override
  void initState() {
    super.initState();
    _presenter = new DashboardPresenter(this);
    // ignore: invalid_use_of_protected_member
    _presenter.setView(this);
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ? Masih Bingung Mau Nampilin Gambar Apa :D
            InkWell(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) {
                    return StatefulBuilder(
                      builder: (ctxStateful, setState) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Tasikmalaya Hacktoberfest 2019"),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Batal",
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text("Buka",
                                  style:
                                      TextStyle(color: MyColors.bluePrimary)),
                              onPressed: () async {
                                String url =
                                    "https://blog.tasikcode.xyz/2019/10/24/tasikmalaya-hacktoberfest-2019/";
                                if (await canLaunch(url)) {
                                  await launch(url,
                                      forceSafariVC: false,
                                      forceWebView: false);
                                } else {
                                  print("url - cant open url");
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: _imageURL,
                  placeholder: (context, url) => Container(
                      child: Padding(
                    padding: EdgeInsets.all(64),
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: MyColors.bluePrimary,
                      valueColor: AlwaysStoppedAnimation(MyColors.yellowSecond),
                    )),
                  )),
                  errorWidget: (context, url, error) => Padding(
                    padding: EdgeInsets.all(64),
                    child: Container(
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Artikel Terbaru",
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                color: MyColors.blueSoft,
                height: 1,
              ),
            ),
            _artikelTerbaru(context),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  _artikelTerbaru(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: _presenter.getArtikelTerbaru(),
      builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
        Widget childData;

        if (snapshot.hasData) {
          childData = ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                String dateFormatted = DateFormat("dd MMMM yyyy")
                    .format(snapshot.data[index].date);

                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlogDetailPage(
                                  postData: snapshot.data[index])),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: WebsafeSvg.asset(
                                // ? Masih Bingung Thumbnail Diambil Darimana
                                MyApps.pathAssetsImages(
                                  "img_placeholder_small.svg",
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: HtmlWidget(
                                      snapshot.data[index].title.rendered ??
                                          "-",
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  // ! Sudah Bisa menampilkan lebih dari 1 kategori cuma belum rapih
                                  Container(
                                    height: 24,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data[index].embedded
                                            .wpTerm.first.length,
                                        itemBuilder: (BuildContext context,
                                            int position) {
                                          return Padding(
                                            padding: EdgeInsets.only(right: 4),
                                            child: Text(
                                              snapshot
                                                  .data[index]
                                                  .embedded
                                                  .wpTerm
                                                  .first[position]
                                                  .name +
                                                  (snapshot
                                                      .data[index]
                                                      .embedded
                                                      .wpTerm
                                                      .first
                                                      .last
                                                      .id ==
                                                      snapshot
                                                          .data[index]
                                                          .embedded
                                                          .wpTerm
                                                          .first[
                                                      position]
                                                          .id
                                                      ? ""
                                                      : ",") ??
                                                  "-",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey),
                                            ),
                                          );
                                        }),
                                  ),
                                  Text(
                                    dateFormatted ?? "-",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          childData = Text(
            "Tidak dapat mengambil Artikel Terbaru",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          );
        } else {
          childData = Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: MyColors.bluePrimary,
                valueColor: AlwaysStoppedAnimation(MyColors.yellowSecond),
              ),
            ),
          );
        }

        return Container(
          child: childData,
        );
      },
    );
  }
}
