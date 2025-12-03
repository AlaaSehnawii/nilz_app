import 'dart:convert';

UnitApiResponseEntity unitApiResponseEntityFromJson(String str) =>
    UnitApiResponseEntity.fromJson(json.decode(str));

String unitApiResponseEntityToJson(UnitApiResponseEntity data) =>
    json.encode(data.toJson());

class UnitApiResponseEntity {
  UnitApiResponseEntity({
    int? statusCode,
    String? message,
    List<UnitEntity>? results,
    int? count,
  })  : _statusCode = statusCode,
        _message = message,
        _results = results,
        _count = count;

  factory UnitApiResponseEntity.fromJson(dynamic json) {
    if (json is List) {
      final units = json.map<UnitEntity>((e) => UnitEntity.fromJson(e)).toList();
      return UnitApiResponseEntity(
        statusCode: null,
        message: null,
        results: units,
        count: units.length,
      );
    }

    if (json is Map<String, dynamic>) {
      final statusCode = json['statusCode'] as int?;
      final message = json['message'] as String?;
      final dynamic dataNode = json['data'] ?? json;

      List<dynamic> rawResults;
      if (dataNode is List) {
        rawResults = dataNode;
      } else if (dataNode is Map<String, dynamic> && dataNode['results'] is List) {
        rawResults = dataNode['results'] as List<dynamic>;
      } else {
        rawResults = const [];
      }

      final units = rawResults.map<UnitEntity>((e) => UnitEntity.fromJson(e)).toList();

      final int count;
      if (dataNode is Map<String, dynamic> && dataNode['count'] is int) {
        count = dataNode['count'] as int;
      } else {
        count = units.length;
      }

      return UnitApiResponseEntity(
        statusCode: statusCode,
        message: message,
        results: units,
        count: count,
      );
    }

    // Fallback
    return UnitApiResponseEntity(
      statusCode: null,
      message: null,
      results: const [],
      count: 0,
    );
  }

  int? _statusCode;
  String? _message;
  List<UnitEntity>? _results;
  int? _count;

  int? get statusCode => _statusCode;
  String? get message => _message;
  List<UnitEntity> get units => _results ?? const [];
  int get count => _count ?? units.length;

  Map<String, dynamic> toJson() => {
        'statusCode': _statusCode,
        'message': _message,
        'data': {
          'results': _results?.map((e) => e.toJson()).toList(),
          'count': _count ?? _results?.length,
        },
      };
}

class UnitEntity {
  UnitEntity({
    String? id,
    ParentUnitInfo? parent,
    LocalizedName? name,
    String? unitNumber,
    LocalizedName? description,
    bool? reservable,
    bool? status,
    LocationInfo? location,
    bool? hasBreakfast,
    List<BreakfastPrice>? breakfastPrice,
    int? adultCount,
    int? childCount,
    int? roomCount,
    int? bathroomCount,
    num? totalRating,
    num? ratingCount,
    PlaceTypeInfo? placeType,
    FileInfo? coverImage,
    FileInfo? logo,
    List<FileInfo>? gallery,
    List<dynamic>? unitFeatures,
    num? stars,
    num? unitCount,
    num? cityDistance,
    List<dynamic>? features,
    num? rank,
    CityInfo? city,
    List<dynamic>? childPrice,
    bool? featured,
    String? address,
    List<UnitPlaceFeature>? placeFeatures,
    UserInfo? createdBy,
    UserInfo? lastUpdatedBy,
    String? email,
    num? approvedReservationCount,
    num? cancelledReservationCount,
    bool? isDeleted,
    List<UnitRoomConf>? roomConf,
    String? createdAt,
    String? updatedAt,
    num? maxExtraBedCount,
    String? price,
    num? hiddenPrice,
    String? unitType,
    String? groupUnit,
    List<FileInfo>? featureIcons,
    List<RoomTypeCount>? roomTypeCounts,
    num? nightCount,
  })  : _id = id,
        _parent = parent,
        _name = name,
        _unitNumber = unitNumber,
        _description = description,
        _reservable = reservable,
        _status = status,
        _location = location,
        _hasBreakfast = hasBreakfast,
        _breakfastPrice = breakfastPrice,
        _adultCount = adultCount,
        _childCount = childCount,
        _roomCount = roomCount,
        _bathroomCount = bathroomCount,
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
        _roomConf = roomConf,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _maxExtraBedCount = maxExtraBedCount,
        _price = price,
        _hiddenPrice = hiddenPrice,
        _unitType = unitType,
        _groupUnit = groupUnit,
        _featureIcons = featureIcons,
        _roomTypeCounts = roomTypeCounts,
        _nightCount = nightCount;

  factory UnitEntity.fromJson(dynamic json) {
    if (json is List && json.isNotEmpty) {
      json = json.first;
    }
    if (json is! Map<String, dynamic>) {
      return UnitEntity();
    }
    final map = json;

    return UnitEntity(
      id: map['_id'] as String?,
      parent: map['parent'] != null ? ParentUnitInfo.fromJson(map['parent']) : null,
      name: map['name'] != null ? LocalizedName.fromJson(map['name']) : null,
      unitNumber: map['unitNumber'] as String?,
      description:
          map['description'] != null ? LocalizedName.fromJson(map['description']) : null,
      reservable: map['reservable'] as bool?,
      status: map['status'] as bool?,
      location:
          map['location'] != null ? LocationInfo.fromJson(map['location']) : null,
      hasBreakfast: map['hasBreakfast'] as bool?,
      breakfastPrice: (map['breakfastPrice'] as List<dynamic>?)
          ?.map((e) => BreakfastPrice.fromJson(e))
          .toList(),
      adultCount: map['adultCount'] as int?,
      childCount: map['childCount'] as int?,
      roomCount: map['roomCount'] as int?,
      bathroomCount: map['bathroomCount'] as int?,
      totalRating: map['totalRating'] as num?,
      ratingCount: map['ratingCount'] as num?,
      placeType:
          map['placeType'] != null ? PlaceTypeInfo.fromJson(map['placeType']) : null,
      coverImage:
          map['coverImage'] != null ? FileInfo.fromJson(map['coverImage']) : null,
      logo: map['logo'] != null ? FileInfo.fromJson(map['logo']) : null,
      gallery: (map['gallery'] as List<dynamic>?)
          ?.map((e) => FileInfo.fromJson(e))
          .toList(),
      unitFeatures: map['unitFeatures'] as List<dynamic>?,
      stars: map['stars'] as num?,
      unitCount: map['unitCount'] as num?,
      cityDistance: map['cityDistance'] as num?,
      features: map['features'] as List<dynamic>?,
      rank: map['rank'] as num?,
      city: map['city'] != null ? CityInfo.fromJson(map['city']) : null,
      childPrice: map['childPrice'] as List<dynamic>?,
      featured: map['featured'] as bool?,
      address: map['address'] as String?,
      placeFeatures: (map['placeFeatures'] as List<dynamic>?)
          ?.map((e) => UnitPlaceFeature.fromJson(e))
          .toList(),
      createdBy:
          map['created_by'] != null ? UserInfo.fromJson(map['created_by']) : null,
      lastUpdatedBy: map['lastUpdatedBy'] != null
          ? UserInfo.fromJson(map['lastUpdatedBy'])
          : null,
      email: map['email'] as String?,
      approvedReservationCount: map['approvedReservationCount'] as num?,
      cancelledReservationCount: map['cancelledReservationCount'] as num?,
      isDeleted: map['isDeleted'] as bool?,
      roomConf: (map['roomConf'] as List<dynamic>?)
          ?.map((e) => UnitRoomConf.fromJson(e))
          .toList(),
      createdAt: map['createdAt'] as String?,
      updatedAt: map['updatedAt'] as String?,
      maxExtraBedCount: map['maxExtraBedCount'] as num?,
      price: map['price']?.toString(),
      hiddenPrice: map['hiddenPrice'] as num?,
      unitType: map['unitType']?.toString(),
      groupUnit: map['groupUnit']?.toString(),
      featureIcons: (map['featureIcons'] as List<dynamic>?)
          ?.map<FileInfo>((e) =>
              e is Map<String, dynamic> ? FileInfo.fromJson(e) : FileInfo())
          .toList(),
      roomTypeCounts: (map['roomTypeCounts'] as List<dynamic>?)
          ?.map((e) => RoomTypeCount.fromJson(e))
          .toList(),
      nightCount: map['nightCount'] as num?,
    );
  }

  String? _id;
  ParentUnitInfo? _parent;
  LocalizedName? _name;
  String? _unitNumber;
  LocalizedName? _description;
  bool? _reservable;
  bool? _status;
  LocationInfo? _location;
  bool? _hasBreakfast;
  List<BreakfastPrice>? _breakfastPrice;
  int? _adultCount;
  int? _childCount;
  int? _roomCount;
  int? _bathroomCount;
  num? _totalRating;
  num? _ratingCount;
  PlaceTypeInfo? _placeType;
  FileInfo? _coverImage;
  FileInfo? _logo;
  List<FileInfo>? _gallery;
  List<dynamic>? _unitFeatures;
  num? _stars;
  num? _unitCount;
  num? _cityDistance;
  List<dynamic>? _features;
  num? _rank;
  CityInfo? _city;
  List<dynamic>? _childPrice;
  bool? _featured;
  String? _address;
  List<UnitPlaceFeature>? _placeFeatures;
  UserInfo? _createdBy;
  UserInfo? _lastUpdatedBy;
  String? _email;
  num? _approvedReservationCount;
  num? _cancelledReservationCount;
  bool? _isDeleted;
  List<UnitRoomConf>? _roomConf;
  String? _createdAt;
  String? _updatedAt;
  num? _maxExtraBedCount;
  String? _price;
  num? _hiddenPrice;
  String? _unitType;
  String? _groupUnit;
  List<FileInfo>? _featureIcons;
  List<RoomTypeCount>? _roomTypeCounts;
  num? _nightCount;

  String? get id => _id;
  ParentUnitInfo? get parent => _parent;
  LocalizedName? get name => _name;
  String? get unitNumber => _unitNumber;
  LocalizedName? get description => _description;
  bool? get reservable => _reservable;
  bool? get status => _status;
  LocationInfo? get location => _location;
  bool? get hasBreakfast => _hasBreakfast;
  List<BreakfastPrice> get breakfastPrice => _breakfastPrice ?? const [];
  int? get adultCount => _adultCount;
  int? get childCount => _childCount;
  int? get roomCount => _roomCount;
  int? get bathroomCount => _bathroomCount;
  num? get totalRating => _totalRating;
  num? get ratingCount => _ratingCount;
  PlaceTypeInfo? get placeType => _placeType;
  FileInfo? get coverImage => _coverImage;
  FileInfo? get logo => _logo;
  List<FileInfo> get gallery => _gallery ?? const [];
  List<dynamic> get unitFeatures => _unitFeatures ?? const [];
  num? get stars => _stars;
  num? get unitCount => _unitCount;
  num? get cityDistance => _cityDistance;
  List<dynamic> get features => _features ?? const [];
  num? get rank => _rank;
  CityInfo? get city => _city;
  List<dynamic> get childPrice => _childPrice ?? const [];
  bool? get featured => _featured;
  String? get address => _address;
  List<UnitPlaceFeature> get placeFeatures => _placeFeatures ?? const [];
  UserInfo? get createdBy => _createdBy;
  UserInfo? get lastUpdatedBy => _lastUpdatedBy;
  String? get email => _email;
  num? get approvedReservationCount => _approvedReservationCount;
  num? get cancelledReservationCount => _cancelledReservationCount;
  bool? get isDeleted => _isDeleted;
  List<UnitRoomConf> get roomConf => _roomConf ?? const [];
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get maxExtraBedCount => _maxExtraBedCount;
  String? get price => _price;
  num? get hiddenPrice => _hiddenPrice;
  String? get unitType => _unitType;
  String? get groupUnit => _groupUnit;
  List<FileInfo> get featureIcons => _featureIcons ?? const [];
  List<RoomTypeCount> get roomTypeCounts => _roomTypeCounts ?? const [];
  num? get nightCount => _nightCount;

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'parent': _parent?.toJson(),
        'name': _name?.toJson(),
        'unitNumber': _unitNumber,
        'description': _description?.toJson(),
        'reservable': _reservable,
        'status': _status,
        'location': _location?.toJson(),
        'hasBreakfast': _hasBreakfast,
        'breakfastPrice': _breakfastPrice?.map((e) => e.toJson()).toList(),
        'adultCount': _adultCount,
        'childCount': _childCount,
        'roomCount': _roomCount,
        'bathroomCount': _bathroomCount,
        'totalRating': _totalRating,
        'ratingCount': _ratingCount,
        'placeType': _placeType?.toJson(),
        'coverImage': _coverImage?.toJson(),
        'logo': _logo?.toJson(),
        'gallery': _gallery?.map((e) => e.toJson()).toList(),
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
        'placeFeatures': _placeFeatures?.map((e) => e.toJson()).toList(),
        'created_by': _createdBy?.toJson(),
        'lastUpdatedBy': _lastUpdatedBy?.toJson(),
        'email': _email,
        'approvedReservationCount': _approvedReservationCount,
        'cancelledReservationCount': _cancelledReservationCount,
        'isDeleted': _isDeleted,
        'roomConf': _roomConf?.map((e) => e.toJson()).toList(),
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'maxExtraBedCount': _maxExtraBedCount,
        'price': _price,
        'hiddenPrice': _hiddenPrice,
        'unitType': _unitType,
        'groupUnit': _groupUnit,
        'featureIcons': _featureIcons?.map((e) => e.toJson()).toList(),
        'roomTypeCounts': _roomTypeCounts?.map((e) => e.toJson()).toList(),
        'nightCount': _nightCount,
      };
}

// ---------- Helpers ----------

class LocationInfo {
  LocationInfo({String? type, List<double>? coordinates})
      : _type = type,
        _coordinates = coordinates;

  factory LocationInfo.fromJson(dynamic json) => LocationInfo(
        type: json['type'] as String?,
        coordinates: (json['coordinates'] as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList(),
      );

  String? _type;
  List<double>? _coordinates;

  String? get type => _type;
  List<double> get coordinates => _coordinates ?? const [];

  Map<String, dynamic> toJson() => {
        'type': _type,
        'coordinates': _coordinates,
      };
}

class BreakfastPrice {
  BreakfastPrice({int? age, dynamic price})
      : _age = age,
        _price = price;

  factory BreakfastPrice.fromJson(dynamic json) =>
      BreakfastPrice(age: json['age'] as int?, price: json['price']);

  int? _age;
  dynamic _price;

  int? get age => _age;
  dynamic get price => _price;

  Map<String, dynamic> toJson() => {
        'age': _age,
        'price': _price,
      };
}

class PlaceTypeInfo {
  PlaceTypeInfo({
    String? id,
    LocalizedName? name,
    String? icon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? code,
  })  : _id = id,
        _name = name,
        _icon = icon,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _code = code;

  factory PlaceTypeInfo.fromJson(dynamic json) => PlaceTypeInfo(
        id: json['_id'] as String?,
        name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
        icon: json['icon'] is Map
            ? (json['icon']['_id']?.toString())
            : json['icon']?.toString(),
        isDeleted: json['isDeleted'] as bool?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        code: json['code'] as String?,
      );

  String? _id;
  LocalizedName? _name;
  String? _icon;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _code;

  String? get id => _id;
  LocalizedName? get name => _name;
  String? get icon => _icon;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get code => _code;

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'name': _name?.toJson(),
        'icon': _icon,
        'isDeleted': _isDeleted,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'code': _code,
      };
}

class CityInfo {
  CityInfo({
    String? id,
    LocalizedName? name,
    String? image,
    String? createdBy,
    String? lastUpdatedBy,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  })  : _id = id,
        _name = name,
        _image = image,
        _createdBy = createdBy,
        _lastUpdatedBy = lastUpdatedBy,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory CityInfo.fromJson(dynamic json) => CityInfo(
        id: json['_id'] as String?,
        name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
        image: json['image']?.toString(),
        createdBy: json['createdBy']?.toString(),
        lastUpdatedBy: json['lastUpdatedBy']?.toString(),
        isDeleted: json['isDeleted'] as bool?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
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

class UnitPlaceFeature {
  UnitPlaceFeature({LocalizedName? name, LocalizedName? description})
      : _name = name,
        _description = description;

  factory UnitPlaceFeature.fromJson(dynamic json) => UnitPlaceFeature(
        name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
        description: json['description'] != null
            ? LocalizedName.fromJson(json['description'])
            : null,
      );

  LocalizedName? _name;
  LocalizedName? _description;

  LocalizedName? get name => _name;
  LocalizedName? get description => _description;

  Map<String, dynamic> toJson() => {
        'name': _name?.toJson(),
        'description': _description?.toJson(),
      };
}

class UnitRoomConf {
  UnitRoomConf({
    RoomTypeInfo? roomType,
    int? adultCount,
    int? childCount,
    List<BedConf>? bedConf,
  })  : _roomType = roomType,
        _adultCount = adultCount,
        _childCount = childCount,
        _bedConf = bedConf;

  factory UnitRoomConf.fromJson(dynamic json) => UnitRoomConf(
        roomType:
            json['roomType'] != null ? RoomTypeInfo.fromJson(json['roomType']) : null,
        adultCount: json['adultCount'] as int?,
        childCount: json['childCount'] as int?,
        bedConf: (json['bedConf'] as List<dynamic>?)
            ?.map((e) => BedConf.fromJson(e))
            .toList(),
      );

  RoomTypeInfo? _roomType;
  int? _adultCount;
  int? _childCount;
  List<BedConf>? _bedConf;

  RoomTypeInfo? get roomType => _roomType;
  int? get adultCount => _adultCount;
  int? get childCount => _childCount;
  List<BedConf> get bedConf => _bedConf ?? const [];

  Map<String, dynamic> toJson() => {
        'roomType': _roomType?.toJson(),
        'adultCount': _adultCount,
        'childCount': _childCount,
        'bedConf': _bedConf?.map((e) => e.toJson()).toList(),
      };
}

class RoomTypeInfo {
  RoomTypeInfo({
    String? id,
    LocalizedName? name,
    FileInfo? icon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  })  : _id = id,
        _name = name,
        _icon = icon,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory RoomTypeInfo.fromJson(dynamic json) {
    if (json is String) {
      return RoomTypeInfo(id: json);
    }
    if (json is! Map<String, dynamic>) {
      return RoomTypeInfo();
    }
    return RoomTypeInfo(
      id: json['_id'] as String?,
      name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
      icon: json['icon'] != null ? FileInfo.fromJson(json['icon']) : null,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  String? _id;
  LocalizedName? _name;
  FileInfo? _icon;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  LocalizedName? get name => _name;
  FileInfo? get icon => _icon;
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
}

class BedConf {
  BedConf({int? count, BedTypeInfo? bedType})
      : _count = count,
        _bedType = bedType;

  factory BedConf.fromJson(dynamic json) => BedConf(
        count: json['count'] as int?,
        bedType:
            json['bedType'] != null ? BedTypeInfo.fromJson(json['bedType']) : null,
      );

  int? _count;
  BedTypeInfo? _bedType;

  int? get count => _count;
  BedTypeInfo? get bedType => _bedType;

  Map<String, dynamic> toJson() => {
        'count': _count,
        'bedType': _bedType?.toJson(),
      };
}

class BedTypeInfo {
  BedTypeInfo({
    String? id,
    LocalizedName? name,
    String? icon,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  })  : _id = id,
        _name = name,
        _icon = icon,
        _isDeleted = isDeleted,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory BedTypeInfo.fromJson(dynamic json) {
    // Case 1: backend sends just an id string
    if (json is String) {
      return BedTypeInfo(id: json);
    }

    // Case 2: null or unexpected type
    if (json is! Map<String, dynamic>) {
      return BedTypeInfo();
    }

    // Case 3: normal object
    final map = json;
    return BedTypeInfo(
      id: map['_id'] as String?,
      name: map['name'] != null ? LocalizedName.fromJson(map['name']) : null,
      icon: map['icon']?.toString(),
      isDeleted: map['isDeleted'] as bool?,
      createdAt: map['createdAt'] as String?,
      updatedAt: map['updatedAt'] as String?,
    );
  }

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

class RoomTypeCount {
  RoomTypeCount({int? count, LocalizedName? name, FileInfo? icon})
      : _count = count,
        _name = name,
        _icon = icon;

  factory RoomTypeCount.fromJson(dynamic json) => RoomTypeCount(
        count: json['count'] as int?,
        name: json['name'] != null ? LocalizedName.fromJson(json['name']) : null,
        icon: json['icon'] != null ? FileInfo.fromJson(json['icon']) : null,
      );

  int? _count;
  LocalizedName? _name;
  FileInfo? _icon;

  int? get count => _count;
  LocalizedName? get name => _name;
  FileInfo? get icon => _icon;

  Map<String, dynamic> toJson() => {
        'count': _count,
        'name': _name?.toJson(),
        'icon': _icon?.toJson(),
      };
}

// -------- Shared helpers --------

class LocalizedName {
  LocalizedName({String? en, String? ar})
      : _en = en,
        _ar = ar;

  factory LocalizedName.fromJson(dynamic json) {
    // Case 1: backend sent a plain string
    if (json is String) {
      return LocalizedName(en: json, ar: json);
    }

    // Case 2: normal map { "en": "...", "ar": "..." }
    if (json is Map<String, dynamic>) {
      return LocalizedName(
        en: json['en'] as String?,
        ar: json['ar'] as String?,
      );
    }
     return LocalizedName();
  }
   String? _en;
  String? _ar;

  String? get en => _en;
  String? get ar => _ar;

  Map<String, dynamic> toJson() => {
        'en': _en,
        'ar': _ar,
      };
}

class FileInfo {
  FileInfo({
    String? id,
    String? name,
    String? url,
    String? createdAt,
    String? updatedAt,
    String? type,
  })  : _id = id,
        _name = name,
        _url = url,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _type = type;

  factory FileInfo.fromJson(dynamic json) => FileInfo(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        url: json['url'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        type: json['type'] as String?,
      );

  String? _id;
  String? _name;
  String? _url;
  String? _createdAt;
  String? _updatedAt;
  String? _type;

  String? get id => _id;
  String? get name => _name;
  String? get url => _url;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get type => _type;

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'name': _name,
        'url': _url,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'type': _type,
      };
}

class UserInfo {
  UserInfo({
    String? id,
    String? email,
    String? fullName,
    bool? sales,
    num? commission,
    num? reservationNumber,
    bool? isDeleted,
    String? lang,
    String? createdAt,
    String? updatedAt,
    String? lastLoginAt,
    String? fcmToken,
  })  : _id = id,
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

  factory UserInfo.fromJson(dynamic json) {
    if (json is String) {
      return UserInfo(id: json);
    }
    if (json is! Map<String, dynamic>) {
      return UserInfo();
    }
    final map = json;
    return UserInfo(
      id: map['_id'] as String?,
      email: map['email'] as String?,
      fullName: map['fullName'] as String?,
      sales: map['sales'] as bool?,
      commission: map['commission'],
      reservationNumber: map['reservationNumber'],
      isDeleted: map['isDeleted'] as bool?,
      lang: map['lang'] as String?,
      createdAt: map['createdAt'] as String?,
      updatedAt: map['updatedAt'] as String?,
      lastLoginAt: map['lastLoginAt'] as String?,
      fcmToken: map['fcmToken'] as String?,
    );
  }

  String? _id;
  String? _email;
  String? _fullName;
  bool? _sales;
  num? _commission;
  num? _reservationNumber;
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
  num? get reservationNumber => _reservationNumber;
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

class ParentUnitInfo {
  ParentUnitInfo({
    String? id,
    LocalizedName? name,
    String? unitNumber,
    LocalizedName? description,
    bool? reservable,
    bool? status,
    LocationInfo? location,
    List<BreakfastPrice>? breakfastPrice,
    int? adultCount,
    int? childCount,
    int? roomCount,
  })  : _id = id,
        _name = name,
        _unitNumber = unitNumber,
        _description = description,
        _reservable = reservable,
        _status = status,
        _location = location,
        _breakfastPrice = breakfastPrice,
        _adultCount = adultCount,
        _childCount = childCount,
        _roomCount = roomCount;

  factory ParentUnitInfo.fromJson(dynamic j) {
    if (j is! Map<String, dynamic>) return ParentUnitInfo();

    return ParentUnitInfo(
      id: j['_id'],
      name: j['name'] != null ? LocalizedName.fromJson(j['name']) : null,
      unitNumber: j['unitNumber'],
      description:
          j['description'] != null ? LocalizedName.fromJson(j['description']) : null,
      reservable: j['reservable'],
      status: j['status'],
      location:
          j['location'] != null ? LocationInfo.fromJson(j['location']) : null,
      breakfastPrice: (j['breakfastPrice'] as List<dynamic>?)
          ?.map((e) => BreakfastPrice.fromJson(e))
          .toList(),
      adultCount: j['adultCount'],
      childCount: j['childCount'],
      roomCount: j['roomCount'],
    );
  }

  final String? _id;
  final LocalizedName? _name;
  final String? _unitNumber;
  final LocalizedName? _description;
  final bool? _reservable;
  final bool? _status;
  final LocationInfo? _location;
  final List<BreakfastPrice>? _breakfastPrice;
  final int? _adultCount;
  final int? _childCount;
  final int? _roomCount;

  String? get id => _id;
  LocalizedName? get name => _name;
  String? get unitNumber => _unitNumber;
  LocalizedName? get description => _description;
  bool? get reservable => _reservable;
  bool? get status => _status;
  LocationInfo? get location => _location;
  List<BreakfastPrice> get breakfastPrice => _breakfastPrice ?? [];
  int? get adultCount => _adultCount;
  int? get childCount => _childCount;
  int? get roomCount => _roomCount;

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'name': _name?.toJson(),
        'unitNumber': _unitNumber,
        'description': _description?.toJson(),
        'reservable': _reservable,
        'status': _status,
        'location': _location?.toJson(),
        'breakfastPrice': _breakfastPrice?.map((e) => e.toJson()).toList(),
        'adultCount': _adultCount,
        'childCount': _childCount,
        'roomCount': _roomCount,
      };
}
