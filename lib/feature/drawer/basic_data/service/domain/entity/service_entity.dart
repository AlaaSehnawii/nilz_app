import 'dart:convert';

ServicesApiResponseEntity servicesApiResponseEntityFromJson(String str) =>
    ServicesApiResponseEntity.fromJson(json.decode(str));

String servicesApiResponseEntityToJson(ServicesApiResponseEntity data) =>
    json.encode(data.toJson());

/// ================= TOP LEVEL =================

class ServicesApiResponseEntity {
  ServicesApiResponseEntity({
    int? statusCode,
    String? message,
    List<ServiceEntity>? data,
  }) : _statusCode = statusCode,
       _message = message,
       _data = data;

  factory ServicesApiResponseEntity.fromJson(dynamic json) {
    return ServicesApiResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<ServiceEntity>? _data;

  int? get statusCode => _statusCode;

  String? get message => _message;

  List<ServiceEntity> get services => _data ?? const [];

  Map<String, dynamic> toJson() => {
    'statusCode': _statusCode,
    'message': _message,
    'data': _data?.map((e) => e.toJson()).toList(),
  };
}

class ServiceEntity {
  ServiceEntity({
    String? id,
    LocalizedText? title,
    FileInfo? image,
    CityRef? city,
    bool? status,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _title = title,
       _image = image,
       _city = city,
       _status = status,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory ServiceEntity.fromJson(dynamic json) => ServiceEntity(
    id: json['_id'],
    title: json['title'] != null ? LocalizedText.fromJson(json['title']) : null,
    image: json['image'] != null ? FileInfo.fromJson(json['image']) : null,
    city: json['city'] != null ? CityRef.fromJson(json['city']) : null,
    status: json['status'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedText? _title;
  FileInfo? _image;
  CityRef? _city;
  bool? _status;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedText? get title => _title;

  FileInfo? get image => _image;

  CityRef? get city => _city;

  bool? get status => _status;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'title': _title?.toJson(),
    'image': _image?.toJson(),
    'city': _city?.toJson(),
    'status': _status,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}


class LocalizedText {
  LocalizedText({String? en, String? ar}) : _en = en, _ar = ar;

  factory LocalizedText.fromJson(dynamic json) =>
      LocalizedText(en: json['en'], ar: json['ar']);

  String? _en;
  String? _ar;

  String? get en => _en;

  String? get ar => _ar;

  Map<String, dynamic> toJson() => {'en': _en, 'ar': _ar};
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
    id: json['_id'],
    name: json['name'],
    url: json['url'],
    type: json['type'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
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
    '_id': _id,
    'name': _name,
    'url': _url,
    'type': _type,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

class CityRef {
  CityRef({
    String? id,
    LocalizedText? name,
    String? createdBy,
    String? lastUpdatedBy,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _createdBy = createdBy,
       _lastUpdatedBy = lastUpdatedBy,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory CityRef.fromJson(dynamic json) => CityRef(
    id: json['_id'],
    name: json['name'] != null ? LocalizedText.fromJson(json['name']) : null,
    createdBy: json['createdBy'],
    lastUpdatedBy: json['lastUpdatedBy'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedText? _name;
  String? _createdBy;
  String? _lastUpdatedBy;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedText? get name => _name;

  String? get createdBy => _createdBy;

  String? get lastUpdatedBy => _lastUpdatedBy;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'createdBy': _createdBy,
    'lastUpdatedBy': _lastUpdatedBy,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}
