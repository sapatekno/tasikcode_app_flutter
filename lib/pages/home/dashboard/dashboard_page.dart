import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
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
    _presenter.samplePresenter();
    _presenter.getArtikelTerbaru();
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
          children: <Widget>[
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
                                "img_placeholder.svg",
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
                                child: Text(
                                  snapshot.data[index].categories.first
                                          .toString() ??
                                      "-",
                                  style: TextStyle(
                                      fontSize: 12, color: MyColors.grey),
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
            "Tidak dapat mengambil Artikel",
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
