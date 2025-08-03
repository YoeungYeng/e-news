class Category {
  int? status;
  String? message;
  List<Data>? data;

  Category({this.status, this.message, this.data});

  Category.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? subtitle;
  String? image;
  Null? description;
  String? status;
  String? updatedAt;
  String? updatedAtAgo;
  String? createdAt;
  String? createdAtAgo;

  Data(
      {this.id,
        this.name,
        this.subtitle,
        this.image,
        this.description,
        this.status,
        this.updatedAt,
        this.updatedAtAgo,
        this.createdAt,
        this.createdAtAgo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subtitle = json['subtitle'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    updatedAt = json['updated_at'];
    updatedAtAgo = json['updated_at_ago'];
    createdAt = json['created_at'];
    createdAtAgo = json['created_at_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['subtitle'] = this.subtitle;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['updated_at_ago'] = this.updatedAtAgo;
    data['created_at'] = this.createdAt;
    data['created_at_ago'] = this.createdAtAgo;
    return data;
  }
}