import 'dart:convert';

import '../../../../basic_data/unit_types/domain/entity/unit_type_entity.dart';

GiftApiResponseEntity giftApiResponseEntityFromJson(String str) =>
    GiftApiResponseEntity.fromJson(json.decode(str));

String giftApiResponseEntityToJson(GiftApiResponseEntity data) =>
    json.encode(data.toJson());

class GiftApiResponseEntity {
  GiftApiResponseEntity({
    int? statusCode,
    String? message,
    List<GiftEntity>? data,
  })  : _statusCode = statusCode,
        _message = message,
        _data = data;

  factory GiftApiResponseEntity.fromJson(dynamic json) {
    return GiftApiResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GiftEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<GiftEntity>? _data;

  int? get statusCode => _statusCode;
  String? get message => _message;
  List<GiftEntity> get gifts => _data ?? const [];

  Map<String, dynamic> toJson() => {
    'statusCode': _statusCode,
    'message': _message,
    'data': _data?.map((e) => e.toJson()).toList(),
  };
}

class GiftEntity {
  GiftEntity({
    String? id,
    LocalizedName? name,
    LocalizedName? description,
    IconFile? image,
    LocalizedName? giftType,
    int? percentageDiscount,
    int? totalDiscount,
    bool? status,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  })  : _id = id,
        _name = name,
        _description = description,
        _image = image,
        _giftType = giftType,
        _percentageDiscount = percentageDiscount,
        _totalDiscount = totalDiscount,
        _status = status,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory GiftEntity.fromJson(dynamic json) => GiftEntity(
    id: json['_id'],
    name: json['name'] != null
        ? LocalizedName.fromJson(json['name'])
        : null,
    description: json['description'] != null
        ? LocalizedName.fromJson(json['description'])
        : null,
    image: json['image'] != null
        ? IconFile.fromJson(json['image'])
        : null,
    giftType: json['giftType'] != null
        ? LocalizedName.fromJson(json['giftType'])
        : null,
    percentageDiscount: json['percentageDiscount'],
    totalDiscount: json['totalDiscount'],
    status: json['status'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedName? _name;
  LocalizedName? _description;
  IconFile? _image;
  LocalizedName? _giftType;
  int? _percentageDiscount;
  int? _totalDiscount;
  bool? _status;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  LocalizedName? get name => _name;
  LocalizedName? get description => _description;
  IconFile? get image => _image;
  LocalizedName? get giftType => _giftType;
  int? get percentageDiscount => _percentageDiscount;
  int? get totalDiscount => _totalDiscount;
  bool? get status => _status;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'description': _description?.toJson(),
    'image': _image?.toJson(),
    'giftType': _giftType?.toJson(),
    'percentageDiscount': _percentageDiscount,
    'totalDiscount': _totalDiscount,
    'status': _status,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };

  /// Create body for POST /gifts
  static Map<String, dynamic> buildCreateBody({
    required String nameAr,
    required String nameEn,
    required String descriptionAr,
    required String descriptionEn,
    required String giftTypeAr,
    required String giftTypeEn,
    IconFile? image,
    int? percentageDiscount,
    int? totalDiscount,
    bool? status,
  }) {
    return {
      'name': {'ar': nameAr, 'en': nameEn},
      'description': {'ar': descriptionAr, 'en': descriptionEn},
      'giftType': {'ar': giftTypeAr, 'en': giftTypeEn},
      if (image != null) 'image': image.toRequestJson(),
      if (percentageDiscount != null) 'percentageDiscount': percentageDiscount,
      if (totalDiscount != null) 'totalDiscount': totalDiscount,
      if (status != null) 'status': status,
    };
  }

  /// Patch body for PATCH /gifts/:id
  static Map<String, dynamic> buildPatchBody({
    String? nameAr,
    String? nameEn,
    String? descriptionAr,
    String? descriptionEn,
    String? giftTypeAr,
    String? giftTypeEn,
    IconFile? image,
    int? percentageDiscount,
    int? totalDiscount,
    bool? status,
  }) {
    final body = <String, dynamic>{};

    if (nameAr != null || nameEn != null) {
      body['name'] = {
        if (nameAr != null) 'ar': nameAr,
        if (nameEn != null) 'en': nameEn,
      };
    }

    if (descriptionAr != null || descriptionEn != null) {
      body['description'] = {
        if (descriptionAr != null) 'ar': descriptionAr,
        if (descriptionEn != null) 'en': descriptionEn,
      };
    }

    if (giftTypeAr != null || giftTypeEn != null) {
      body['giftType'] = {
        if (giftTypeAr != null) 'ar': giftTypeAr,
        if (giftTypeEn != null) 'en': giftTypeEn,
      };
    }

    if (image != null) {
      body['image'] = image.toRequestJson();
    }

    if (percentageDiscount != null) {
      body['percentageDiscount'] = percentageDiscount;
    }

    if (totalDiscount != null) {
      body['totalDiscount'] = totalDiscount;
    }

    if (status != null) {
      body['status'] = status;
    }

    return body;
  }
}
