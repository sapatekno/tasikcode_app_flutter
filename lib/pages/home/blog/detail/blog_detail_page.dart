import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/detail/blog_detail_presenter.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';
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

    print("check ${postData.content.rendered}");
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
          tooltip: "Notifikasi",
          icon: Icon(
            FontAwesome.bell_o,
            color: MyColors.bluePrimary,
          ),
          onPressed: () {
            showAlert(
                message: "Belum ada notifikasi terbaru",
                color: MyColors.bluePrimary);
          },
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
    String featuredImage =
        (postData.embedded.wpFeaturedmedia?.first?.sourceUrl ?? "");

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HtmlWidget(
              postData.title.rendered ?? "-",
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              child: Row(
                children: [
                  Text(
                    "Posted on $dateFormatted by ",
                    style: TextStyle(fontSize: 14, color: MyColors.bluePrimary),
                  ),
                  postData.embedded.author.first.url.isNotEmpty
                      ? InkWell(
                          onTap: () async {
                            if (await canLaunch(
                                postData.embedded.author.first.url)) {
                              await launch(postData.embedded.author.first.url,
                                  forceSafariVC: false, forceWebView: false);
                            } else {
                              print("url - cant open url");
                            }
                          },
                          child: Text(
                            postData.embedded.author.first.name ?? "-",
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        )
                      : Text(
                          postData.embedded.author.first.name ?? "-",
                          style: TextStyle(
                              fontSize: 14, color: MyColors.bluePrimary),
                        ),
                ],
              ),
            ),
            featuredImage.isEmpty
                ? Container()
                : InkWell(
              onTap: () => popUpImage(featuredImage),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: featuredImage,
                  placeholder: (context, url) =>
                      Container(
                          child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: MyColors.bluePrimary,
                                valueColor:
                              AlwaysStoppedAnimation(MyColors.yellowSecond),
                        ))),
                        errorWidget: (context, url, error) => WebsafeSvg.asset(
                          MyApps.pathAssetsImages("img_placeholder_large.svg"),
                          fit: BoxFit.fitWidth,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
            Html(
              data: postData.content.rendered,
              onLinkTap: (url) async {
                if (await canLaunch(url)) {
                  await launch(url, forceSafariVC: false, forceWebView: false);
                } else {
                  print("url - cant open url");
                }
              },
              onImageTap: (imageUrl) {
                popUpImage(imageUrl);
              },
              style: {
                "blockquote": Style(
                  padding: EdgeInsets.only(left: 8),
                  border: Border(
                    left: BorderSide(color: MyColors.bluePrimary, width: 4),
                  ),
                ),
                "ul": Style(color: Colors.white),
              },
            ),
          ],
        ),
      ),
    );
  }

  askStoragePermission(String imageUrl) async {
    await Permission.storage.request();
    var status = await Permission.storage.status;

    if (status.isGranted) {
      saveImageToGallery(imageUrl);
    } else {
      showAlert(
          message: "Tidak dapat menyimpan gambar tanpa akses.",
          color: Colors.red);
    }
  }

  popUpImage(String imageUrl) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctxStateful, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 64,
                              child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: MyColors.bluePrimary,
                                    valueColor:
                                    AlwaysStoppedAnimation(
                                        MyColors.yellowSecond),
                                  ))),
                      errorWidget: (context, url, error) =>
                          WebsafeSvg.asset(
                            MyApps.pathAssetsImages(
                                "img_placeholder_large.svg"),
                            fit: BoxFit.fitWidth,
                            height: 200,
                          ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        color: MyColors.yellowSecond,
                        onPressed: () => saveImageToGallery(imageUrl),
                        child: Text("Simpan ke Galeri"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  saveImageToGallery(String imageUrl) async {
    var status = await Permission.storage.status;

    if (status.isGranted) {
      // * Akses Storage diterima, simpan gambar ke galeri

      File file = new File(imageUrl);
      String baseName = file.path
          .split("/")
          .last;

      try {
        var response = await Dio()
            .get(imageUrl, options: Options(responseType: ResponseType.bytes));
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
            quality: 90, name: baseName);

        Navigator.pop(context);
        showAlert(
            message: "Gambar berhasil disimpan", color: MyColors.bluePrimary);
      } catch (error) {
        showAlert(
            message: "Tidak dapat menyimpan gambar, silahkan coba lagi",
            color: Colors.red);
      }
    } else if (status.isUndetermined) {
      askStoragePermission(imageUrl);
    } else if (status.isDenied) {
      askStoragePermission(imageUrl);
    } else if (status.isRestricted || status.isPermanentlyDenied) {
      showAlert(
          message: "Berikan hak akses untuk penyimpanan",
          color: MyColors.bluePrimary);
      await Future.delayed(Duration(seconds: 2));
      openAppSettings();
    }
  }
}
