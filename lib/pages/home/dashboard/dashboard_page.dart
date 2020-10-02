import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/model/category_model.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';
import 'package:tasikcode_app_flutter/pages/home/dashboard/dashboard_presenter.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class DashboardPage extends BaseStatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseState<DashboardPage, DashboardPresenter>
    implements DashboardContract {
  DashboardPresenter _presenter;

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
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: FittedBox(
                  child: SvgPicture.asset(
                    MyApps.pathAssetsImages("img_placeholder_large.svg"),
                    width: 1000,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
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
            Text(
              "Event Terbaru",
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                color: MyColors.blueSoft,
                height: 1,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  "Coming ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: MyColors.bluePrimary),
                ),
                Text(
                  "Soon",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.yellowSecond),
                ),
              ],
            ),
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
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 24),
                                child: HtmlWidget(
                                  snapshot.data[index].title.rendered ?? "-",
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                              // ! Sementara hanya bisa menampilkan 1 Kategori saja
                              Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: FutureBuilder<CategoryModel>(
                                  future: _presenter.getCategory(
                                      snapshot.data[index].categories.first ??
                                          1),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<CategoryModel> snapshot) {
                                    String childData;

                                    if (snapshot.hasData) {
                                      childData = snapshot.data.name;
                                    } else if (snapshot.hasError) {
                                      childData = "Error";
                                    } else {
                                      childData = "-";
                                    }

                                    return Text(
                                      childData,
                                      style: TextStyle(
                                          fontSize: 12, color: MyColors.grey),
                                    );
                                  },
                                ),
                              ),
                              Text(
                                snapshot.data[index].date
                                        .toString()
                                        .toString() ??
                                    "-",
                                style: TextStyle(
                                    fontSize: 12, color: MyColors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
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
