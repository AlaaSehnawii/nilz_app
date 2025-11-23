import 'dart:convert';

ReservationListResponseEntity reservationListResponseEntityFromJson(
  String str,
) => ReservationListResponseEntity.fromJson(json.decode(str));

String reservationListResponseEntityToJson(
  ReservationListResponseEntity data,
) => json.encode(data.toJson());

class ReservationListResponseEntity {
  ReservationListResponseEntity({
    int? statusCode,
    String? message,
    List<ReservationEntity>? data,
  }) : _statusCode = statusCode,
       _message = message,
       _data = data;

  factory ReservationListResponseEntity.fromJson(dynamic json) {
    return ReservationListResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReservationEntity.fromJson(e))
          .toList(),
    );
  }

  int? _statusCode;
  String? _message;
  List<ReservationEntity>? _data;

  int? get statusCode => _statusCode;

  String? get message => _message;

  List<ReservationEntity> get reservations => _data ?? const [];

  Map<String, dynamic> toJson() => {
    'statusCode': _statusCode,
    'message': _message,
    'data': _data?.map((e) => e.toJson()).toList(),
  };
}

/// =======================
/// Reservation root entity
/// =======================

class ReservationEntity {
  ReservationEntity({
    String? id,
    ReservationUser? user,
    ReservationUnit? unit,
    String? file,
    ReservationStatus? reservationStatus,
    String? fromDate,
    String? toDate,
    List<Guest>? guests,
    String? taxPrice,
    String? serviceFees,
    String? stayPrice,
    String? totalPrice,
    String? breakfastPrice,
    int? daysNumber,
    ReservationUserSummary? salesUser,
    ReservationUserSummary? createdBy,
    List<RoomConfig>? roomConfig,
    String? priceAfterDiscount,
    String? categoryDiscount,
    dynamic giftDiscount,
    num? hiddenStayPrice,
    num? hiddenTotalPrice,
    num? hiddenCategoryDiscount,
    num? hiddenPriceAfterDiscount,
    num? hiddenCommission,
    dynamic hiddenGiftDiscount,
    dynamic hiddenFinalPrice,
    num? profit,
    int? nightCount,
    int? adultCount,
    int? childCount,
    bool? notificationSent,
    num? commission,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    ReservationUserSummary? lastUpdatedBy,
    ReservationType? reservationType,
    num? rating,
    String? couponDiscountAmount,
    Coupon? coupon,
    int? extraBedCount,
    dynamic extraBedPrice,
  }) : _id = id,
       _user = user,
       _unit = unit,
       _file = file,
       _reservationStatus = reservationStatus,
       _fromDate = fromDate,
       _toDate = toDate,
       _guests = guests,
       _taxPrice = taxPrice,
       _serviceFees = serviceFees,
       _stayPrice = stayPrice,
       _totalPrice = totalPrice,
       _breakfastPrice = breakfastPrice,
       _daysNumber = daysNumber,
       _salesUser = salesUser,
       _createdBy = createdBy,
       _roomConfig = roomConfig,
       _priceAfterDiscount = priceAfterDiscount,
       _categoryDiscount = categoryDiscount,
       _giftDiscount = giftDiscount,
       _hiddenStayPrice = hiddenStayPrice,
       _hiddenTotalPrice = hiddenTotalPrice,
       _hiddenCategoryDiscount = hiddenCategoryDiscount,
       _hiddenPriceAfterDiscount = hiddenPriceAfterDiscount,
       _hiddenCommission = hiddenCommission,
       _hiddenGiftDiscount = hiddenGiftDiscount,
       _hiddenFinalPrice = hiddenFinalPrice,
       _profit = profit,
       _nightCount = nightCount,
       _adultCount = adultCount,
       _childCount = childCount,
       _notificationSent = notificationSent,
       _commission = commission,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt,
       _lastUpdatedBy = lastUpdatedBy,
       _reservationType = reservationType,
       _rating = rating,
       _couponDiscountAmount = couponDiscountAmount,
       _coupon = coupon,
       _extraBedCount = extraBedCount,
       _extraBedPrice = extraBedPrice;

  factory ReservationEntity.fromJson(dynamic json) => ReservationEntity(
    id: json['_id'],
    user: json['user'] != null ? ReservationUser.fromJson(json['user']) : null,
    unit: json['unit'] != null ? ReservationUnit.fromJson(json['unit']) : null,
    file: json['file'],
    reservationStatus: json['reservationStatus'] != null
        ? ReservationStatus.fromJson(json['reservationStatus'])
        : null,
    fromDate: json['fromDate'],
    toDate: json['toDate'],
    guests: (json['guests'] as List<dynamic>?)
        ?.map((e) => Guest.fromJson(e))
        .toList(),
    taxPrice: json['taxPrice'],
    serviceFees: json['serviceFees'],
    stayPrice: json['stayPrice'],
    totalPrice: json['totalPrice'],
    breakfastPrice: json['breakfastPrice'],
    daysNumber: json['daysNumber'],
    salesUser: json['salesUser'] != null
        ? ReservationUserSummary.fromJson(json['salesUser'])
        : null,
    createdBy: json['createdBy'] != null
        ? ReservationUserSummary.fromJson(json['createdBy'])
        : null,
    roomConfig: (json['roomConfig'] as List<dynamic>?)
        ?.map((e) => RoomConfig.fromJson(e))
        .toList(),
    priceAfterDiscount: json['priceAfterDiscount'],
    categoryDiscount: json['categoryDiscount'],
    giftDiscount: json['giftDiscount'],
    hiddenStayPrice: (json['hiddenStayPrice'] as num?),
    hiddenTotalPrice: (json['hiddenTotalPrice'] as num?),
    hiddenCategoryDiscount: (json['hiddenCategoryDiscount'] as num?),
    hiddenPriceAfterDiscount: (json['hiddenPriceAfterDiscount'] as num?),
    hiddenCommission: (json['hiddenCommission'] as num?),
    hiddenGiftDiscount: json['hiddenGiftDiscount'],
    hiddenFinalPrice: json['hiddenFinalPrice'],
    profit: (json['profit'] as num?),
    nightCount: json['nightCount'],
    adultCount: json['adultCount'],
    childCount: json['childCount'],
    notificationSent: json['notificationSent'],
    commission: (json['commission'] as num?),
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    lastUpdatedBy: json['lastUpdatedBy'] != null
        ? ReservationUserSummary.fromJson(json['lastUpdatedBy'])
        : null,
    reservationType: json['reservationType'] != null
        ? ReservationType.fromJson(json['reservationType'])
        : null,
    rating: (json['rating'] as num?),
    couponDiscountAmount: json['couponDiscountAmount'],
    coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
    extraBedCount: json['extraBedCount'],
    extraBedPrice: json['extraBedPrice'],
  );

  String? _id;
  ReservationUser? _user;
  ReservationUnit? _unit;
  String? _file;
  ReservationStatus? _reservationStatus;
  String? _fromDate;
  String? _toDate;
  List<Guest>? _guests;
  String? _taxPrice;
  String? _serviceFees;
  String? _stayPrice;
  String? _totalPrice;
  String? _breakfastPrice;
  int? _daysNumber;
  ReservationUserSummary? _salesUser;
  ReservationUserSummary? _createdBy;
  List<RoomConfig>? _roomConfig;
  String? _priceAfterDiscount;
  String? _categoryDiscount;
  dynamic _giftDiscount;
  num? _hiddenStayPrice;
  num? _hiddenTotalPrice;
  num? _hiddenCategoryDiscount;
  num? _hiddenPriceAfterDiscount;
  num? _hiddenCommission;
  dynamic _hiddenGiftDiscount;
  dynamic _hiddenFinalPrice;
  num? _profit;
  int? _nightCount;
  int? _adultCount;
  int? _childCount;
  bool? _notificationSent;
  num? _commission;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  ReservationUserSummary? _lastUpdatedBy;
  ReservationType? _reservationType;
  num? _rating;
  String? _couponDiscountAmount;
  Coupon? _coupon;
  int? _extraBedCount;
  dynamic _extraBedPrice;

  String? get id => _id;

  ReservationUser? get user => _user;

  ReservationUnit? get unit => _unit;

  String? get file => _file;

  ReservationStatus? get reservationStatus => _reservationStatus;

  String? get fromDate => _fromDate;

  String? get toDate => _toDate;

  List<Guest> get guests => _guests ?? const [];

  String? get taxPrice => _taxPrice;

  String? get serviceFees => _serviceFees;

  String? get stayPrice => _stayPrice;

  String? get totalPrice => _totalPrice;

  String? get breakfastPrice => _breakfastPrice;

  int? get daysNumber => _daysNumber;

  ReservationUserSummary? get salesUser => _salesUser;

  ReservationUserSummary? get createdBy => _createdBy;

  List<RoomConfig> get roomConfig => _roomConfig ?? const [];

  String? get priceAfterDiscount => _priceAfterDiscount;

  String? get categoryDiscount => _categoryDiscount;

  dynamic get giftDiscount => _giftDiscount;

  num? get hiddenStayPrice => _hiddenStayPrice;

  num? get hiddenTotalPrice => _hiddenTotalPrice;

  num? get hiddenCategoryDiscount => _hiddenCategoryDiscount;

  num? get hiddenPriceAfterDiscount => _hiddenPriceAfterDiscount;

  num? get hiddenCommission => _hiddenCommission;

  dynamic get hiddenGiftDiscount => _hiddenGiftDiscount;

  dynamic get hiddenFinalPrice => _hiddenFinalPrice;

  num? get profit => _profit;

  int? get nightCount => _nightCount;

  int? get adultCount => _adultCount;

  int? get childCount => _childCount;

  bool? get notificationSent => _notificationSent;

  num? get commission => _commission;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  ReservationUserSummary? get lastUpdatedBy => _lastUpdatedBy;

  ReservationType? get reservationType => _reservationType;

  num? get rating => _rating;

  String? get couponDiscountAmount => _couponDiscountAmount;

  Coupon? get coupon => _coupon;

  int? get extraBedCount => _extraBedCount;

  dynamic get extraBedPrice => _extraBedPrice;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'user': _user?.toJson(),
    'unit': _unit?.toJson(),
    'file': _file,
    'reservationStatus': _reservationStatus?.toJson(),
    'fromDate': _fromDate,
    'toDate': _toDate,
    'guests': _guests?.map((e) => e.toJson()).toList(),
    'taxPrice': _taxPrice,
    'serviceFees': _serviceFees,
    'stayPrice': _stayPrice,
    'totalPrice': _totalPrice,
    'breakfastPrice': _breakfastPrice,
    'daysNumber': _daysNumber,
    'salesUser': _salesUser?.toJson(),
    'createdBy': _createdBy?.toJson(),
    'roomConfig': _roomConfig?.map((e) => e.toJson()).toList(),
    'priceAfterDiscount': _priceAfterDiscount,
    'categoryDiscount': _categoryDiscount,
    'giftDiscount': _giftDiscount,
    'hiddenStayPrice': _hiddenStayPrice,
    'hiddenTotalPrice': _hiddenTotalPrice,
    'hiddenCategoryDiscount': _hiddenCategoryDiscount,
    'hiddenPriceAfterDiscount': _hiddenPriceAfterDiscount,
    'hiddenCommission': _hiddenCommission,
    'hiddenGiftDiscount': _hiddenGiftDiscount,
    'hiddenFinalPrice': _hiddenFinalPrice,
    'profit': _profit,
    'nightCount': _nightCount,
    'adultCount': _adultCount,
    'childCount': _childCount,
    'notificationSent': _notificationSent,
    'commission': _commission,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'lastUpdatedBy': _lastUpdatedBy?.toJson(),
    'reservationType': _reservationType?.toJson(),
    'rating': _rating,
    'couponDiscountAmount': _couponDiscountAmount,
    'coupon': _coupon?.toJson(),
    'extraBedCount': _extraBedCount,
    'extraBedPrice': _extraBedPrice,
  };
}

/// =======================
/// Common small value objs
/// =======================

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

class FileInfo {
  FileInfo({
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

  factory FileInfo.fromJson(dynamic json) => FileInfo(
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

class LocationPoint {
  LocationPoint({String? type, List<double>? coordinates})
    : _type = type,
      _coordinates = coordinates;

  factory LocationPoint.fromJson(dynamic json) => LocationPoint(
    type: json['type'],
    coordinates: (json['coordinates'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList(),
  );

  String? _type;
  List<double>? _coordinates;

  String? get type => _type;

  List<double> get coordinates => _coordinates ?? const [];

  Map<String, dynamic> toJson() => {'type': _type, 'coordinates': _coordinates};
}

class PriceByAge {
  PriceByAge({int? age, dynamic price}) : _age = age, _price = price;

  factory PriceByAge.fromJson(dynamic json) =>
      PriceByAge(age: json['age'], price: json['price']);

  int? _age;
  dynamic _price; // can be num or String

  int? get age => _age;

  dynamic get price => _price;

  Map<String, dynamic> toJson() => {'age': _age, 'price': _price};
}

/// =======================
/// User related
/// =======================

class ReservationUser {
  ReservationUser({
    String? id,
    String? workProfession,
    String? phoneNumber,
    String? additionalPhoneNumber,
    String? userBlock,
    String? fullName,
    String? gender,
    String? category,
    bool? sales,
    num? commission,
    int? reservationNumber,
    String? lastLoginAt,
    bool? isDeleted,
    String? lang,
    String? createdAt,
    String? updatedAt,
    String? birthDate,
    String? image,
    String? fcmToken,
    String? email,
  }) : _id = id,
       _workProfession = workProfession,
       _phoneNumber = phoneNumber,
       _additionalPhoneNumber = additionalPhoneNumber,
       _userBlock = userBlock,
       _fullName = fullName,
       _gender = gender,
       _category = category,
       _sales = sales,
       _commission = commission,
       _reservationNumber = reservationNumber,
       _lastLoginAt = lastLoginAt,
       _isDeleted = isDeleted,
       _lang = lang,
       _createdAt = createdAt,
       _updatedAt = updatedAt,
       _birthDate = birthDate,
       _image = image,
       _fcmToken = fcmToken,
       _email = email;

  factory ReservationUser.fromJson(dynamic json) => ReservationUser(
    id: json['_id'],
    workProfession: json['workProfession'],
    phoneNumber: json['phoneNumber'],
    additionalPhoneNumber: json['additionalPhoneNumber'],
    userBlock: json['userBlock'],
    fullName: json['fullName'],
    gender: json['gender'],
    category: json['category'],
    sales: json['sales'],
    commission: (json['commission'] as num?),
    reservationNumber: json['reservationNumber'],
    lastLoginAt: json['lastLoginAt'],
    isDeleted: json['isDeleted'],
    lang: json['lang'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    birthDate: json['birthDate'],
    image: json['image'],
    fcmToken: json['fcmToken'],
    email: json['email'],
  );

  String? _id;
  String? _workProfession;
  String? _phoneNumber;
  String? _additionalPhoneNumber;
  String? _userBlock;
  String? _fullName;
  String? _gender;
  String? _category;
  bool? _sales;
  num? _commission;
  int? _reservationNumber;
  String? _lastLoginAt;
  bool? _isDeleted;
  String? _lang;
  String? _createdAt;
  String? _updatedAt;
  String? _birthDate;
  String? _image;
  String? _fcmToken;
  String? _email;

  String? get id => _id;

  String? get workProfession => _workProfession;

  String? get phoneNumber => _phoneNumber;

  String? get additionalPhoneNumber => _additionalPhoneNumber;

  String? get userBlock => _userBlock;

  String? get fullName => _fullName;

  String? get gender => _gender;

  String? get category => _category;

  bool? get sales => _sales;

  num? get commission => _commission;

  int? get reservationNumber => _reservationNumber;

  String? get lastLoginAt => _lastLoginAt;

  bool? get isDeleted => _isDeleted;

  String? get lang => _lang;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get birthDate => _birthDate;

  String? get image => _image;

  String? get fcmToken => _fcmToken;

  String? get email => _email;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'workProfession': _workProfession,
    'phoneNumber': _phoneNumber,
    'additionalPhoneNumber': _additionalPhoneNumber,
    'userBlock': _userBlock,
    'fullName': _fullName,
    'gender': _gender,
    'category': _category,
    'sales': _sales,
    'commission': _commission,
    'reservationNumber': _reservationNumber,
    'lastLoginAt': _lastLoginAt,
    'isDeleted': _isDeleted,
    'lang': _lang,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'birthDate': _birthDate,
    'image': _image,
    'fcmToken': _fcmToken,
    'email': _email,
  };
}

class ReservationUserSummary {
  ReservationUserSummary({
    String? id,
    String? email,
    String? fullName,
    String? userBlock,
    String? image,
    bool? sales,
    num? commission,
    int? reservationNumber,
    bool? isDeleted,
    String? lang,
    String? createdAt,
    String? updatedAt,
    String? lastLoginAt,
    String? fcmToken,
    bool? salesEmployee,
    num? commissionValue,
    String? createdBy,
    String? lastUpdatedBy,
  }) : _id = id,
       _email = email,
       _fullName = fullName,
       _userBlock = userBlock,
       _image = image,
       _sales = sales,
       _commission = commission,
       _reservationNumber = reservationNumber,
       _isDeleted = isDeleted,
       _lang = lang,
       _createdAt = createdAt,
       _updatedAt = updatedAt,
       _lastLoginAt = lastLoginAt,
       _fcmToken = fcmToken,
       _salesEmployee = salesEmployee,
       _commissionValue = commissionValue,
       _createdBy = createdBy,
       _lastUpdatedBy = lastUpdatedBy;

  factory ReservationUserSummary.fromJson(dynamic json) =>
      ReservationUserSummary(
        id: json['_id'],
        email: json['email'],
        fullName: json['fullName'],
        userBlock: json['userBlock'],
        image: json['image'],
        sales: json['sales'],
        commission: (json['commission'] as num?),
        reservationNumber: json['reservationNumber'],
        isDeleted: json['isDeleted'],
        lang: json['lang'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        lastLoginAt: json['lastLoginAt'],
        fcmToken: json['fcmToken'],
        salesEmployee: json['salesEmployee'],
        commissionValue: (json['commissionValue'] as num?),
        createdBy: json['createdBy'],
        lastUpdatedBy: json['lastUpdatedBy'],
      );

  String? _id;
  String? _email;
  String? _fullName;
  String? _userBlock;
  String? _image;
  bool? _sales;
  num? _commission;
  int? _reservationNumber;
  bool? _isDeleted;
  String? _lang;
  String? _createdAt;
  String? _updatedAt;
  String? _lastLoginAt;
  String? _fcmToken;
  bool? _salesEmployee;
  num? _commissionValue;
  String? _createdBy;
  String? _lastUpdatedBy;

  String? get id => _id;

  String? get email => _email;

  String? get fullName => _fullName;

  String? get userBlock => _userBlock;

  String? get image => _image;

  bool? get sales => _sales;

  num? get commission => _commission;

  int? get reservationNumber => _reservationNumber;

  bool? get isDeleted => _isDeleted;

  String? get lang => _lang;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get lastLoginAt => _lastLoginAt;

  String? get fcmToken => _fcmToken;

  bool? get salesEmployee => _salesEmployee;

  num? get commissionValue => _commissionValue;

  String? get createdBy => _createdBy;

  String? get lastUpdatedBy => _lastUpdatedBy;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'email': _email,
    'fullName': _fullName,
    'userBlock': _userBlock,
    'image': _image,
    'sales': _sales,
    'commission': _commission,
    'reservationNumber': _reservationNumber,
    'isDeleted': _isDeleted,
    'lang': _lang,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'lastLoginAt': _lastLoginAt,
    'fcmToken': _fcmToken,
    'salesEmployee': _salesEmployee,
    'commissionValue': _commissionValue,
    'createdBy': _createdBy,
    'lastUpdatedBy': _lastUpdatedBy,
  };
}

/// =======================
/// Unit & related
/// =======================

class ReservationUnit {
  ReservationUnit({
    String? id,
    ParentPlace? parent,
    LocalizedName? name,
    LocalizedName? description,
    bool? reservable,
    bool? status,
    LocationPoint? location,
    bool? hasBreakfast,
    List<PriceByAge>? breakfastPrice,
    num? price,
    num? hiddenPrice,
    int? bathroomCount,
    int? adultCount,
    int? childCount,
    int? roomCount,
    num? totalRating,
    int? ratingCount,
    UnitType? unitType,
    List<UnitRoomConf>? roomConf,
    FileInfo? coverImage,
    FileInfo? gallery,
    List<String>? unitFeatures,
    int? stars,
    int? unitCount,
    List<dynamic>? features,
    dynamic rank,
    List<dynamic>? childPrice,
    bool? featured,
    String? address,
    String? createdBy,
    String? lastUpdatedBy,
    int? approvedReservationCount,
    int? cancelledReservationCount,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? unitNumber,
    num? extraBedPrice,
    int? maxExtraBedCount,
  }) : _id = id,
       _parent = parent,
       _name = name,
       _description = description,
       _reservable = reservable,
       _status = status,
       _location = location,
       _hasBreakfast = hasBreakfast,
       _breakfastPrice = breakfastPrice,
       _price = price,
       _hiddenPrice = hiddenPrice,
       _bathroomCount = bathroomCount,
       _adultCount = adultCount,
       _childCount = childCount,
       _roomCount = roomCount,
       _totalRating = totalRating,
       _ratingCount = ratingCount,
       _unitType = unitType,
       _roomConf = roomConf,
       _coverImage = coverImage,
       _gallery = gallery,
       _unitFeatures = unitFeatures,
       _stars = stars,
       _unitCount = unitCount,
       _features = features,
       _rank = rank,
       _childPrice = childPrice,
       _featured = featured,
       _address = address,
       _createdBy = createdBy,
       _lastUpdatedBy = lastUpdatedBy,
       _approvedReservationCount = approvedReservationCount,
       _cancelledReservationCount = cancelledReservationCount,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt,
       _unitNumber = unitNumber,
       _extraBedPrice = extraBedPrice,
       _maxExtraBedCount = maxExtraBedCount;

  factory ReservationUnit.fromJson(dynamic json) => ReservationUnit(
    id: json['_id'],
    parent: json['parent'] != null
        ? ParentPlace.fromJson(json['parent'])
        : null,
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    description: json['description'] != null
        ? LocalizedName.fromJson(json['description'])
        : null,
    reservable: json['reservable'],
    status: json['status'],
    location: json['location'] != null
        ? LocationPoint.fromJson(json['location'])
        : null,
    hasBreakfast: json['hasBreakfast'],
    breakfastPrice: (json['breakfastPrice'] as List<dynamic>?)
        ?.map((e) => PriceByAge.fromJson(e))
        .toList(),
    price: (json['price'] as num?),
    hiddenPrice: (json['hiddenPrice'] as num?),
    bathroomCount: json['bathroomCount'],
    adultCount: json['adultCount'],
    childCount: json['childCount'],
    roomCount: json['roomCount'],
    totalRating: (json['totalRating'] as num?),
    ratingCount: json['ratingCount'],
    unitType: json['unitType'] != null
        ? UnitType.fromJson(json['unitType'])
        : null,
    roomConf: (json['roomConf'] as List<dynamic>?)
        ?.map((e) => UnitRoomConf.fromJson(e))
        .toList(),
    coverImage: json['coverImage'] != null
        ? FileInfo.fromJson(json['coverImage'])
        : null,
    gallery: json['gallery'] != null
        ? FileInfo.fromJson(json['gallery'])
        : null,
    unitFeatures: (json['unitFeatures'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    stars: json['stars'],
    unitCount: json['unitCount'],
    features: json['features'] as List<dynamic>?,
    rank: json['rank'],
    childPrice: json['childPrice'] as List<dynamic>?,
    featured: json['featured'],
    address: json['address'],
    createdBy: json['created_by'],
    lastUpdatedBy: json['lastUpdatedBy'],
    approvedReservationCount: json['approvedReservationCount'],
    cancelledReservationCount: json['cancelledReservationCount'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    unitNumber: json['unitNumber'],
    extraBedPrice: json['extraBedPrice'] == null
        ? null
        : (json['extraBedPrice'] as num?),
    maxExtraBedCount: json['maxExtraBedCount'],
  );

  String? _id;
  ParentPlace? _parent;
  LocalizedName? _name;
  LocalizedName? _description;
  bool? _reservable;
  bool? _status;
  LocationPoint? _location;
  bool? _hasBreakfast;
  List<PriceByAge>? _breakfastPrice;
  num? _price;
  num? _hiddenPrice;
  int? _bathroomCount;
  int? _adultCount;
  int? _childCount;
  int? _roomCount;
  num? _totalRating;
  int? _ratingCount;
  UnitType? _unitType;
  List<UnitRoomConf>? _roomConf;
  FileInfo? _coverImage;
  FileInfo? _gallery;
  List<String>? _unitFeatures;
  int? _stars;
  int? _unitCount;
  List<dynamic>? _features;
  dynamic _rank;
  List<dynamic>? _childPrice;
  bool? _featured;
  String? _address;
  String? _createdBy;
  String? _lastUpdatedBy;
  int? _approvedReservationCount;
  int? _cancelledReservationCount;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _unitNumber;
  num? _extraBedPrice;
  int? _maxExtraBedCount;

  String? get id => _id;

  ParentPlace? get parent => _parent;

  LocalizedName? get name => _name;

  LocalizedName? get description => _description;

  bool? get reservable => _reservable;

  bool? get status => _status;

  LocationPoint? get location => _location;

  bool? get hasBreakfast => _hasBreakfast;

  List<PriceByAge> get breakfastPrice => _breakfastPrice ?? const [];

  num? get price => _price;

  num? get hiddenPrice => _hiddenPrice;

  int? get bathroomCount => _bathroomCount;

  int? get adultCount => _adultCount;

  int? get childCount => _childCount;

  int? get roomCount => _roomCount;

  num? get totalRating => _totalRating;

  int? get ratingCount => _ratingCount;

  UnitType? get unitType => _unitType;

  List<UnitRoomConf> get roomConf => _roomConf ?? const [];

  FileInfo? get coverImage => _coverImage;

  FileInfo? get gallery => _gallery;

  List<String> get unitFeatures => _unitFeatures ?? const [];

  int? get stars => _stars;

  int? get unitCount => _unitCount;

  List<dynamic> get features => _features ?? const [];

  dynamic get rank => _rank;

  List<dynamic> get childPrice => _childPrice ?? const [];

  bool? get featured => _featured;

  String? get address => _address;

  String? get createdBy => _createdBy;

  String? get lastUpdatedBy => _lastUpdatedBy;

  int? get approvedReservationCount => _approvedReservationCount;

  int? get cancelledReservationCount => _cancelledReservationCount;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get unitNumber => _unitNumber;

  num? get extraBedPrice => _extraBedPrice;

  int? get maxExtraBedCount => _maxExtraBedCount;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'parent': _parent?.toJson(),
    'name': _name?.toJson(),
    'description': _description?.toJson(),
    'reservable': _reservable,
    'status': _status,
    'location': _location?.toJson(),
    'hasBreakfast': _hasBreakfast,
    'breakfastPrice': _breakfastPrice?.map((e) => e.toJson()).toList(),
    'price': _price,
    'hiddenPrice': _hiddenPrice,
    'bathroomCount': _bathroomCount,
    'adultCount': _adultCount,
    'childCount': _childCount,
    'roomCount': _roomCount,
    'totalRating': _totalRating,
    'ratingCount': _ratingCount,
    'unitType': _unitType?.toJson(),
    'roomConf': _roomConf?.map((e) => e.toJson()).toList(),
    'coverImage': _coverImage?.toJson(),
    'gallery': _gallery?.toJson(),
    'unitFeatures': _unitFeatures,
    'stars': _stars,
    'unitCount': _unitCount,
    'features': _features,
    'rank': _rank,
    'childPrice': _childPrice,
    'featured': _featured,
    'address': _address,
    'created_by': _createdBy,
    'lastUpdatedBy': _lastUpdatedBy,
    'approvedReservationCount': _approvedReservationCount,
    'cancelledReservationCount': _cancelledReservationCount,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'unitNumber': _unitNumber,
    'extraBedPrice': _extraBedPrice,
    'maxExtraBedCount': _maxExtraBedCount,
  };
}

class ParentPlace {
  ParentPlace({
    String? id,
    LocalizedName? name,
    LocalizedName? description,
    bool? reservable,
    bool? status,
    LocationPoint? location,
    List<PriceByAge>? breakfastPrice,
    int? adultCount,
    int? childCount,
    int? roomCount,
    num? totalRating,
    int? ratingCount,
    String? placeType,
    FileInfo? coverImage,
    FileInfo? logo,
    FileInfo? gallery,
    List<dynamic>? unitFeatures,
    int? stars,
    int? unitCount,
    num? cityDistance,
    List<dynamic>? features,
    int? rank,
    CityEntity? city,
    List<dynamic>? childPrice,
    bool? featured,
    String? address,
    List<dynamic>? placeFeatures,
    String? createdBy,
    String? lastUpdatedBy,
    String? email,
    int? approvedReservationCount,
    int? cancelledReservationCount,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? unitNumber,
    bool? hasBreakfast,
    int? maxExtraBedCount,
  }) : _id = id,
       _name = name,
       _description = description,
       _reservable = reservable,
       _status = status,
       _location = location,
       _breakfastPrice = breakfastPrice,
       _adultCount = adultCount,
       _childCount = childCount,
       _roomCount = roomCount,
       _totalRating = totalRating,
       _ratingCount = ratingCount,
       _placeType = placeType,
       _coverImage = coverImage,
       _logo = logo,
       _gallery = gallery,
       _unitFeatures = unitFeatures,
       _stars = stars,
       _unitCount = unitCount,
       _cityDistance = cityDistance,
       _features = features,
       _rank = rank,
       _city = city,
       _childPrice = childPrice,
       _featured = featured,
       _address = address,
       _placeFeatures = placeFeatures,
       _createdBy = createdBy,
       _lastUpdatedBy = lastUpdatedBy,
       _email = email,
       _approvedReservationCount = approvedReservationCount,
       _cancelledReservationCount = cancelledReservationCount,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt,
       _unitNumber = unitNumber,
       _hasBreakfast = hasBreakfast,
       _maxExtraBedCount = maxExtraBedCount;

  factory ParentPlace.fromJson(dynamic json) => ParentPlace(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    description: json['description'] != null
        ? LocalizedName.fromJson(json['description'])
        : null,
    reservable: json['reservable'],
    status: json['status'],
    location: json['location'] != null
        ? LocationPoint.fromJson(json['location'])
        : null,
    breakfastPrice: (json['breakfastPrice'] as List<dynamic>?)
        ?.map((e) => PriceByAge.fromJson(e))
        .toList(),
    adultCount: json['adultCount'],
    childCount: json['childCount'],
    roomCount: json['roomCount'],
    totalRating: (json['totalRating'] as num?),
    ratingCount: json['ratingCount'],
    placeType: json['placeType'],
    coverImage: json['coverImage'] != null
        ? FileInfo.fromJson(json['coverImage'])
        : null,
    logo: json['logo'] != null ? FileInfo.fromJson(json['logo']) : null,
    gallery: json['gallery'] != null
        ? FileInfo.fromJson(json['gallery'])
        : null,
    unitFeatures: json['unitFeatures'] as List<dynamic>?,
    stars: json['stars'],
    unitCount: json['unitCount'],
    cityDistance: (json['cityDistance'] as num?),
    features: json['features'] as List<dynamic>?,
    rank: json['rank'],
    city: json['city'] != null ? CityEntity.fromJson(json['city']) : null,
    childPrice: json['childPrice'] as List<dynamic>?,
    featured: json['featured'],
    address: json['address'],
    placeFeatures: json['placeFeatures'] as List<dynamic>?,
    createdBy: json['created_by'],
    lastUpdatedBy: json['lastUpdatedBy'],
    email: json['email'],
    approvedReservationCount: json['approvedReservationCount'],
    cancelledReservationCount: json['cancelledReservationCount'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    unitNumber: json['unitNumber'],
    hasBreakfast: json['hasBreakfast'],
    maxExtraBedCount: json['maxExtraBedCount'],
  );

  String? _id;
  LocalizedName? _name;
  LocalizedName? _description;
  bool? _reservable;
  bool? _status;
  LocationPoint? _location;
  List<PriceByAge>? _breakfastPrice;
  int? _adultCount;
  int? _childCount;
  int? _roomCount;
  num? _totalRating;
  int? _ratingCount;
  String? _placeType;
  FileInfo? _coverImage;
  FileInfo? _logo;
  FileInfo? _gallery;
  List<dynamic>? _unitFeatures;
  int? _stars;
  int? _unitCount;
  num? _cityDistance;
  List<dynamic>? _features;
  int? _rank;
  CityEntity? _city;
  List<dynamic>? _childPrice;
  bool? _featured;
  String? _address;
  List<dynamic>? _placeFeatures;
  String? _createdBy;
  String? _lastUpdatedBy;
  String? _email;
  int? _approvedReservationCount;
  int? _cancelledReservationCount;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _unitNumber;
  bool? _hasBreakfast;
  int? _maxExtraBedCount;

  String? get id => _id;

  LocalizedName? get name => _name;

  LocalizedName? get description => _description;

  bool? get reservable => _reservable;

  bool? get status => _status;

  LocationPoint? get location => _location;

  List<PriceByAge> get breakfastPrice => _breakfastPrice ?? const [];

  int? get adultCount => _adultCount;

  int? get childCount => _childCount;

  int? get roomCount => _roomCount;

  num? get totalRating => _totalRating;

  int? get ratingCount => _ratingCount;

  String? get placeType => _placeType;

  FileInfo? get coverImage => _coverImage;

  FileInfo? get logo => _logo;

  FileInfo? get gallery => _gallery;

  List<dynamic> get unitFeatures => _unitFeatures ?? const [];

  int? get stars => _stars;

  int? get unitCount => _unitCount;

  num? get cityDistance => _cityDistance;

  List<dynamic> get features => _features ?? const [];

  int? get rank => _rank;

  CityEntity? get city => _city;

  List<dynamic> get childPrice => _childPrice ?? const [];

  bool? get featured => _featured;

  String? get address => _address;

  List<dynamic> get placeFeatures => _placeFeatures ?? const [];

  String? get createdBy => _createdBy;

  String? get lastUpdatedBy => _lastUpdatedBy;

  String? get email => _email;

  int? get approvedReservationCount => _approvedReservationCount;

  int? get cancelledReservationCount => _cancelledReservationCount;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get unitNumber => _unitNumber;

  bool? get hasBreakfast => _hasBreakfast;

  int? get maxExtraBedCount => _maxExtraBedCount;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'description': _description?.toJson(),
    'reservable': _reservable,
    'status': _status,
    'location': _location?.toJson(),
    'breakfastPrice': _breakfastPrice?.map((e) => e.toJson()).toList(),
    'adultCount': _adultCount,
    'childCount': _childCount,
    'roomCount': _roomCount,
    'totalRating': _totalRating,
    'ratingCount': _ratingCount,
    'placeType': _placeType,
    'coverImage': _coverImage?.toJson(),
    'logo': _logo?.toJson(),
    'gallery': _gallery?.toJson(),
    'unitFeatures': _unitFeatures,
    'stars': _stars,
    'unitCount': _unitCount,
    'cityDistance': _cityDistance,
    'features': _features,
    'rank': _rank,
    'city': _city?.toJson(),
    'childPrice': _childPrice,
    'featured': _featured,
    'address': _address,
    'placeFeatures': _placeFeatures,
    'created_by': _createdBy,
    'lastUpdatedBy': _lastUpdatedBy,
    'email': _email,
    'approvedReservationCount': _approvedReservationCount,
    'cancelledReservationCount': _cancelledReservationCount,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'unitNumber': _unitNumber,
    'hasBreakfast': _hasBreakfast,
    'maxExtraBedCount': _maxExtraBedCount,
  };
}

class CityEntity {
  CityEntity({
    String? id,
    LocalizedName? name,
    String? image,
    String? createdBy,
    String? lastUpdatedBy,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _image = image,
       _createdBy = createdBy,
       _lastUpdatedBy = lastUpdatedBy,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory CityEntity.fromJson(dynamic json) => CityEntity(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    image: json['image'],
    createdBy: json['createdBy'],
    lastUpdatedBy: json['lastUpdatedBy'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedName? _name;
  String? _image;
  String? _createdBy;
  String? _lastUpdatedBy;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedName? get name => _name;

  String? get image => _image;

  String? get createdBy => _createdBy;

  String? get lastUpdatedBy => _lastUpdatedBy;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'image': _image,
    'createdBy': _createdBy,
    'lastUpdatedBy': _lastUpdatedBy,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

class UnitType {
  UnitType({
    String? id,
    LocalizedName? name,
    String? icon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _icon = icon,
       _isDeleted = isDeleted,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory UnitType.fromJson(dynamic json) => UnitType(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    icon: json['icon'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedName? _name;
  String? _icon;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedName? get name => _name;

  String? get icon => _icon;

  bool? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'icon': _icon,
    'isDeleted': _isDeleted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

class UnitRoomConf {
  UnitRoomConf({
    String? roomType,
    int? adultCount,
    int? childCount,
    List<BedConf>? bedConf,
  }) : _roomType = roomType,
       _adultCount = adultCount,
       _childCount = childCount,
       _bedConf = bedConf;

  factory UnitRoomConf.fromJson(dynamic json) => UnitRoomConf(
    roomType: json['roomType'],
    adultCount: json['adultCount'],
    childCount: json['childCount'],
    bedConf: (json['bedConf'] as List<dynamic>?)
        ?.map((e) => BedConf.fromJson(e))
        .toList(),
  );

  String? _roomType;
  int? _adultCount;
  int? _childCount;
  List<BedConf>? _bedConf;

  String? get roomType => _roomType;

  int? get adultCount => _adultCount;

  int? get childCount => _childCount;

  List<BedConf> get bedConf => _bedConf ?? const [];

  Map<String, dynamic> toJson() => {
    'roomType': _roomType,
    'adultCount': _adultCount,
    'childCount': _childCount,
    'bedConf': _bedConf?.map((e) => e.toJson()).toList(),
  };
}

class BedConf {
  BedConf({int? count, String? bedType}) : _count = count, _bedType = bedType;

  factory BedConf.fromJson(dynamic json) =>
      BedConf(count: json['count'], bedType: json['bedType']);

  int? _count;
  String? _bedType;

  int? get count => _count;

  String? get bedType => _bedType;

  Map<String, dynamic> toJson() => {'count': _count, 'bedType': _bedType};
}

/// =======================
/// Reservation status/type
/// =======================

class ReservationStatus {
  ReservationStatus({
    String? id,
    LocalizedName? name,
    String? code,
    String? color,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _name = name,
       _code = code,
       _color = color,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory ReservationStatus.fromJson(dynamic json) => ReservationStatus(
    id: json['_id'],
    name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
    code: json['code'],
    color: json['color'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  LocalizedName? _name;
  String? _code;
  String? _color;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  LocalizedName? get name => _name;

  String? get code => _code;

  String? get color => _color;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': _name?.toJson(),
    'code': _code,
    'color': _color,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}

class ReservationType {
  ReservationType({
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

  factory ReservationType.fromJson(dynamic json) => ReservationType(
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
}

/// =======================
/// Guests / roomConfig
/// =======================

class Guest {
  Guest({int? age, int? count}) : _age = age, _count = count;

  factory Guest.fromJson(dynamic json) =>
      Guest(age: json['age'], count: json['count']);

  int? _age;
  int? _count;

  int? get age => _age;

  int? get count => _count;

  Map<String, dynamic> toJson() => {'age': _age, 'count': _count};
}

class RoomConfig {
  RoomConfig({List<Guest>? guests}) : _guests = guests;

  factory RoomConfig.fromJson(dynamic json) => RoomConfig(
    guests: (json['guests'] as List<dynamic>?)
        ?.map((e) => Guest.fromJson(e))
        .toList(),
  );

  List<Guest>? _guests;

  List<Guest> get guests => _guests ?? const [];

  Map<String, dynamic> toJson() => {
    'guests': _guests?.map((e) => e.toJson()).toList(),
  };
}

/// =======================
/// Coupon
/// =======================

class Coupon {
  Coupon({
    String? id,
    bool? isActive,
    String? code,
    String? dateFrom,
    String? dateTo,
    num? percentageDiscount,
    num? totalDiscount,
    num? minTotal,
    int? usageCount,
    int? actualUsageCount,
    bool? isGlobal,
    String? createdAt,
    String? updatedAt,
  }) : _id = id,
       _isActive = isActive,
       _code = code,
       _dateFrom = dateFrom,
       _dateTo = dateTo,
       _percentageDiscount = percentageDiscount,
       _totalDiscount = totalDiscount,
       _minTotal = minTotal,
       _usageCount = usageCount,
       _actualUsageCount = actualUsageCount,
       _isGlobal = isGlobal,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory Coupon.fromJson(dynamic json) => Coupon(
    id: json['_id'],
    isActive: json['isActive'],
    code: json['code'],
    dateFrom: json['dateFrom'],
    dateTo: json['dateTo'],
    percentageDiscount: (json['percentageDiscount'] as num?),
    totalDiscount: (json['totalDiscount'] as num?),
    minTotal: (json['minTotal'] as num?),
    usageCount: json['usageCount'],
    actualUsageCount: json['actualUsageCount'],
    isGlobal: json['isGlobal'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  String? _id;
  bool? _isActive;
  String? _code;
  String? _dateFrom;
  String? _dateTo;
  num? _percentageDiscount;
  num? _totalDiscount;
  num? _minTotal;
  int? _usageCount;
  int? _actualUsageCount;
  bool? _isGlobal;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;

  bool? get isActive => _isActive;

  String? get code => _code;

  String? get dateFrom => _dateFrom;

  String? get dateTo => _dateTo;

  num? get percentageDiscount => _percentageDiscount;

  num? get totalDiscount => _totalDiscount;

  num? get minTotal => _minTotal;

  int? get usageCount => _usageCount;

  int? get actualUsageCount => _actualUsageCount;

  bool? get isGlobal => _isGlobal;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'isActive': _isActive,
    'code': _code,
    'dateFrom': _dateFrom,
    'dateTo': _dateTo,
    'percentageDiscount': _percentageDiscount,
    'totalDiscount': _totalDiscount,
    'minTotal': _minTotal,
    'usageCount': _usageCount,
    'actualUsageCount': _actualUsageCount,
    'isGlobal': _isGlobal,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };
}
