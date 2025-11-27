import 'dart:convert';

PostCategoryResponseEntity postCategoryResponseEntityFromJson(String str) =>
    PostCategoryResponseEntity.fromJson(json.decode(str));

String postCategoryResponseEntityToJson(PostCategoryResponseEntity data) =>
    json.encode(data.toJson());

class PostCategoryResponseEntity {
  PostCategoryResponseEntity({
    int? statusCode,
    String? message,
    List<CategoryEntity>? data,
  }) : _statusCode = statusCode,
       _message = message,
       _data = data;

  factory PostCategoryResponseEntity.fromJson(dynamic json) {
    return PostCategoryResponseEntity(
      statusCode: json["statusCode"],
      message: json["message"],
      data: (json["data"] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<CategoryEntity>? _data;

  int? get statusCode => _statusCode;

  String? get message => _message;

  List<CategoryEntity> get categories => _data ?? const [];

  Map<String, dynamic> toJson() => {
    "statusCode": _statusCode,
    "message": _message,
    "data": _data?.map((e) => e.toJson()).toList(),
  };
}

class CategoryEntity {
  CategoryEntity({
    String? id,
    LocalizedName? name,
    FileInfo? image,
    bool? status,
    bool? isPlace,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _image = image,
       _status = status,
       _isPlace = isPlace,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory CategoryEntity.fromJson(dynamic json) => CategoryEntity(
    id: json["_id"],
    name: json["name"] != null ? LocalizedName.fromJson(json["name"]) : null,
    image: json["image"] != null ? FileInfo.fromJson(json["image"]) : null,
    status: json["status"],
    isPlace: json["isPlace"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  String? _id;
  LocalizedName? _name;
  FileInfo? _image;
  bool? _status;
  bool? _isPlace;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedName? get name => _name;

  FileInfo? get image => _image;

  bool? get status => _status;

  bool? get isPlace => _isPlace;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    "_id": _id,
    "name": _name?.toJson(),
    "image": _image?.toJson(),
    "status": _status,
    "isPlace": _isPlace,
    "isDeleted": _isDeleted,
    "createdAt": _createdAt,
    "updatedAt": _updatedAt,
  };
}

class LocalizedName {
  LocalizedName({String? en, String? ar}) : _en = en, _ar = ar;

  factory LocalizedName.fromJson(dynamic json) =>
      LocalizedName(en: json["en"], ar: json["ar"]);

  String? _en;
  String? _ar;

  String? get en => _en;

  String? get ar => _ar;

  Map<String, dynamic> toJson() => {"en": _en, "ar": _ar};
}

class FileInfo {
  FileInfo({
    String? id,
    String? name,
    String? url,
    String? type,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _url = url,
       _type = type,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory FileInfo.fromJson(dynamic json) => FileInfo(
    id: json["_id"],
    name: json["name"],
    url: json["url"],
    type: json["type"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  String? _id;
  String? _name;
  String? _url;
  String? _type;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  String? get name => _name;

  String? get url => _url;

  String? get type => _type;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    "_id": _id,
    "name": _name,
    "url": _url,
    "type": _type,
    "createdAt": _createdAt,
    "updatedAt": _updatedAt,
  };
}
