class LastNews {
  int? status;
  String? message;
  List<Data>? data;

  LastNews({this.status, this.message, this.data});

  LastNews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? subtitle;
  String? description;
  String? image;
  String? author;
  String? logo;
  String? name;
  int? categoryId;
  String? createdAtAgo;
  String? updatedAtAgo;

  Data(
      {this.id,
        this.title,
        this.subtitle,
        this.description,
        this.image,
        this.author,
        this.logo,
        this.name,
        this.categoryId,
        this.createdAtAgo,
        this.updatedAtAgo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    image = json['image'];
    author = json['author'];
    logo = json['logo'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAtAgo = json['created_at_ago'];
    updatedAtAgo = json['updated_at_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['description'] = this.description;
    data['image'] = this.image;
    data['author'] = this.author;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['created_at_ago'] = this.createdAtAgo;
    data['updated_at_ago'] = this.updatedAtAgo;
    return data;
  }
}