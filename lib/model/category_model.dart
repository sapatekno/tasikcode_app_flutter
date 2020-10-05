import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
    this.parent,
    this.meta,
    this.links,
  });

  num id;
  num count;
  String description;
  String link;
  String name;
  String slug;
  String taxonomy;
  num parent;
  List<dynamic> meta;
  Links links;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] == null ? null : json["id"],
        count: json["count"] == null ? null : json["count"],
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        taxonomy: json["taxonomy"] == null ? null : json["taxonomy"],
        parent: json["parent"] == null ? null : json["parent"],
        meta: json["meta"] == null
            ? null
            : List<dynamic>.from(json["meta"].map((x) => x)),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "count": count == null ? null : count,
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "taxonomy": taxonomy == null ? null : taxonomy,
        "parent": parent == null ? null : parent,
        "meta": meta == null ? null : List<dynamic>.from(meta.map((x) => x)),
        "_links": links == null ? null : links.toJson(),
      };
}

class Links {
  Links({
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

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection: json["collection"] == null
            ? null
            : List<About>.from(
                json["collection"].map((x) => About.fromJson(x))),
        about: json["about"] == null
            ? null
            : List<About>.from(json["about"].map((x) => About.fromJson(x))),
        wpPostType: json["wp:post_type"] == null
            ? null
            : List<About>.from(
                json["wp:post_type"].map((x) => About.fromJson(x))),
        curies: json["curies"] == null
            ? null
            : List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": about == null
            ? null
            : List<dynamic>.from(about.map((x) => x.toJson())),
        "wp:post_type": wpPostType == null
            ? null
            : List<dynamic>.from(wpPostType.map((x) => x.toJson())),
        "curies": curies == null
            ? null
            : List<dynamic>.from(curies.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href == null ? null : href,
      };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  String name;
  String href;
  bool templated;

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: json["name"] == null ? null : json["name"],
        href: json["href"] == null ? null : json["href"],
        templated: json["templated"] == null ? null : json["templated"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "href": href == null ? null : href,
        "templated": templated == null ? null : templated,
      };
}
