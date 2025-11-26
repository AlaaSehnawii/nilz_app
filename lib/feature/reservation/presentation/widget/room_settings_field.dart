// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:nilz_app/core/resource/color_manager.dart';

import '../../../../core/resource/icon_manager.dart';

class RoomSettingsField extends StatefulWidget {
  const RoomSettingsField({
    super.key,
    required this.rooms,
    required this.onChanged,
  });

  /// Current selected rooms (from the screen)
  final List<RoomInfo> rooms;

  /// Called when user presses "Done" in dialog
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
    // create a local editable copy
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
              if (newValue < 0) return; // min 0 adult
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
                if (room.childrenNames.length < newValue) {
                  room.childrenNames.addAll(
                    List<String>.generate(
                      newValue - room.childrenNames.length,
                      (_) => '',
                    ),
                  );
                } else if (room.childrenNames.length > newValue) {
                  room.childrenNames = room.childrenNames.sublist(0, newValue);
                }
              });
            }

            return AlertDialog(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          onPressed: () => removeRoom(index),
                                        ),
                                    ],
                                  ),

                                  SizedBox(height: 1.h),

                                  // Adults row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('adults'.tr()),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              AppIconManager.minusCircle,
                                              color: AppColorManager.denim,
                                            ),
                                            onPressed: () =>
                                                changeAdults(index, -1),
                                          ),
                                          Text(
                                            room.adults.toString(),
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              AppIconManager.addCircle,
                                              color: AppColorManager.denim,
                                            ),
                                            onPressed: () =>
                                                changeAdults(index, 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 0.5.h),

                                  // Children row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('children'.tr()),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              AppIconManager.minusCircle,
                                              color: AppColorManager.denim,
                                            ),
                                            onPressed: () =>
                                                changeChildren(index, -1),
                                          ),
                                          Text(
                                            room.children.toString(),
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              AppIconManager.addCircle,
                                              color: AppColorManager.denim,
                                            ),
                                            onPressed: () =>
                                                changeChildren(index, 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Children name fields
                                  if (room.children > 0) ...[
                                    SizedBox(height: 1.h),
                                    Column(
                                      children: List.generate(room.children, (
                                        childIndex,
                                      ) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 0.8.h,
                                          ),
                                          child: TextFormField(
                                            initialValue:
                                                room.childrenNames.length >
                                                    childIndex
                                                ? room.childrenNames[childIndex]
                                                : '',
                                            onChanged: (value) {
                                              room.childrenNames[childIndex] =
                                                  value;
                                            },
                                            decoration: const InputDecoration(
                                              isDense: true,
                                              border: OutlineInputBorder(),
                                              labelText: 'Child name',
                                            ),
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
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('cancel'.tr()),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(tempRooms),
                  child: Text('done'.tr()),
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
    return TextFormField(
      controller: _summaryController,
      readOnly: true,
      onTap: _openDialog,
      decoration: InputDecoration(
        fillColor: AppColorManager.background.withOpacity(0),
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorManager.backgroundGrey,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorManager.denim.withOpacity(0.6),
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: 'room_settings'.tr(),
        hintStyle: TextStyle(fontSize: 14.sp, color: AppColorManager.textGrey),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      style: TextStyle(fontSize: 14.sp, color: AppColorManager.textAppColor),
      cursorColor: AppColorManager.textAppColor,
    );
  }
}
