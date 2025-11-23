import 'dart:convert';

// ========== TOP-LEVEL PARSER ==========

PaymentApiResponseEntity paymentApiResponseEntityFromJson(String str) =>
    PaymentApiResponseEntity.fromJson(json.decode(str));

String paymentApiResponseEntityToJson(PaymentApiResponseEntity data) =>
    json.encode(data.toJson());

// ========== API RESPONSE ENTITY ==========

class PaymentApiResponseEntity {
  final int? statusCode;
  final String? message;
  final List<PaymentEntity> payments;

  PaymentApiResponseEntity({
    this.statusCode,
    this.message,
    required this.payments,
  });

  factory PaymentApiResponseEntity.fromJson(Map<String, dynamic> json) =>
      PaymentApiResponseEntity(
        statusCode: json["statusCode"],
        message: json["message"],
        payments: (json["data"] as List<dynamic>? ?? [])
            .map((e) => PaymentEntity.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": payments.map((x) => x.toJson()).toList(),
  };
}

// ========== PAYMENT ITEM ==========

class PaymentEntity {
  final String? id;
  final String? clientName;
  final String? description;
  final String? amount;
  final String? paymentDueDate;
  final PaymentStatusEntity? status;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;

  PaymentEntity({
    this.id,
    this.clientName,
    this.description,
    this.amount,
    this.paymentDueDate,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentEntity.fromJson(Map<String, dynamic> json) => PaymentEntity(
    id: json["_id"],
    clientName: json["clientName"],
    description: json["description"],
    amount: json["amount"],
    paymentDueDate: json["paymentDueDate"],
    status: json["status"] != null
        ? PaymentStatusEntity.fromJson(json["status"])
        : null,
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "clientName": clientName,
    "description": description,
    "amount": amount,
    "paymentDueDate": paymentDueDate,
    "status": status?.toJson(),
    "isDeleted": isDeleted,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

// ========== PAYMENT STATUS ==========

class PaymentStatusEntity {
  final String? id;
  final LocalizedName? name;
  final String? code;
  final String? createdAt;
  final String? updatedAt;

  PaymentStatusEntity({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentStatusEntity.fromJson(Map<String, dynamic> json) =>
      PaymentStatusEntity(
        id: json["_id"],
        name: json["name"] != null ? LocalizedName.fromJson(json["name"]) : null,
        code: json["code"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name?.toJson(),
    "code": code,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

// ========== LOCALIZED NAME (ar/en) ==========

class LocalizedName {
  final String? ar;
  final String? en;

  LocalizedName({this.ar, this.en});

  factory LocalizedName.fromJson(Map<String, dynamic> json) => LocalizedName(
    ar: json["ar"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "ar": ar,
    "en": en,
  };
}
