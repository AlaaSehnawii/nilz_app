import 'dart:convert';

PostsApiResponseEntity postsApiResponseEntityFromJson(String str) =>
    PostsApiResponseEntity.fromJson(json.decode(str));

String postsApiResponseEntityToJson(PostsApiResponseEntity data) =>
    json.encode(data.toJson());

class PostsApiResponseEntity {
  PostsApiResponseEntity({
    int? statusCode,
    String? message,
    PostsDataEntity? data,
  }) : _statusCode = statusCode,
       _message = message,
       _data = data;

  factory PostsApiResponseEntity.fromJson(dynamic json) {
    return PostsApiResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? PostsDataEntity.fromJson(json['data'])
          : null,
    );
  }

  int? _statusCode;
  String? _message;
  PostsDataEntity? _data;

  int? get statusCode => _statusCode;
  String? get message => _message;
  PostsDataEntity? get data => _data;

  List<PostEntity> get results => _data?.results ?? const [];
  PostIconsEntity? get postIcons => _data?.postIcons;

  Map<String, dynamic> toJson() => {
    'statusCode': _statusCode,
    'message': _message,
    'data': _data?.toJson(),
  };
}

/// ======================= DATA WRAPPER =======================

class PostsDataEntity {
  PostsDataEntity({List<PostEntity>? results, PostIconsEntity? postIcons})
    : _results = results,
      _postIcons = postIcons;

  factory PostsDataEntity.fromJson(dynamic json) {
    return PostsDataEntity(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => PostEntity.fromJson(e))
          .toList(),
      postIcons: json['postIcons'] != null
          ? PostIconsEntity.fromJson(json['postIcons'])
          : null,
    );
  }

  List<PostEntity>? _results;
  PostIconsEntity? _postIcons;

  List<PostEntity> get results => _results ?? const [];
  PostIconsEntity? get postIcons => _postIcons;

  Map<String, dynamic> toJson() => {
    'results': _results?.map((e) => e.toJson()).toList(),
    'postIcons': _postIcons?.toJson(),
  };
}

/// ======================= POST =======================

class PostEntity {
  PostEntity({
    String? id,
    bool? status,
    LocalizedText? title,
    LocalizedText? description,
    MediaFileEntity? image,
    List<MediaFileEntity>? gallery,
    PostCategoryEntity? postCategory,
    String? date,
    LinkEntity? xLink,
    LinkEntity? instaLink,
    LinkEntity? mailLink,
    LinkEntity? phoneLink,
    UserSummaryEntity? createdBy,
    UserSummaryEntity? lastUpdatedBy,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _status = status,
       _title = title,
       _description = description,
       _image = image,
       _gallery = gallery,
       _postCategory = postCategory,
       _date = date,
       _xLink = xLink,
       _instaLink = instaLink,
       _mailLink = mailLink,
       _phoneLink = phoneLink,
       _createdBy = createdBy,
       _lastUpdatedBy = lastUpdatedBy,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory PostEntity.fromJson(dynamic json) => PostEntity(
    id: json['_id'],
    status: json['status'],
    title: json['title'] != null ? LocalizedText.fromJson(json['title']) : null,
    description: json['description'] != null
        ? LocalizedText.fromJson(json['description'])
        : null,
    image: json['image'] != null
        ? MediaFileEntity.fromJson(json['image'])
        : null,
    gallery: (json['gallery'] as List<dynamic>?)
        ?.map((e) => MediaFileEntity.fromJson(e))
        .toList(),
    postCategory: json['postCategory'] != null
        ? PostCategoryEntity.fromJson(json['postCategory'])
        : null,
    date: json['date'],
    xLink: json['xLink'] != null ? LinkEntity.fromJson(json['xLink']) : null,
    instaLink: json['instaLink'] != null
        ? LinkEntity.fromJson(json['instaLink'])
        : null,
    mailLink: json['mailLink'] != null
        ? LinkEntity.fromJson(json['mailLink'])
        : null,
    phoneLink: json['phoneLink'] != null
        ? LinkEntity.fromJson(json['phoneLink'])
        : null,
    createdBy: json['createdBy'] != null
        ? UserSummaryEntity.fromJson(json['createdBy'])
        : null,
    lastUpdatedBy: json['lastUpdatedBy'] != null
        ? UserSummaryEntity.fromJson(json['lastUpdatedBy'])
        : null,
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  bool? _status;
  LocalizedText? _title;
  LocalizedText? _description;
  MediaFileEntity? _image;
  List<MediaFileEntity>? _gallery;
  PostCategoryEntity? _postCategory;
  String? _date;
  LinkEntity? _xLink;
  LinkEntity? _instaLink;
  LinkEntity? _mailLink;
  LinkEntity? _phoneLink;
  UserSummaryEntity? _createdBy;
  UserSummaryEntity? _lastUpdatedBy;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  bool? get status => _status;
  LocalizedText? get title => _title;
  LocalizedText? get description => _description;
  MediaFileEntity? get image => _image;
  List<MediaFileEntity> get gallery => _gallery ?? const [];
  PostCategoryEntity? get postCategory => _postCategory;
  String? get date => _date;
  LinkEntity? get xLink => _xLink;
  LinkEntity? get instaLink => _instaLink;
  LinkEntity? get mailLink => _mailLink;
  LinkEntity? get phoneLink => _phoneLink;
  UserSummaryEntity? get createdBy => _createdBy;
  UserSummaryEntity? get lastUpdatedBy => _lastUpdatedBy;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'status': _status,
    'title': _title?.toJson(),
    'description': _description?.toJson(),
    'image': _image?.toJson(),
    'gallery': _gallery?.map((e) => e.toJson()).toList(),
    'postCategory': _postCategory?.toJson(),
    'date': _date,
    'xLink': _xLink?.toJson(),
    'instaLink': _instaLink?.toJson(),
    'mailLink': _mailLink?.toJson(),
    'phoneLink': _phoneLink?.toJson(),
    'createdBy': _createdBy?.toJson(),
    'lastUpdatedBy': _lastUpdatedBy?.toJson(),
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

/// ======================= LOCALIZED TEXT =======================

class LocalizedText {
  LocalizedText({String? en, String? ar}) : _en = en, _ar = ar;

  factory LocalizedText.fromJson(dynamic json) =>
      LocalizedText(en: json['en'], ar: json['ar']);

  String? _en;
  String? _ar;

  String? get en => _en;
  String? get ar => _ar;

  Map<String, dynamic> toJson() => {'en': _en, 'ar': _ar};
}

/// ======================= MEDIA FILE (IMAGE / GALLERY) =======================

class MediaFileEntity {
  MediaFileEntity({
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

  factory MediaFileEntity.fromJson(dynamic json) => MediaFileEntity(
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
}

/// ======================= POST CATEGORY =======================

class PostCategoryEntity {
  PostCategoryEntity({
    String? id,
    LocalizedText? name,
    String? image,
    bool? status,
    bool? isPlace,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _image = image,
       _status = status,
       _isPlace = isPlace,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory PostCategoryEntity.fromJson(dynamic json) => PostCategoryEntity(
    id: json['_id'],
    name: json['name'] != null ? LocalizedText.fromJson(json['name']) : null,
    image: json['image'],
    status: json['status'],
    isPlace: json['isPlace'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedText? _name;
  String? _image;
  bool? _status;
  bool? _isPlace;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  LocalizedText? get name => _name;
  String? get image => _image;
  bool? get status => _status;
  bool? get isPlace => _isPlace;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'image': _image,
    'status': _status,
    'isPlace': _isPlace,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

/// ======================= LINK (xLink / insta / mail / phone) =======================

class LinkEntity {
  LinkEntity({String? type, String? link}) : _type = type, _link = link;

  factory LinkEntity.fromJson(dynamic json) =>
      LinkEntity(type: json['type'], link: json['link']);

  String? _type;
  String? _link;

  String? get type => _type;
  String? get link => _link;

  Map<String, dynamic> toJson() => {'type': _type, 'link': _link};
}

/// ======================= USER SUMMARY =======================

class UserSummaryEntity {
  UserSummaryEntity({
    String? id,
    String? email,
    String? fullName,
    bool? sales,
    num? commission,
    int? reservationNumber,
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

  factory UserSummaryEntity.fromJson(dynamic json) => UserSummaryEntity(
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
  int? _reservationNumber;
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
  int? get reservationNumber => _reservationNumber;
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

/// ======================= POST ICONS =======================

class PostIconsEntity {
  PostIconsEntity({
    String? id,
    PostIconFileEntity? phoneIcon,
    PostIconFileEntity? mailIcon,
    PostIconFileEntity? instaIcon,
    PostIconFileEntity? xIcon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _phoneIcon = phoneIcon,
       _mailIcon = mailIcon,
       _instaIcon = instaIcon,
       _xIcon = xIcon,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory PostIconsEntity.fromJson(dynamic json) => PostIconsEntity(
    id: json['_id'],
    phoneIcon: json['phoneIcon'] != null
        ? PostIconFileEntity.fromJson(json['phoneIcon'])
        : null,
    mailIcon: json['mailIcon'] != null
        ? PostIconFileEntity.fromJson(json['mailIcon'])
        : null,
    instaIcon: json['instaIcon'] != null
        ? PostIconFileEntity.fromJson(json['instaIcon'])
        : null,
    xIcon: json['xIcon'] != null
        ? PostIconFileEntity.fromJson(json['xIcon'])
        : null,
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  PostIconFileEntity? _phoneIcon;
  PostIconFileEntity? _mailIcon;
  PostIconFileEntity? _instaIcon;
  PostIconFileEntity? _xIcon;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  PostIconFileEntity? get phoneIcon => _phoneIcon;
  PostIconFileEntity? get mailIcon => _mailIcon;
  PostIconFileEntity? get instaIcon => _instaIcon;
  PostIconFileEntity? get xIcon => _xIcon;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'phoneIcon': _phoneIcon?.toJson(),
    'mailIcon': _mailIcon?.toJson(),
    'instaIcon': _instaIcon?.toJson(),
    'xIcon': _xIcon?.toJson(),
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

class PostIconFileEntity {
  PostIconFileEntity({
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

  factory PostIconFileEntity.fromJson(dynamic json) => PostIconFileEntity(
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
