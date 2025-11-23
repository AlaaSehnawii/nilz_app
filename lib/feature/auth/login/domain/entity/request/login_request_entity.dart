import 'dart:convert';
/// email : "admins"
/// password : "admin"

LoginRequestEntity loginRequestEntityFromJson(String str) => LoginRequestEntity.fromJson(json.decode(str));
String loginRequestEntityToJson(LoginRequestEntity data) => json.encode(data.toJson());
class LoginRequestEntity {
  LoginRequestEntity({
      String? email, 
      String? password,}){
    _email = email;
    _password = password;
}

  set email(String? value) {
    _email = value;
  }

  LoginRequestEntity.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
  }
  String? _email;
  String? _password;
LoginRequestEntity copyWith({  String? email,
  String? password,
}) => LoginRequestEntity(  email: email ?? _email,
  password: password ?? _password,
);
  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }

  set password(String? value) {
    _password = value;
  }
}