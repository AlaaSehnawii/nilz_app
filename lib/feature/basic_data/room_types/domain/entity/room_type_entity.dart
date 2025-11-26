import 'dart:convert';

RoomTypesApiResponseEntity roomTypesApiResponseEntityFromJson(String str) =>
    RoomTypesApiResponseEntity.fromJson(json.decode(str));

String roomTypesApiResponseEntityToJson(RoomTypesApiResponseEntity data) =>
    json.encode(data.toJson());

class RoomTypesApiResponseEntity {
  RoomTypesApiResponseEntity({
    int? statusCode,
    String? message,
    List<RoomTypeEntity>? data,
  })  : _statusCode = statusCode,
        _message = message,
        _data = data;

  factory RoomTypesApiResponseEntity.fromJson(dynamic json) {
    return RoomTypesApiResponseEntity(
      statusCode: json["statusCode"],
      message: json["message"],
      data: (json["data"] as List<dynamic>?)
          ?.map((e) => RoomTypeEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<RoomTypeEntity>? _data;

  int? get statusCode => _statusCode;
  String? get message => _message;
  List<RoomTypeEntity> get roomTypes => _data ?? const [];

  Map<String, dynamic> toJson() => {
    "statusCode": _statusCode,
    "message": _message,
    "data": _data?.map((e) => e.toJson()).toList(),
  };
}

/// ======================= ENTITY =======================

class RoomTypeEntity {
  RoomTypeEntity({
    String? id,
    LocalizedName? name,
    MediaIcon? icon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  })  : _id = id,
        _name = name,
        _icon = icon,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory RoomTypeEntity.fromJson(dynamic json) => RoomTypeEntity(
    id: json["_id"],
    name: json["name"] != null ? LocalizedName.fromJson(json["name"]) : null,
    icon: json["icon"] != null ? MediaIcon.fromJson(json["icon"]) : null,
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  String? _id;
  LocalizedName? _name;
  MediaIcon? _icon;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  LocalizedName? get name => _name;
  MediaIcon? get icon => _icon;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    "_id": _id,
    "name": _name?.toJson(),
    "icon": _icon?.toJson(),
    "isDeleted": _isDeleted,
    "createdAt": _createdAt,
    "updatedAt": _updatedAt,
  };

  /// ================== BODY BUILDERS ==================

  static Map<String, dynamic> buildCreateBody({
    required String nameAr,
    String? nameEn,
    MediaIcon? icon,
  }) {
    return {
      "name": {
        "ar": nameAr,
        if (nameEn != null) "en": nameEn,
      },
      if (icon != null) "icon": icon.toRequestJson(), // name + base64
    };
  }

  static Map<String, dynamic> buildPatchBody({
    String? nameAr,
    String? nameEn,
    MediaIcon? icon,
  }) {
    final body = <String, dynamic>{};

    if (nameAr != null || nameEn != null) {
      body["name"] = {
        if (nameAr != null) "ar": nameAr,
        if (nameEn != null) "en": nameEn,
      };
    }

    if (icon != null) {
      body["icon"] = icon.toRequestJson();
    }

    return body;
  }
}

/// ======================= LOCALIZED NAME =======================
class LocalizedName {
  LocalizedName({String? en, String? ar})
      : _en = en,
        _ar = ar;

  factory LocalizedName.fromJson(dynamic json) =>
      LocalizedName(en: json["en"], ar: json["ar"]);

  String? _en;
  String? _ar;

  String? get en => _en;
  String? get ar => _ar;

  Map<String, dynamic> toJson() => {"en": _en, "ar": _ar};
}

/// ======================= ICON MODEL =======================
class MediaIcon {
  MediaIcon({
    String? id,
    String? name,
    String? url,
    String? type,
    String? createdAt,
    String? updatedAt,
  })  : _id = id,
        _name = name,
        _url = url,
        _type = type,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory MediaIcon.fromJson(Map<String, dynamic> json) => MediaIcon(
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

  /// for API
  Map<String, dynamic> toRequestJson() => {
    "name": _name,
    if (_url != null) "url": _url,
    if (_type != null) "type": _type,
  };

  /// for upload response
  factory MediaIcon.fromUploadJson(Map<String, dynamic> json) => MediaIcon(
    name: json["name"],
    url: json["url"],
    type: json["type"] ?? "image",
  );
}
