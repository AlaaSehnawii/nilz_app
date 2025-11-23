import 'dart:ui';

import 'package:nilz_app/core/resource/color_manager.dart';

import 'icon_manager.dart';

/// Eng.Nour Othman(meory)* 23/10/2024

abstract class EnumManager {
  Map<String, num> propertyStateCode = {
    all: 0,
    occupied: 1,
    vacant: 2,
    disabled: 3,
  };

  static List<String> propertyState = [all, occupied, vacant, disabled];

  static String all = "all";
  static String occupied = "occupied";
  static String vacant = "vacant";
  static String disabled = "disabled";

  static int allCode = 0;
  static int occupiedCode = 1;
  static int vacantCode = 2;
  static int disabledCode = 3;

  static String allPayment = "all";
  static String pending = "pending";
  static String due = "due";
  static String paid = "paid";
  static String overdue = "overdue";

  static int allPaymentCode = 0;
  static int upcomingCode = 1;
  static int dueCode = 2;
  static int paidCode = 4;
  static int overdueCode = 3;

  //////clients
  static String allClients = "all";
  static String active = "Active";
  static String former = "Former";

  static int allClientsCode = 0;
  static int activeCode = 1;
  static int formerCode = 2;

  static Map<String, Color> propertyStatusColor = {
    occupied: AppColorManager.green,
    vacant: AppColorManager.red,
    disabled: AppColorManager.grey,
    "": AppColorManager.black,
  };
  static Map<String, Color> paymentStatusColor = {
    "Paid": AppColorManager.green,
    "Pending": AppColorManager.purple,
    "Due": AppColorManager.blue,
    "Upcoming": AppColorManager.blue,
    "": AppColorManager.grey,
  };
  static Map<String, String> propertyStatusIcon = {
    occupied: AppIconManager.done,
    vacant: AppIconManager.test,
    disabled: AppIconManager.square,
    "": AppIconManager.done,
  };

  static Map<String, Color> clientStatusColor = {
    "all": AppColorManager.background,
    "Active": AppColorManager.green,
    "Former": AppColorManager.red,
  };
  static Map<String, String> clientStatusIcon = {
    "Active": AppIconManager.done, //
    "Former": AppIconManager.warning, //
    "all": AppIconManager.done,
  };
}
