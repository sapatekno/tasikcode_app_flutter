import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/model/category_model.dart';
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
  List<CategoryModel> _categories = List<CategoryModel>();

  bool isLoading = false;
  bool isError = false;

  int position = 0;
  int _page = 1;
  int _totalPages = 0;

  String errorMessage = "";
  String searchText = "";

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _presenter = new BlogPresenter(this);
    // ignore: invalid_use_of_protected_member
    _presenter.setView(this);

    _categories.add(CategoryModel(id: 0, name: "SEMUA"));
    _categories.add(CategoryModel(id: 0, name: "LOADING"));

    _presenter.getCategories();
    _presenter.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _searchBody(context),
          _categoriesBody(context),
          _postsBody(context),
        ],
      ),
    );
  }

  _searchBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: MyColors.bluePrimary,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                FontAwesome.search,
                color: MyColors.bluePrimary,
                size: 20,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _searchTextController,
                onSubmitted: (inputValue) {
                  inputValue = inputValue.toLowerCase().trim();

                  setState(() {
                    if (inputValue.isEmpty) {
                      searchText = "";
                    } else {
                      searchText = inputValue;
                      _presenter.getPosts(page: 1, searchText: searchText);
                    }
                  });
                },
                style: TextStyle(color: MyColors.bluePrimary, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Apa yang anda cari',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            searchText.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      FontAwesome.close,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchTextController.text = "";
                        searchText = "";
                        _presenter.getPosts(catID: _categories[position].id);
                      });
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _categoriesBody(BuildContext context) {
    return searchText.isNotEmpty
        ? Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: ButtonTheme(
                  buttonColor: MyColors.bluePrimary,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: 0,
                  height: 32,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "#PENCARIAN",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ), //your original button
                ),
              ),
            ],
          )
        : Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Container(
              height: 32,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: _categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: index == _categories.length - 1
                          ? EdgeInsets.all(0)
                          : EdgeInsets.only(right: 8),
                      child: ButtonTheme(
                        buttonColor: _categories[index].name == "RELOAD"
                            ? Colors.redAccent
                            : _categories[index].name == "LOADING" ||
                                    index == position
                                ? MyColors.bluePrimary
                                : MyColors.yellowSecond,
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minWidth: 0,
                        height: 0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_categories[index].name == "RELOAD") {
                              setState(() {
                                _categories.removeLast();
                                _categories
                                    .add(CategoryModel(id: 0, name: "LOADING"));

                                _presenter.getCategories();
                              });
                            } else if (_categories[index].name != "LOADING") {
                              setState(() {
                                _page = 1;
                                _refreshController.loadComplete();
                                position = index;
                                _presenter.getPosts(
                                    catID: _categories[index].id);
                              });
                            }
                          },
                          child: _categories[index].name != "LOADING"
                              ? Text(
                                  "#${_categories[index].name.toUpperCase()}",
                                  style: TextStyle(
                                      color:
                                          _categories[index].name == "RELOAD" ||
                                                  _categories[index].name ==
                                                      "LOADING" ||
                                                  index == position
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 12),
                                )
                              : SizedBox(
                                  width: 8,
                                  height: 8,
                                  child: CircularProgressIndicator(
                                    backgroundColor: MyColors.bluePrimary,
                                    valueColor: AlwaysStoppedAnimation(
                                        MyColors.yellowSecond),
                                  )),
                        ), //your original button
                      ),
                    );
                  }),
            ),
          );
  }

  _postsBody(BuildContext context) {
    return isError
        ? _errorBody(context)
        : isLoading
        ? _loadingBody(context)
        : Container(
      height: MediaQuery
          .of(context)
          .size
          .height - 265,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: (_posts.length ?? 0),
          itemBuilder: (BuildContext context, int index) {
            String dateFormatted =
            DateFormat("dd MMMM yyyy").format(_posts[index].date);

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BlogDetailPage(postData: _posts[index])),
                );
              },
              child: Padding(
                padding:
                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            imageUrl: _posts[index]
                                .embedded
                                .wpFeaturedmedia
                                ?.first
                                ?.sourceUrl ??
                                "",
                            placeholder: (context, url) =>
                                Container(
                                  width: 64,
                                  height: 64,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                      MyColors.bluePrimary,
                                      valueColor: AlwaysStoppedAnimation(
                                          MyColors.yellowSecond),
                                    ),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                WebsafeSvg.asset(
                                    MyApps.pathAssetsImages(
                                        "img_placeholder_large.svg"),
                                    fit: BoxFit.fitHeight,
                                    height: 96),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 24),
                              child: HtmlWidget(
                                _posts[index].title.rendered ?? "-",
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            // ! Bisa menampilkan banyak kategori tapi masih belum clean code
                            Container(
                              height: 24,
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _posts[index]
                                      .embedded
                                      .wpTerm
                                      .first
                                      .length,
                                  itemBuilder: (BuildContext context,
                                      int position) {
                                    return Padding(
                                      padding:
                                      EdgeInsets.only(right: 4),
                                      child: Text(
                                        _posts[index]
                                            .embedded
                                            .wpTerm
                                            .first[position]
                                            .name +
                                            (_posts[index]
                                                .embedded
                                                .wpTerm
                                                .first
                                                .last
                                                .id ==
                                                _posts[index]
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
                                  fontSize: 12,
                                  color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _errorBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            errorMessage ?? "Unknowen Error",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            color: MyColors.yellowSecond,
            onPressed: () {
              _presenter.getPosts(
                  catID: _categories[position].id, searchText: searchText);
              isError = false;
            },
            child: Text("Refresh"),
          ),
        ),
      ],
    );
  }

  _loadingBody(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: MyColors.bluePrimary,
            valueColor: AlwaysStoppedAnimation(MyColors.yellowSecond),
          ),
        ),
      ),
    );
  }

  @override
  void setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  void loadCategories(List<CategoryModel> categories) {
    setState(() {
      _categories.removeLast();
      _categories.addAll(categories);
    });
  }

  @override
  void loadPosts(List<PostModel> posts, int totalPages, bool isRefresh,
      bool isLoad) {
    setState(() {
      _totalPages = totalPages;

      if (!isLoad) {
        _posts.clear();
      }

      _posts.addAll(posts);
      setLoading(false);

      if (isRefresh) {
        setState(() {
          _page = 1;
        });

        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
      }

      if (isLoad) {
        _refreshController.loadComplete();
      }
    });
  }

  @override
  void showErrorCategories() {
    setState(() {
      _categories.removeLast();
      _categories.add(CategoryModel(id: 0, name: "RELOAD"));
    });
  }

  @override
  void showErrorPost(String message) {
    setState(() {
      errorMessage = message;
      isError = true;
    });
  }

  onRefresh() {
    _presenter.getPosts(
        catID: _categories[position].id,
        isRefresh: true,
        searchText: searchText);
  }

  onLoading() {
    print("page - current page $_page of $_totalPages");
    if (_page < _totalPages) {
      _page++;
      _presenter.getPosts(
          catID: _categories[position].id,
          isLoad: true,
          page: _page,
          searchText: searchText);
    } else {
      _refreshController.loadNoData();
    }
  }
}
