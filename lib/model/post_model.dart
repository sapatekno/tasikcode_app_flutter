// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.content,
    this.excerpt,
    this.author,
    this.featuredMedia,
    this.commentStatus,
    this.pingStatus,
    this.sticky,
    this.template,
    this.format,
    this.meta,
    this.categories,
    this.tags,
    this.links,
    this.embedded,
  });

  num id;
  DateTime date;
  DateTime dateGmt;
  Guid guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  num author;
  num featuredMedia;
  String commentStatus;
  String pingStatus;
  bool sticky;
  String template;
  String format;
  List<dynamic> meta;
  List<num> categories;
  List<num> tags;
  PostModelLinks links;
  Embedded embedded;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dateGmt:
            json["date_gmt"] == null ? null : DateTime.parse(json["date_gmt"]),
        guid: json["guid"] == null ? null : Guid.fromJson(json["guid"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedGmt: json["modified_gmt"] == null
            ? null
            : DateTime.parse(json["modified_gmt"]),
        slug: json["slug"] == null ? null : json["slug"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : Guid.fromJson(json["title"]),
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        excerpt:
            json["excerpt"] == null ? null : Content.fromJson(json["excerpt"]),
        author: json["author"] == null ? null : json["author"],
        featuredMedia:
            json["featured_media"] == null ? null : json["featured_media"],
        commentStatus:
            json["comment_status"] == null ? null : json["comment_status"],
        pingStatus: json["ping_status"] == null ? null : json["ping_status"],
        sticky: json["sticky"] == null ? null : json["sticky"],
        template: json["template"] == null ? null : json["template"],
        format: json["format"] == null ? null : json["format"],
        meta: json["meta"] == null
            ? null
            : List<dynamic>.from(json["meta"].map((x) => x)),
        categories: json["categories"] == null
            ? null
            : List<num>.from(json["categories"].map((x) => x)),
        tags: json["tags"] == null
            ? null
            : List<num>.from(json["tags"].map((x) => x)),
        links: json["_links"] == null
            ? null
            : PostModelLinks.fromJson(json["_links"]),
        embedded: json["_embedded"] == null
            ? null
            : Embedded.fromJson(json["_embedded"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ? null : id,
        "date": date == null ? null : date.toIso8601String(),
        "date_gmt": dateGmt == null ? null : dateGmt.toIso8601String(),
        "guid": guid == null ? null : guid.toJson(),
        "modified": modified == null ? null : modified.toIso8601String(),
        "modified_gmt": modifiedGmt == null ? null : modifiedGmt
            .toIso8601String(),
        "slug": slug == null ? null : slug,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "link": link == null ? null : link,
        "title": title == null ? null : title.toJson(),
        "content": content == null ? null : content.toJson(),
        "excerpt": excerpt == null ? null : excerpt.toJson(),
        "author": author == null ? null : author,
        "featured_media": featuredMedia == null ? null : featuredMedia,
        "comment_status": commentStatus == null ? null : commentStatus,
        "ping_status": pingStatus == null ? null : pingStatus,
        "sticky": sticky == null ? null : sticky,
        "template": template == null ? null : template,
        "format": format == null ? null : format,
        "meta": meta == null ? null : List<dynamic>.from(meta.map((x) => x)),
        "categories": categories == null ? null : List<dynamic>.from(
            categories.map((x) => x)),
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "_links": links == null ? null : links.toJson(),
        "_embedded": embedded == null ? null : embedded.toJson(),
      };
}

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) =>
      Content(
        rendered: json["rendered"] == null ? null : json["rendered"],
        protected: json["protected"] == null ? null : json["protected"],
      );

  Map<String, dynamic> toJson() =>
      {
        "rendered": rendered == null ? null : rendered,
        "protected": protected == null ? null : protected,
      };
}

class Embedded {
  Embedded({
    this.author,
    this.wpTerm,
  });

  List<EmbeddedAuthor> author;
  List<List<EmbeddedWpTerm>> wpTerm;

  factory Embedded.fromJson(Map<String, dynamic> json) =>
      Embedded(
        author: json["author"] == null ? null : List<EmbeddedAuthor>.from(
            json["author"].map((x) => EmbeddedAuthor.fromJson(x))),
        wpTerm: json["wp:term"] == null ? null : List<
            List<EmbeddedWpTerm>>.from(
            json["wp:term"].map((x) => List<EmbeddedWpTerm>.from(
                x.map((x) => EmbeddedWpTerm.fromJson(x))))),
      );

  Map<String, dynamic> toJson() =>
      {
        "author": author == null ? null : List<dynamic>.from(
            author.map((x) => x.toJson())),
        "wp:term": wpTerm == null ? null : List<dynamic>.from(
            wpTerm.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class EmbeddedAuthor {
  EmbeddedAuthor({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.avatarUrls,
    this.links,
  });

  num id;
  String name;
  String url;
  String description;
  String link;
  String slug;
  Map<String, String> avatarUrls;
  AuthorLinks links;

  factory EmbeddedAuthor.fromJson(Map<String, dynamic> json) =>
      EmbeddedAuthor(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        slug: json["slug"] == null ? null : json["slug"],
        avatarUrls: json["avatar_urls"] == null ? null : Map.from(
            json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
        links: json["_links"] == null ? null : AuthorLinks.fromJson(
            json["_links"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "slug": slug == null ? null : slug,
        "avatar_urls": avatarUrls == null ? null : Map.from(avatarUrls).map((k,
            v) => MapEntry<String, dynamic>(k, v)),
        "_links": links == null ? null : links.toJson(),
      };
}

class AuthorLinks {
  AuthorLinks({
    this.self,
    this.collection,
  });

  List<About> self;
  List<About> collection;

  factory AuthorLinks.fromJson(Map<String, dynamic> json) =>
      AuthorLinks(
        self: json["self"] == null ? null : List<About>.from(
            json["self"].map((x) => About.fromJson(x))),
        collection: json["collection"] == null ? null : List<About>.from(
            json["collection"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "self": self == null ? null : List<dynamic>.from(
            self.map((x) => x.toJson())),
        "collection": collection == null ? null : List<dynamic>.from(
            collection.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) =>
      About(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() =>
      {
        "href": href == null ? null : href,
      };
}

class EmbeddedWpTerm {
  EmbeddedWpTerm({
    this.id,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
    this.links,
  });

  num id;
  String link;
  String name;
  String slug;
  String taxonomy;
  WpTermLinks links;

  factory EmbeddedWpTerm.fromJson(Map<String, dynamic> json) =>
      EmbeddedWpTerm(
        id: json["id"] == null ? null : json["id"],
        link: json["link"] == null ? null : json["link"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        taxonomy: json["taxonomy"] == null ? null : json["taxonomy"],
        links: json["_links"] == null ? null : WpTermLinks.fromJson(
            json["_links"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ? null : id,
        "link": link == null ? null : link,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "taxonomy": taxonomy == null ? null : taxonomy,
        "_links": links == null ? null : links.toJson(),
      };
}

class WpTermLinks {
  WpTermLinks({
    this.self,
    this.collection,
    this.about,
    this.wpPostType,
    this.curies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<About> wpPostType;
  List<Cury> curies;

  factory WpTermLinks.fromJson(Map<String, dynamic> json) =>
      WpTermLinks(
        self: json["self"] == null ? null : List<About>.from(
            json["self"].map((x) => About.fromJson(x))),
        collection: json["collection"] == null ? null : List<About>.from(
            json["collection"].map((x) => About.fromJson(x))),
        about: json["about"] == null ? null : List<About>.from(
            json["about"].map((x) => About.fromJson(x))),
        wpPostType: json["wp:post_type"] == null ? null : List<About>.from(
            json["wp:post_type"].map((x) => About.fromJson(x))),
        curies: json["curies"] == null ? null : List<Cury>.from(
            json["curies"].map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "self": self == null ? null : List<dynamic>.from(
            self.map((x) => x.toJson())),
        "collection": collection == null ? null : List<dynamic>.from(
            collection.map((x) => x.toJson())),
        "about": about == null ? null : List<dynamic>.from(
            about.map((x) => x.toJson())),
        "wp:post_type": wpPostType == null ? null : List<dynamic>.from(
            wpPostType.map((x) => x.toJson())),
        "curies": curies == null ? null : List<dynamic>.from(
            curies.map((x) => x.toJson())),
      };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  Name name;
  Href href;
  bool templated;

  factory Cury.fromJson(Map<String, dynamic> json) =>
      Cury(
        name: json["name"] == null ? null : nameValues.map[json["name"]],
        href: json["href"] == null ? null : hrefValues.map[json["href"]],
        templated: json["templated"] == null ? null : json["templated"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name == null ? null : nameValues.reverse[name],
        "href": href == null ? null : hrefValues.reverse[href],
        "templated": templated == null ? null : templated,
      };
}

enum Href { HTTPS_API_W_ORG_REL }

final hrefValues = EnumValues({
  "https://api.w.org/{rel}": Href.HTTPS_API_W_ORG_REL
});

enum Name { WP }

final nameValues = EnumValues({
  "wp": Name.WP
});

class Guid {
  Guid({
    this.rendered,
  });

  String rendered;

  factory Guid.fromJson(Map<String, dynamic> json) =>
      Guid(
        rendered: json["rendered"] == null ? null : json["rendered"],
      );

  Map<String, dynamic> toJson() =>
      {
        "rendered": rendered == null ? null : rendered,
      };
}

class PostModelLinks {
  PostModelLinks({
    this.self,
    this.collection,
    this.about,
    this.author,
    this.replies,
    this.versionHistory,
    this.predecessorVersion,
    this.wpAttachment,
    this.wpTerm,
    this.curies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<ReplyElement> author;
  List<ReplyElement> replies;
  List<VersionHistory> versionHistory;
  List<PredecessorVersion> predecessorVersion;
  List<About> wpAttachment;
  List<LinksWpTerm> wpTerm;
  List<Cury> curies;

  factory PostModelLinks.fromJson(Map<String, dynamic> json) =>
      PostModelLinks(
        self: json["self"] == null ? null : List<About>.from(
            json["self"].map((x) => About.fromJson(x))),
        collection: json["collection"] == null ? null : List<About>.from(
            json["collection"].map((x) => About.fromJson(x))),
        about: json["about"] == null ? null : List<About>.from(
            json["about"].map((x) => About.fromJson(x))),
        author: json["author"] == null ? null : List<ReplyElement>.from(
            json["author"].map((x) => ReplyElement.fromJson(x))),
        replies: json["replies"] == null ? null : List<ReplyElement>.from(
            json["replies"].map((x) => ReplyElement.fromJson(x))),
        versionHistory: json["version-history"] == null ? null : List<
            VersionHistory>.from(
            json["version-history"].map((x) => VersionHistory.fromJson(x))),
        predecessorVersion: json["predecessor-version"] == null ? null : List<
            PredecessorVersion>.from(json["predecessor-version"].map((x) =>
            PredecessorVersion.fromJson(x))),
        wpAttachment: json["wp:attachment"] == null ? null : List<About>.from(
            json["wp:attachment"].map((x) => About.fromJson(x))),
        wpTerm: json["wp:term"] == null ? null : List<LinksWpTerm>.from(
            json["wp:term"].map((x) => LinksWpTerm.fromJson(x))),
        curies: json["curies"] == null ? null : List<Cury>.from(
            json["curies"].map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "self": self == null ? null : List<dynamic>.from(
            self.map((x) => x.toJson())),
        "collection": collection == null ? null : List<dynamic>.from(
            collection.map((x) => x.toJson())),
        "about": about == null ? null : List<dynamic>.from(
            about.map((x) => x.toJson())),
        "author": author == null ? null : List<dynamic>.from(
            author.map((x) => x.toJson())),
        "replies": replies == null ? null : List<dynamic>.from(
            replies.map((x) => x.toJson())),
        "version-history": versionHistory == null ? null : List<dynamic>.from(
            versionHistory.map((x) => x.toJson())),
        "predecessor-version": predecessorVersion == null ? null : List<
            dynamic>.from(predecessorVersion.map((x) => x.toJson())),
        "wp:attachment": wpAttachment == null ? null : List<dynamic>.from(
            wpAttachment.map((x) => x.toJson())),
        "wp:term": wpTerm == null ? null : List<dynamic>.from(
            wpTerm.map((x) => x.toJson())),
        "curies": curies == null ? null : List<dynamic>.from(
            curies.map((x) => x.toJson())),
      };
}

class ReplyElement {
  ReplyElement({
    this.embeddable,
    this.href,
  });

  bool embeddable;
  String href;

  factory ReplyElement.fromJson(Map<String, dynamic> json) =>
      ReplyElement(
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() =>
      {
        "embeddable": embeddable == null ? null : embeddable,
        "href": href == null ? null : href,
      };
}

class PredecessorVersion {
  PredecessorVersion({
    this.id,
    this.href,
  });

  num id;
  String href;

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) =>
      PredecessorVersion(
        id: json["id"] == null ? null : json["id"],
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ? null : id,
        "href": href == null ? null : href,
      };
}

class VersionHistory {
  VersionHistory({
    this.count,
    this.href,
  });

  num count;
  String href;

  factory VersionHistory.fromJson(Map<String, dynamic> json) =>
      VersionHistory(
        count: json["count"] == null ? null : json["count"],
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() =>
      {
        "count": count == null ? null : count,
        "href": href == null ? null : href,
      };
}

class LinksWpTerm {
  LinksWpTerm({
    this.taxonomy,
    this.embeddable,
    this.href,
  });

  String taxonomy;
  bool embeddable;
  String href;

  factory LinksWpTerm.fromJson(Map<String, dynamic> json) =>
      LinksWpTerm(
        taxonomy: json["taxonomy"] == null ? null : json["taxonomy"],
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() =>
      {
        "taxonomy": taxonomy == null ? null : taxonomy,
        "embeddable": embeddable == null ? null : embeddable,
        "href": href == null ? null : href,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}