import 'dart:convert';


PendingRequestResponseEntity pendingRequestResponseEntityFromJson(String str) =>
    PendingRequestResponseEntity.fromJson(json.decode(str));

class PendingRequestResponseEntity {
  PendingRequestResponseEntity({
    int? statusCode,
    String? message,
    List<ReservationData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  PendingRequestResponseEntity.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReservationData.fromJson(v));
      });
    }
  }

  int? _statusCode;
  String? _message;
  List<ReservationData>? _data;

  PendingRequestResponseEntity copyWith({
    int? statusCode,
    String? message,
    List<ReservationData>? data,
  }) =>
      PendingRequestResponseEntity(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  int? get statusCode => _statusCode;
  String? get message => _message;
  List<ReservationData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// Individual booking data item
class ReservationData {
  ReservationData({
    PlaceName? placeName,
    PlaceLogo? placeLogo,
    String? clientName,
    String? fromDate,
    String? toDate,
    String? createdAt,
    String? totalPrice,
    int? roomCount,
  }) {
    _placeName = placeName;
    _placeLogo = placeLogo;
    _clientName = clientName;
    _fromDate = fromDate;
    _toDate = toDate;
    _createdAt = createdAt;
    _totalPrice = totalPrice;
    _roomCount = roomCount;
  }

  ReservationData.fromJson(dynamic json) {
    _placeName = json['placeName'] != null
        ? PlaceName.fromJson(json['placeName'])
        : null;
    _placeLogo = json['placeLogo'] != null
        ? PlaceLogo.fromJson(json['placeLogo'])
        : null;
    _clientName = json['clientName'];
    _fromDate = json['fromDate'];
    _toDate = json['toDate'];
    _createdAt = json['createdAt'];
    _totalPrice = json['totalPrice'];
    _roomCount = json['roomCount'];
  }

  PlaceName? _placeName;
  PlaceLogo? _placeLogo;
  String? _clientName;
  String? _fromDate;
  String? _toDate;
  String? _createdAt;
  String? _totalPrice;
  int? _roomCount;

  ReservationData copyWith({
    PlaceName? placeName,
    PlaceLogo? placeLogo,
    String? clientName,
    String? fromDate,
    String? toDate,
    String? createdAt,
    String? totalPrice,
    int? roomCount,
  }) =>
      ReservationData(
        placeName: placeName ?? _placeName,
        placeLogo: placeLogo ?? _placeLogo,
        clientName: clientName ?? _clientName,
        fromDate: fromDate ?? _fromDate,
        toDate: toDate ?? _toDate,
        createdAt: createdAt ?? _createdAt,
        totalPrice: totalPrice ?? _totalPrice,
        roomCount: roomCount ?? _roomCount,
      );

  PlaceName? get placeName => _placeName;
  PlaceLogo? get placeLogo => _placeLogo;
  String? get clientName => _clientName;
  String? get fromDate => _fromDate;
  String? get toDate => _toDate;
  String? get createdAt => _createdAt;
  String? get totalPrice => _totalPrice;
  int? get roomCount => _roomCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_placeName != null) {
      map['placeName'] = _placeName?.toJson();
    }
    if (_placeLogo != null) {
      map['placeLogo'] = _placeLogo?.toJson();
    }
    map['clientName'] = _clientName;
    map['fromDate'] = _fromDate;
    map['toDate'] = _toDate;
    map['createdAt'] = _createdAt;
    map['totalPrice'] = _totalPrice;
    map['roomCount'] = _roomCount;
    return map;
  }
}

/// Place name in multiple languages
class PlaceName {
  PlaceName({
    String? ar,
    String? en,
  }) {
    _ar = ar;
    _en = en;
  }

  PlaceName.fromJson(dynamic json) {
    _ar = json['ar'];
    _en = json['en'];
  }

  String? _ar;
  String? _en;

  PlaceName copyWith({
    String? ar,
    String? en,
  }) =>
      PlaceName(
        ar: ar ?? _ar,
        en: en ?? _en,
      );

  String? get ar => _ar;
  String? get en => _en;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ar'] = _ar;
    map['en'] = _en;
    return map;
  }
}

/// Place logo/image information
class PlaceLogo {
  PlaceLogo({
    String? id,
    String? name,
    String? url,
    String? type,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _url = url;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  PlaceLogo.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _url = json['url'];
    _type = json['type'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _name;
  String? _url;
  String? _type;
  String? _createdAt;
  String? _updatedAt;

  PlaceLogo copyWith({
    String? id,
    String? name,
    String? url,
    String? type,
    String? createdAt,
    String? updatedAt,
  }) =>
      PlaceLogo(
        id: id ?? _id,
        name: name ?? _name,
        url: url ?? _url,
        type: type ?? _type,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;
  String? get name => _name;
  String? get url => _url;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['url'] = _url;
    map['type'] = _type;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}