class FilterNews {
  int? status;
  String? message;
  List<Data2>? data2;

  FilterNews({this.status, this.message, this.data2});

  FilterNews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data2'] != null) {
      data2 = <Data2>[];
      json['data2'].forEach((v) {
        data2!.add(new Data2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data2 != null) {
      data['data2'] = this.data2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data2 {
  int? id;
  String? title;
  String? subtitle;
  String? description;
  String? image;
  String? author;
  String? logo;
  String? name;
  int? categoryId;
  String? categoryName;
  String? createdAtAgo;
  String? updatedAtAgo;

  Data2(
      {this.id,
        this.title,
        this.subtitle,
        this.description,
        this.image,
        this.author,
        this.logo,
        this.name,
        this.categoryId,
        this.categoryName,
        this.createdAtAgo,
        this.updatedAtAgo});

  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    image = json['image'];
    author = json['author'];
    logo = json['logo'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
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
    data['category_name'] = this.categoryName;
    data['created_at_ago'] = this.createdAtAgo;
    data['updated_at_ago'] = this.updatedAtAgo;
    return data;
  }
}