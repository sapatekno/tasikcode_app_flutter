import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/blog_presenter.dart';

class BlogPage extends BaseStatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends BaseState<BlogPage, BlogPresenter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Blog test"),
      ),
    );
  }
}
