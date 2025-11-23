import 'dart:convert';

PlaceTypesApiResponseEntity placeTypesApiResponseEntityFromJson(String str) =>
    PlaceTypesApiResponseEntity.fromJson(json.decode(str));

String placeTypesApiResponseEntityToJson(PlaceTypesApiResponseEntity data) =>
    json.encode(data.toJson());

class PlaceTypesApiResponseEntity {
  PlaceTypesApiResponseEntity({
    int? statusCode,
    String? message,
    List<PlaceTypeEntity>? data,
  })  : _statusCode = statusCode,
        _message = message,
        _data = data;

  factory PlaceTypesApiResponseEntity.fromJson(dynamic json) {
    return PlaceTypesApiResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PlaceTypeEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<PlaceTypeEntity>? _data;

  int? get statusCode => _statusCode;
  String? get message => _message;
  List<PlaceTypeEntity> get PlaceTypes => _data ?? const [];

  Map<String, dynamic> toJson() => {
    if (_statusCode != null) 'statusCode': _statusCode,
    if (_message != null) 'message': _message,
    if (_data != null) 'data': _data!.map((e) => e.toJson()).toList(),
  };
}

/// ======================= ENTITY =======================
class PlaceTypeEntity {
  PlaceTypeEntity({
    String? id,
    LocalizedName? name,
    Icon? icon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? code, // <-- added
  })  : _id = id,
        _name = name,
        _icon = icon,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _code = code;

  factory PlaceTypeEntity.fromJson(dynamic json) => PlaceTypeEntity(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    icon: json['icon'] != null ? Icon.fromJson(json['icon']) : null,
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    code: json['code'], // <-- parse if present
  );

  String? _id;
  LocalizedName? _name;
  Icon? _icon;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _code; // <-- added

  String? get id => _id;
  LocalizedName? get name => _name;
  Icon? get icon => _icon;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get code => _code; // <-- added

  Map<String, dynamic> toJson() => {
    if (_id != null) '_id': _id,
    if (_name != null) 'name': _name!.toJson(),
    if (_icon != null) 'icon': _icon!.toJson(),
    if (_isDeleted != null) 'isDeleted': _isDeleted,
    if (_createdAt != null) 'createdAt': _createdAt,
    if (_updatedAt != null) 'updatedAt': _updatedAt,
    if (_code != null) 'code': _code, // <-- include if present
  };

  static Map<String, dynamic> buildCreateBody({
    required String nameAr,
    String? nameEn,
    Icon? icon,
    String? code, // optional to send if you use it
  }) {
    final body = <String, dynamic>{
      'name': {
        'ar': nameAr,
        if (nameEn != null) 'en': nameEn,
      },
    };
    if (icon != null) body['icon'] = icon.toRequestJson();
    if (code != null && code.isNotEmpty) body['code'] = code;
    return body;
  }

  static Map<String, dynamic> buildPatchBody({
    String? nameAr,
    String? nameEn,
    Icon? icon,
    String? code, // optional partial update
  }) {
    final body = <String, dynamic>{};

    if (nameAr != null || nameEn != null) {
      body['name'] = {
        if (nameAr != null) 'ar': nameAr,
        if (nameEn != null) 'en': nameEn,
      };
    }
    if (icon != null) body['icon'] = icon.toRequestJson();
    if (code != null) body['code'] = code;

    return body;
  }
}

class LocalizedName {
  LocalizedName({String? en, String? ar})
      : _en = en,
        _ar = ar;

  factory LocalizedName.fromJson(dynamic json) =>
      LocalizedName(en: json['en'], ar: json['ar']);

  String? _en;
  String? _ar;

  String? get en => _en;
  String? get ar => _ar;

  Map<String, dynamic> toJson() => {
    if (_en != null) 'en': _en,
    if (_ar != null) 'ar': _ar,
  };
}

/// NOTE: This class name can clash with Flutter's Icon.
/// Keep it here (domain layer) or rename to FileIcon/MediaFile if needed.
class Icon {
  Icon({
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

  factory Icon.fromJson(dynamic json) => Icon(
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
    if (_id != null) '_id': _id,
    if (_name != null) 'name': _name,
    if (_url != null) 'url': _url,
    if (_type != null) 'type': _type,
    if (_createdAt != null) 'createdAt': _createdAt,
    if (_updatedAt != null) 'updatedAt': _updatedAt,
  };

  Map<String, dynamic> toRequestJson() => {
    if (_name != null) 'name': _name,
    if (_url != null) 'url': _url,
    if (_type != null) 'type': _type,
  };

  factory Icon.fromUploadJson(Map<String, dynamic> json) => Icon(
    name: json['name'],
    url: json['url'],
    type: json['type'] ?? 'image',
  );
}
