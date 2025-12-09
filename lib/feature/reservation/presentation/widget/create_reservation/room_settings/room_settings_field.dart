// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/widget/button/main_app_button.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field/searchable_dropdown.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/create_reservation/room_settings/counter_row.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import '../../../../../../core/resource/icon_manager.dart';

class RoomSettingsField extends StatefulWidget {
  const RoomSettingsField({
    super.key,
    required this.rooms,
    required this.onChanged,
  });

  final List<RoomInfo> rooms;
  final ValueChanged<List<RoomInfo>> onChanged;

  @override
  State<RoomSettingsField> createState() => _RoomSettingsFieldState();
}

class _RoomSettingsFieldState extends State<RoomSettingsField> {
  final TextEditingController _summaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateSummary(widget.rooms);
  }

  @override
  void didUpdateWidget(covariant RoomSettingsField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rooms != widget.rooms) {
      _updateSummary(widget.rooms);
    }
  }

  void _updateSummary(List<RoomInfo> rooms) {
    if (rooms.isEmpty) {
      _summaryController.text = '';
      return;
    }
    final totalRooms = rooms.length;
    final totalAdults = rooms.fold<int>(0, (sum, r) => sum + r.adults);
    final totalChildren = rooms.fold<int>(0, (sum, r) => sum + r.children);

    _summaryController.text =
        '$totalRooms ${'rooms'.tr()}, '
        '$totalAdults ${'adults'.tr()}, '
        '$totalChildren ${'children'.tr()}';
  }

  Future<void> _openDialog() async {
    List<RoomInfo> tempRooms = widget.rooms.isEmpty
        ? [RoomInfo(adults: 0, children: 0)]
        : widget.rooms.map((r) => r.copy()).toList();

    final result = await showDialog<List<RoomInfo>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void addRoom() {
              setDialogState(() {
                tempRooms.add(RoomInfo(adults: 0, children: 0));
              });
            }

            void removeRoom(int index) {
              if (tempRooms.length == 1) return;
              setDialogState(() {
                tempRooms.removeAt(index);
              });
            }

            void changeAdults(int index, int delta) {
              final room = tempRooms[index];
              final newValue = room.adults + delta;
              if (newValue < 0) return;
              setDialogState(() {
                room.adults = newValue;
              });
            }

            void changeChildren(int index, int delta) {
              final room = tempRooms[index];
              final newValue = room.children + delta;
              if (newValue < 0) return;
              setDialogState(() {
                room.children = newValue;
                if (room.childrenAges.length < newValue) {
                  room.childrenAges.addAll(
                    List<int?>.filled(
                      newValue - room.childrenAges.length,
                      null,
                    ),
                  );
                } else if (room.childrenAges.length > newValue) {
                  room.childrenAges = room.childrenAges.sublist(0, newValue);
                }
              });
            }

            return Column(
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text('room_settings'.tr()),
                  content: SizedBox(
                    width: 90.w,
                    height: 60.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: tempRooms.length,
                            itemBuilder: (context, index) {
                              final room = tempRooms[index];
                              return Card(
                                margin: EdgeInsets.only(bottom: 1.5.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${'room'.tr()} ${index + 1}',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (tempRooms.length > 1)
                                            IconButton(
                                              icon: SvgPicture.asset(
                                                AppIconManager.delete,
                                                color: AppColorManager.grey,
                                              ),
                                              onPressed: () =>
                                                  removeRoom(index),
                                            ),
                                        ],
                                      ),

                                      SizedBox(height: 1.h),

                                      // Adults row
                                      CounterRow(
                                        label: 'adults'.tr(),
                                        value: room.adults,
                                        onDecrement: () =>
                                            changeAdults(index, -1),
                                        onIncrement: () =>
                                            changeAdults(index, 1),
                                      ),

                                      SizedBox(height: 0.5.h),

                                      // Children row
                                      CounterRow(
                                        label: 'children'.tr(),
                                        value: room.children,
                                        onDecrement: () =>
                                            changeChildren(index, -1),
                                        onIncrement: () =>
                                            changeChildren(index, 1),
                                      ),

                                      if (room.children > 0) ...[
                                        SizedBox(height: 1.h),
                                        Column(
                                          children: List.generate(room.children, (
                                            childIndex,
                                          ) {
                                            final selectedAge =
                                                room.childrenAges.length >
                                                    childIndex
                                                ? room.childrenAges[childIndex]
                                                : null;

                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 0.8.h,
                                              ),
                                              child: SearchableDropdown<int>(
                                                items: List<int>.generate(
                                                  12,
                                                  (i) => i + 1,
                                                ),
                                                selectedItem: selectedAge,
                                                labelBuilder: (age) =>
                                                    '$age ${'years'.tr()}',
                                                hintText:
                                                    '${'child_age'.tr()} ${childIndex + 1}',
                                                titleText:
                                                    '${'child'.tr()} ${childIndex + 1}',
                                                filterFn: (age, query) {
                                                  final q = query.toLowerCase();
                                                  final label =
                                                      '$age ${'years'.tr()}'
                                                          .toLowerCase();
                                                  return age
                                                          .toString()
                                                          .contains(q) ||
                                                      label.contains(q);
                                                },
                                                onChanged: (age) {
                                                  setDialogState(() {
                                                    if (room
                                                            .childrenAges
                                                            .length <=
                                                        childIndex) {
                                                      room.childrenAges.addAll(
                                                        List<int?>.filled(
                                                          childIndex +
                                                              1 -
                                                              room
                                                                  .childrenAges
                                                                  .length,
                                                          null,
                                                        ),
                                                      );
                                                    }
                                                    room.childrenAges[childIndex] =
                                                        age;
                                                  });
                                                },
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Add room button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: addRoom,
                            icon: SvgPicture.asset(
                              AppIconManager.add,
                              color: AppColorManager.denim,
                            ),
                            label: Text(
                              'add_room'.tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColorManager.denim,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    MainAppButton(
                      onTap: () => Navigator.of(context).pop(),
                      height: 40,
                      width: 70,
                      borderColor: AppColorManager.denim,
                      outLinedBorde: true,
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(10),
                      child: Text(
                        'cancel'.tr(),
                        style: TextStyle(color: AppColorManager.denim),
                      ),
                    ),
                    MainAppButton(
                      onTap: () => Navigator.of(context).pop(tempRooms),
                      height: 40,
                      width: 70,
                      borderColor: AppColorManager.denim,
                      color: AppColorManager.denim,
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(10),
                      child: Text(
                        'done'.tr(),
                        style: TextStyle(
                          color: AppColorManager.background,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        _updateSummary(result);
      });
      widget.onChanged(result);
    }
  }

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      controller: _summaryController,
      hintText: 'room_settings'.tr(),
      onTap: _openDialog,
      onChanged: (_) {},
    );
  }
}
