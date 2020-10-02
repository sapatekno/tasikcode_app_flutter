import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/blog_presenter.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/detail/blog_detail_page.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BlogPage extends BaseStatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends BaseState<BlogPage, BlogPresenter>
    implements BlogContract {
  BlogPresenter _presenter;
  List<PostModel> _posts = List<PostModel>();

  @override
  void initState() {
    super.initState();
    _presenter = new BlogPresenter(this);
    // ignore: invalid_use_of_protected_member
    _presenter.setView(this);
    _presenter.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ButtonTheme(
                    buttonColor: MyColors.bluePrimary,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        '#SEMUA',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ), //your original button
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ButtonTheme(
                    buttonColor: MyColors.yellowSecond,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        '#PROGRAMMING',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ), //your original button
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ButtonTheme(
                    buttonColor: MyColors.yellowSecond,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        '#PRODUCT',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ), //your original button
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // ? Masih Bingung Mau Nampilin Gambar Apa :D
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: WebsafeSvg.asset(
                  MyApps.pathAssetsImages("img_placeholder_large.svg"),
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            _postsBody(context),
          ],
        ),
      ),
    );
  }

  @override
  void loadPosts(List<PostModel> posts) {
    setState(() {
      _posts.addAll(posts);
    });
  }

  _postsBody(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: (_posts.length ?? 0),
      itemBuilder: (BuildContext context, int index) {
        String dateFormatted =
            DateFormat("dd MMMM yyyy").format(_posts[index].date);

        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Container(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BlogDetailPage(postData: _posts[index])),
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
                        fit: BoxFit.fitHeight,
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
                            padding: EdgeInsets.only(bottom: 24),
                            child: HtmlWidget(
                              _posts[index].title.rendered ?? "-",
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          // ! Sementara hanya bisa menampilkan 1 Kategori saja
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              _posts[index].embedded.wpTerm.first.first.name ??
                                  "-",
                              style:
                                  TextStyle(fontSize: 12, color: MyColors.grey),
                            ),
                          ),
                          Text(
                            dateFormatted ?? "-",
                            style:
                                TextStyle(fontSize: 12, color: MyColors.grey),
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
      },
    );
  }
}