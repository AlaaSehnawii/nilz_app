import 'dart:convert';


ResStatisticsApiResponseEntity resStatisticsApiResponseEntityFromJson(String str) => ResStatisticsApiResponseEntity.fromJson(json.decode(str));
String resStatisticsApiResponseEntityToJson(ResStatisticsApiResponseEntity data) => json.encode(data.toJson());

class ResStatisticsApiResponseEntity {
  ResStatisticsApiResponseEntity({
    ResStatisticsResponseEntity? data,
  }) {
    _data = data;
  }

  ResStatisticsApiResponseEntity.fromJson(dynamic json) {
    _data = json['data'] != null ? ResStatisticsResponseEntity.fromJson(json['data']) : null;
  }

  ResStatisticsResponseEntity? _data;

  ResStatisticsApiResponseEntity copyWith({ResStatisticsResponseEntity? data}) => ResStatisticsApiResponseEntity(
    data: data ?? _data,
  );

  ResStatisticsResponseEntity? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}


class ResStatisticsResponseEntity {
  ResStatisticsResponseEntity({
    ResStatisticsCategoryEntity? reservation,
    ResStatisticsCategoryEntity? pending,
    ResStatisticsCategoryEntity? approved,
    ResStatisticsCategoryEntity? booked,
    ResStatisticsCategoryEntity? cancelledByClient,
    ResStatisticsCategoryEntity? cancelledByAdmin,
    ResStatisticsCategoryEntity? rejected,
    ResStatisticsCategoryEntity? rejectedByHotel,
    ResStatisticsCategoryEntity? approvedClients,
    ResStatisticsCategoryEntity? clients,
    ResStatisticsCategoryEntity? approvedNewClients,
  }) {
    _reservation = reservation;
    _pending = pending;
    _approved = approved;
    _booked = booked;
    _cancelledByClient = cancelledByClient;
    _cancelledByAdmin = cancelledByAdmin;
    _rejected = rejected;
    _rejectedByHotel = rejectedByHotel;
    _approvedClients = approvedClients;
    _clients = clients;
    _approvedNewClients = approvedNewClients;
  }

  ResStatisticsResponseEntity.fromJson(dynamic json) {
    _reservation = json['reservation'] != null ? ResStatisticsCategoryEntity.fromJson(json['reservation']) : null;
    _pending = json['Pending'] != null ? ResStatisticsCategoryEntity.fromJson(json['Pending']) : null;
    _approved = json['Approved'] != null ? ResStatisticsCategoryEntity.fromJson(json['Approved']) : null;
    _booked = json['Booked'] != null ? ResStatisticsCategoryEntity.fromJson(json['Booked']) : null;
    _cancelledByClient = json['Cancelled by client'] != null ? ResStatisticsCategoryEntity.fromJson(json['Cancelled by client']) : null;
    _cancelledByAdmin = json['Cancelled by admin'] != null ? ResStatisticsCategoryEntity.fromJson(json['Cancelled by admin']) : null;
    _rejected = json['Rejected'] != null ? ResStatisticsCategoryEntity.fromJson(json['Rejected']) : null;
    _rejectedByHotel = json['Rejected By Hotel'] != null ? ResStatisticsCategoryEntity.fromJson(json['Rejected By Hotel']) : null;
    _approvedClients = json['approvedClients'] != null ? ResStatisticsCategoryEntity.fromJson(json['approvedClients']) : null;
    _clients = json['clients'] != null ? ResStatisticsCategoryEntity.fromJson(json['clients']) : null;
    _approvedNewClients = json['approvedNewClients'] != null ? ResStatisticsCategoryEntity.fromJson(json['approvedNewClients']) : null;
  }

  ResStatisticsCategoryEntity? _reservation;
  ResStatisticsCategoryEntity? _pending;
  ResStatisticsCategoryEntity? _approved;
  ResStatisticsCategoryEntity? _booked;
  ResStatisticsCategoryEntity? _cancelledByClient;
  ResStatisticsCategoryEntity? _cancelledByAdmin;
  ResStatisticsCategoryEntity? _rejected;
  ResStatisticsCategoryEntity? _rejectedByHotel;
  ResStatisticsCategoryEntity? _approvedClients;
  ResStatisticsCategoryEntity? _clients;
  ResStatisticsCategoryEntity? _approvedNewClients;

  ResStatisticsResponseEntity copyWith({
    ResStatisticsCategoryEntity? reservation,
    ResStatisticsCategoryEntity? pending,
    ResStatisticsCategoryEntity? approved,
    ResStatisticsCategoryEntity? booked,
    ResStatisticsCategoryEntity? cancelledByClient,
    ResStatisticsCategoryEntity? cancelledByAdmin,
    ResStatisticsCategoryEntity? rejected,
    ResStatisticsCategoryEntity? rejectedByHotel,
    ResStatisticsCategoryEntity? approvedClients,
    ResStatisticsCategoryEntity? clients,
    ResStatisticsCategoryEntity? approvedNewClients,
  }) => ResStatisticsResponseEntity(
    reservation: reservation ?? _reservation,
    pending: pending ?? _pending,
    approved: approved ?? _approved,
    booked: booked ?? _booked,
    cancelledByClient: cancelledByClient ?? _cancelledByClient,
    cancelledByAdmin: cancelledByAdmin ?? _cancelledByAdmin,
    rejected: rejected ?? _rejected,
    rejectedByHotel: rejectedByHotel ?? _rejectedByHotel,
    approvedClients: approvedClients ?? _approvedClients,
    clients: clients ?? _clients,
    approvedNewClients: approvedNewClients ?? _approvedNewClients,
  );

  ResStatisticsCategoryEntity? get reservation => _reservation;
  ResStatisticsCategoryEntity? get pending => _pending;
  ResStatisticsCategoryEntity? get approved => _approved;
  ResStatisticsCategoryEntity? get booked => _booked;
  ResStatisticsCategoryEntity? get cancelledByClient => _cancelledByClient;
  ResStatisticsCategoryEntity? get cancelledByAdmin => _cancelledByAdmin;
  ResStatisticsCategoryEntity? get rejected => _rejected;
  ResStatisticsCategoryEntity? get rejectedByHotel => _rejectedByHotel;
  ResStatisticsCategoryEntity? get approvedClients => _approvedClients;
  ResStatisticsCategoryEntity? get clients => _clients;
  ResStatisticsCategoryEntity? get approvedNewClients => _approvedNewClients;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_reservation != null) map['reservation'] = _reservation?.toJson();
    if (_pending != null) map['Pending'] = _pending?.toJson();
    if (_approved != null) map['Approved'] = _approved?.toJson();
    if (_booked != null) map['Booked'] = _booked?.toJson();
    if (_cancelledByClient != null) map['Cancelled by client'] = _cancelledByClient?.toJson();
    if (_cancelledByAdmin != null) map['Cancelled by admin'] = _cancelledByAdmin?.toJson();
    if (_rejected != null) map['Rejected'] = _rejected?.toJson();
    if (_rejectedByHotel != null) map['Rejected By Hotel'] = _rejectedByHotel?.toJson();
    if (_approvedClients != null) map['approvedClients'] = _approvedClients?.toJson();
    if (_clients != null) map['clients'] = _clients?.toJson();
    if (_approvedNewClients != null) map['approvedNewClients'] = _approvedNewClients?.toJson();
    return map;
  }
}

// ============ ResStatistics Category Entity ============
class ResStatisticsCategoryEntity {
  ResStatisticsCategoryEntity({
    int? currentMonthCount,
    int? previousMonthCount,
    int? countDifference,
    double? percentageChange,
    String? trend,
    int? totalCount,
  }) {
    _currentMonthCount = currentMonthCount;
    _previousMonthCount = previousMonthCount;
    _countDifference = countDifference;
    _percentageChange = percentageChange;
    _trend = trend;
    _totalCount = totalCount;
  }

  ResStatisticsCategoryEntity.fromJson(dynamic json) {
    _currentMonthCount = json['currentMonthCount'];
    _previousMonthCount = json['previousMonthCount'];
    _countDifference = json['countDifference'];
    _percentageChange = json['percentageChange'] != null ? double.parse(json['percentageChange'].toString()) : null;
    _trend = json['trend'];
    _totalCount = json['totalCount'];
  }

  int? _currentMonthCount;
  int? _previousMonthCount;
  int? _countDifference;
  double? _percentageChange;
  String? _trend;
  int? _totalCount;

  ResStatisticsCategoryEntity copyWith({
    int? currentMonthCount,
    int? previousMonthCount,
    int? countDifference,
    double? percentageChange,
    String? trend,
    int? totalCount,
  }) => ResStatisticsCategoryEntity(
    currentMonthCount: currentMonthCount ?? _currentMonthCount,
    previousMonthCount: previousMonthCount ?? _previousMonthCount,
    countDifference: countDifference ?? _countDifference,
    percentageChange: percentageChange ?? _percentageChange,
    trend: trend ?? _trend,
    totalCount: totalCount ?? _totalCount,
  );

  int? get currentMonthCount => _currentMonthCount;
  int? get previousMonthCount => _previousMonthCount;
  int? get countDifference => _countDifference;
  double? get percentageChange => _percentageChange;
  String? get trend => _trend;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentMonthCount'] = _currentMonthCount;
    map['previousMonthCount'] = _previousMonthCount;
    map['countDifference'] = _countDifference;
    map['percentageChange'] = _percentageChange;
    map['trend'] = _trend;
    map['totalCount'] = _totalCount;
    return map;
  }
}