import 'dart:convert';

ReservationTypesApiResponseEntity reservationTypesApiResponseEntityFromJson(
  String str,
) => ReservationTypesApiResponseEntity.fromJson(json.decode(str));

String reservationTypesApiResponseEntityToJson(
  ReservationTypesApiResponseEntity data,
) => json.encode(data.toJson());

class ReservationTypesApiResponseEntity {
  ReservationTypesApiResponseEntity({
    int? statusCode,
    String? message,
    List<ReservationTypeEntity>? data,
  }) : _statusCode = statusCode,
       _message = message,
       _data = data;

  factory ReservationTypesApiResponseEntity.fromJson(dynamic json) {
    return ReservationTypesApiResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReservationTypeEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<ReservationTypeEntity>? _data;

  int? get statusCode => _statusCode;

  String? get message => _message;

  List<ReservationTypeEntity> get reservationTypes => _data ?? const [];

  Map<String, dynamic> toJson() => {
    'statusCode': _statusCode,
    'message': _message,
    'data': _data?.map((e) => e.toJson()).toList(),
  };
}

class ReservationTypeEntity {
  ReservationTypeEntity({
    String? id,
    LocalizedName? name,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory ReservationTypeEntity.fromJson(dynamic json) => ReservationTypeEntity(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedName? _name;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedName? get name => _name;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };

  /// Create request payload
  static Map<String, dynamic> buildCreateBody({
    required String nameAr,
    required String nameEn,
  }) {
    return {
      'name': {'ar': nameAr, 'en': nameEn},
    };
  }

  /// Patch request payload
  static Map<String, dynamic> buildPatchBody({
    String? nameAr,
    String? nameEn,
    bool? isDeleted,
  }) {
    final body = <String, dynamic>{};

    if (nameAr != null || nameEn != null) {
      body['name'] = {
        if (nameAr != null) 'ar': nameAr,
        if (nameEn != null) 'en': nameEn,
      };
    }

    if (isDeleted != null) body['isDeleted'] = isDeleted;

    return body;
  }
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
