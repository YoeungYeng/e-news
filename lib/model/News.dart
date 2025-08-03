class News {
  List<Data2>? data;
  String? message;

  News({this.data, this.message});

  News.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data2 {
  int? id;
  String? title;
  String? subtitle;
  String? description;
  String? author;
  String? image;
  String? logo;
  String? name;
  String? createdAt;
  String? updatedAt;

  Data2(
      {this.id,
        this.title,
        this.subtitle,
        this.description,
        this.author,
        this.image,
        this.logo,
        this.name,
        this.createdAt,
        this.updatedAt});

  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    author = json['author'];
    image = json['image'];
    logo = json['logo'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['description'] = this.description;
    data['author'] = this.author;
    data['image'] = this.image;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}