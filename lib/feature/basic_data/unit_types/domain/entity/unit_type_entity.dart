import 'dart:convert';

UnitTypesApiResponseEntity unitTypesApiResponseEntityFromJson(String str) =>
    UnitTypesApiResponseEntity.fromJson(json.decode(str));

String unitTypesApiResponseEntityToJson(UnitTypesApiResponseEntity data) =>
    json.encode(data.toJson());

class UnitTypesApiResponseEntity {
  UnitTypesApiResponseEntity({
    int? statusCode,
    String? message,
    List<UnitTypeEntity>? data,
  }) : _statusCode = statusCode,
       _message = message,
       _data = data;

  factory UnitTypesApiResponseEntity.fromJson(dynamic json) {
    return UnitTypesApiResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UnitTypeEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<UnitTypeEntity>? _data;

  int? get statusCode => _statusCode;

  String? get message => _message;

  List<UnitTypeEntity> get unitTypes => _data ?? const [];

  Map<String, dynamic> toJson() => {
    'statusCode': _statusCode,
    'message': _message,
    'data': _data?.map((e) => e.toJson()).toList(),
  };
}



class UnitTypeEntity {
  UnitTypeEntity({
    String? id,
    LocalizedName? name,
    IconFile? icon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _icon = icon,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory UnitTypeEntity.fromJson(dynamic json) => UnitTypeEntity(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    icon: json['icon'] != null ? IconFile.fromJson(json['icon']) : null,
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedName? _name;
  IconFile? _icon;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedName? get name => _name;

  IconFile? get icon => _icon;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'icon': _icon?.toJson(),
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };

  static Map<String, dynamic> buildCreateBody({
    required String nameAr,
    required String nameEn,
    IconFile? icon,
  }) {
    return {
      'name': {'ar': nameAr, 'en': nameEn},
      if (icon != null) 'icon': icon.toRequestJson(),
    };
  }

  static Map<String, dynamic> buildPatchBody({
    String? nameAr,
    String? nameEn,
    IconFile? icon,
  }) {
    final body = <String, dynamic>{};

    if (nameAr != null || nameEn != null) {
      body['name'] = {
        if (nameAr != null) 'ar': nameAr,
        if (nameEn != null) 'en': nameEn,
      };
    }

    if (icon != null) body['icon'] = icon.toRequestJson();

    return body;
  }
}

/// ======================= NAME =======================

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

class IconFile {
  IconFile({
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

  factory IconFile.fromJson(dynamic json) => IconFile(
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

  Map<String, dynamic> toRequestJson() => {
    'name': _name,
    'url': _url,
    if (_type != null) 'type': _type,
  };
}
