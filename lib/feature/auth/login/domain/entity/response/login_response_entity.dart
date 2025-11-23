// login_response_entity.dart
import 'dart:convert';

LoginApiResponseEntity loginApiResponseEntityFromJson(String str) =>
    LoginApiResponseEntity.fromJson(json.decode(str));

String loginApiResponseEntityToJson(LoginApiResponseEntity data) =>
    json.encode(data.toJson());

class LoginApiResponseEntity {
  LoginApiResponseEntity({
    String? accessToken,
    LoginResponseEntity? user,
    List<String>? permissions,
  })  : _accessToken = accessToken,
        _user = user,
        _permissions = permissions;

  factory LoginApiResponseEntity.fromJson(dynamic json) {
    if (json is Map && json['data'] is Map) {
      json = json['data'];
    }
    return LoginApiResponseEntity(
      accessToken: json['accessToken'] as String?,
      user: json['user'] != null
          ? LoginResponseEntity.fromJson(json['user'])
          : null,
      permissions: (json['permissions'] is List)
          ? (json['permissions'] as List).whereType<String>().toList()
          : null,
    );
  }

  String? _accessToken;
  LoginResponseEntity? _user;
  List<String>? _permissions;

  String? get accessToken => _accessToken;
  LoginResponseEntity? get user => _user;
  List<String>? get permissions => _permissions;

  Map<String, dynamic> toJson() => {
        'accessToken': _accessToken,
        'user': _user?.toJson(),
        'permissions': _permissions,
      };
}

class LoginResponseEntity {
  LoginResponseEntity({
    String? id,
    String? email,
    String? fullName,
    bool? sales,
    int? commission,
    int? reservationNumber,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? lastLoginAt,
    String? fcmToken,
    String? lang,
  })  : _id = id,
        _email = email,
        _fullName = fullName,
        _sales = sales,
        _commission = commission,
        _reservationNumber = reservationNumber,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _lastLoginAt = lastLoginAt,
        _fcmToken = fcmToken,
        _lang = lang;

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      LoginResponseEntity(
        id: json['_id'] as String?,
        email: json['email'] as String?,
        fullName: json['fullName'] as String?,
        sales: json['sales'] as bool?,
        commission: (json['commission'] is num)
            ? (json['commission'] as num).toInt()
            : null,
        reservationNumber: (json['reservationNumber'] is num)
            ? (json['reservationNumber'] as num).toInt()
            : null,
        isDeleted: json['isDeleted'] as bool?,
        lang: json['lang'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        lastLoginAt: json['lastLoginAt'] as String?,
        fcmToken: json['fcmToken'] as String?,
      );

  String? _id;
  String? _email;
  String? _fullName;
  bool? _sales;
  int? _commission;
  int? _reservationNumber;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _lastLoginAt;
  String? _fcmToken;
  String? _lang;

  String? get id => _id;
  String? get email => _email;
  String? get fullName => _fullName;
  bool? get sales => _sales;
  int? get commission => _commission;
  int? get reservationNumber => _reservationNumber;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get lastLoginAt => _lastLoginAt;
  String? get fcmToken => _fcmToken;
  String? get lang => _lang;

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
