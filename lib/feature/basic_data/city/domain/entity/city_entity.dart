import 'dart:convert';

CitiesApiResponseEntity citiesApiResponseEntityFromJson(String str) =>
    CitiesApiResponseEntity.fromJson(json.decode(str));

String citiesApiResponseEntityToJson(CitiesApiResponseEntity data) =>
    json.encode(data.toJson());

class CitiesApiResponseEntity {
  CitiesApiResponseEntity({
    int? statusCode,
    String? message,
    List<CityEntity>? data,
  }) : _statusCode = statusCode,
       _message = message,
       _data = data;

  factory CitiesApiResponseEntity.fromJson(dynamic json) {
    return CitiesApiResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CityEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<CityEntity>? _data;

  int? get statusCode => _statusCode;

  String? get message => _message;

  List<CityEntity> get cities => _data ?? const [];

  Map<String, dynamic> toJson() => {
    'statusCode': _statusCode,
    'message': _message,
    'data': _data?.map((e) => e.toJson()).toList(),
  };
}

class CityEntity {
  CityEntity({
    String? id,
    LocalizedName? name,
    FileInfo? image,
    UserInfo? createdBy,
    UserInfo? lastUpdatedBy,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _image = image,
       _createdBy = createdBy,
       _lastUpdatedBy = lastUpdatedBy,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory CityEntity.fromJson(dynamic json) => CityEntity(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    image: json['image'] != null ? FileInfo.fromJson(json['image']) : null,
    createdBy: json['createdBy'] != null
        ? UserInfo.fromJson(json['createdBy'])
        : null,
    lastUpdatedBy: json['lastUpdatedBy'] != null
        ? UserInfo.fromJson(json['lastUpdatedBy'])
        : null,
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedName? _name;
  FileInfo? _image;
  UserInfo? _createdBy;
  UserInfo? _lastUpdatedBy;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedName? get name => _name;

  FileInfo? get image => _image;

  UserInfo? get createdBy => _createdBy;

  UserInfo? get lastUpdatedBy => _lastUpdatedBy;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'image': _image?.toJson(),
    'createdBy': _createdBy?.toJson(),
    'lastUpdatedBy': _lastUpdatedBy?.toJson(),
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

class LocalizedName {
  LocalizedName({String? en, String? ar}) : _en = en, _ar = ar;

  factory LocalizedName.fromJson(dynamic json) =>
      LocalizedName(en: json['en'], ar: json['ar']);

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
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _url = url,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory FileInfo.fromJson(dynamic json) => FileInfo(
    id: json['_id'],
    name: json['name'],
    url: json['url'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  String? _name;
  String? _url;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  String? get name => _name;

  String? get url => _url;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name,
    'url': _url,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

class UserInfo {
  UserInfo({
    String? id,
    String? email,
    String? fullName,
    bool? sales,
    num? commission,
    num? reservationNumber,
    bool? isDeleted,
    String? lang,
    String? createdAt,
    String? updatedAt,
    String? lastLoginAt,
    String? fcmToken,
  }) : _id = id,
       _email = email,
       _fullName = fullName,
       _sales = sales,
       _commission = commission,
       _reservationNumber = reservationNumber,
       _isDeleted = isDeleted,
       _lang = lang,
       _createdAt = createdAt,
       _updatedAt = updatedAt,
       _lastLoginAt = lastLoginAt,
       _fcmToken = fcmToken;

  factory UserInfo.fromJson(dynamic json) => UserInfo(
    id: json['_id'],
    email: json['email'],
    fullName: json['fullName'],
    sales: json['sales'],
    commission: json['commission'],
    reservationNumber: json['reservationNumber'],
    isDeleted: json['isDeleted'],
    lang: json['lang'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    lastLoginAt: json['lastLoginAt'],
    fcmToken: json['fcmToken'],
  );

  String? _id;
  String? _email;
  String? _fullName;
  bool? _sales;
  num? _commission;
  num? _reservationNumber;
  bool? _isDeleted;
  String? _lang;
  String? _createdAt;
  String? _updatedAt;
  String? _lastLoginAt;
  String? _fcmToken;

  String? get id => _id;

  String? get email => _email;

  String? get fullName => _fullName;

  bool? get sales => _sales;

  num? get commission => _commission;

  num? get reservationNumber => _reservationNumber;

  bool? get isDeleted => _isDeleted;

  String? get lang => _lang;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get lastLoginAt => _lastLoginAt;

  String? get fcmToken => _fcmToken;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'email': _email,
    'fullName': _fullName,
    'sales': _sales,
    'commission': _commission,
    'reservationNumber': _reservationNumber,
    'isDeleted': _isDeleted,
    'lang': _lang,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'lastLoginAt': _lastLoginAt,
    'fcmToken': _fcmToken,
  };
}
