import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/dialog/generic_add_dialog.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../text_form_field/text_form_field.dart';

class EditEntityResult {
  final String? nameAr;
  final String? nameEn;
  final String? imageName;
  final String? base64;
  final bool? status;
  final String? cityId;
  final bool removeImage;

  const EditEntityResult({
    this.nameAr,
    this.nameEn,
    this.imageName,
    this.base64,
    this.status,
    this.cityId,
    this.removeImage = false,
  });

  bool get hasAnyChange =>
      nameAr != null || nameEn != null || (imageName != null && base64 != null);
}

Future<EditEntityResult?> showGenericEditDialog(
  BuildContext context, {
  required String title,
  String? initialNameAr,
  String? initialNameEn,
  String? initialImageName,
  String? initialImageBase64,
  String? initialImageUrl,
  String? initialCityId,
  required String nameArHint,
  required String nameEnHint,
  required String pickImageText,
  required String noImageSelectedText,
  bool enableImage = false,
  bool enableCity = false,
  bool enableStatus = false,
  String confirmText = 'save',
  String cancelText = 'cancel',
  String cityLabel = 'City',
  String cityHint = 'Select City',
  List<SimpleOption> cityOptions = const [],
  bool showStatus = false,
  bool? initialStatus,
  String statusLabel = 'Status',
}) async {
  final arCtrl = TextEditingController(text: initialNameAr ?? '');
  final enCtrl = TextEditingController(text: initialNameEn ?? '');
  String? pickedImageName;
  String? pickedBase64;
  String? cityId = initialCityId;
  bool status = initialStatus ?? false;

  XFile? picked;
  bool removeImage = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    pickedBase64 = base64Encode(bytes);
    pickedImageName = p.basename(file.path);
    picked = file;
  }

  return showDialog<EditEntityResult?>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) {
        debugPrint("enableImage: $enableImage");
        debugPrint("enableStatus: $enableStatus , status: $status");

        return SingleChildScrollView(
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 48,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                splashRadius: 22,
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black54,
                                ),
                                onPressed: () => Navigator.pop(ctx, null),
                              ),
                            ),
                            Text(
                              title,
                              style: const TextStyle(
                                color: AppColorManager.textAppColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 600;
                          final gap = isWide ? 20.0 : 12.0;

                          final nameArField = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameArHint,
                                style: TextStyle(
                                  color: AppColorManager.textAppColor,
                                  fontSize: 16.sp.clamp(14, 18).toDouble(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MyTextFormField(
                                controller: arCtrl,
                                hintText: nameArHint,
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                              ),
                            ],
                          );

                          final nameEnField = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameEnHint,
                                style: TextStyle(
                                  color: AppColorManager.textAppColor,
                                  fontSize: 16.sp.clamp(14, 18).toDouble(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MyTextFormField(
                                controller: enCtrl,
                                hintText: nameEnHint,
                                hintTextStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColorManager.textGrey,
                                ),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                              ),
                            ],
                          );

                          if (isWide) {
                            return Row(
                              children: [
                                Expanded(child: nameArField),
                                SizedBox(width: gap),
                                Expanded(child: nameEnField),
                              ],
                            );
                          }
                          return Column(
                            children: [
                              nameArField,
                              SizedBox(height: gap),
                              nameEnField,
                            ],
                          );
                        },
                      ),

                      //  City Drop Down
                      if (enableCity) ...[
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            cityLabel,
                            style: TextStyle(
                              color: AppColorManager.textAppColor,
                              fontSize: 16.sp.clamp(14, 18).toDouble(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Builder(
                          builder: (context) {
                            final validIds = cityOptions.map((o) => o.id).toSet();
                            final String? effectiveCityId =
                            (cityId != null && validIds.contains(cityId)) ? cityId : null;

                            debugPrint(
                              'EditDialog city -> enableCity: $enableCity, '
                                  'cityOptions: ${cityOptions.length}, '
                                  'initialCityId: $initialCityId, '
                                  'effectiveCityId: $effectiveCityId',
                            );

                            return DropdownButtonFormField<String>(
                              initialValue: effectiveCityId,
                              isExpanded: true,
                              decoration: InputDecoration(
                                hintText: cityHint,
                                filled: true,
                                fillColor: const Color(0xFFF7F9FC),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    // ignore: deprecated_member_use
                                    color: AppColorManager.denim.withOpacity(0.25),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    // ignore: deprecated_member_use
                                    color: AppColorManager.denim.withOpacity(0.25),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColorManager.denim,
                                    width: 1.5,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                              items: cityOptions
                                  .map(
                                    (o) => DropdownMenuItem<String>(
                                  value: o.id,
                                  child: Text(o.label),
                                ),
                              )
                                  .toList(),
                              onChanged: (v) => setState(() => cityId = v),
                            );
                          },
                        ),
                      ],

                      // Status slider
                      if (enableStatus) ...[
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Switch(
                                value: status,
                                onChanged: (v) {
                                  setState(() {
                                    status = v;
                                  });
                                },
                                activeThumbColor: AppColorManager.denim,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                statusLabel,
                                style: TextStyle(
                                  color: AppColorManager.textAppColor,
                                  fontSize: 16.sp.clamp(14, 18).toDouble(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Optional Image
                      if (enableImage) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Icon',
                            style: TextStyle(
                              color: AppColorManager.textAppColor,
                              fontSize: 16.sp.clamp(14, 18).toDouble(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () async {
                              await pickImage();
                              setState(() {});
                            },
                            borderRadius: BorderRadius.circular(22),
                            child: Stack(
                              children: [
                                Container(
                                  width: 124,
                                  height: 124,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F0F1),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: picked != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                          child: Image.file(
                                            File(picked!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : (!removeImage &&
                                            (initialImageUrl != null &&
                                                initialImageUrl.isNotEmpty))
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                          child: Image.network(
                                            initialImageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Center(
                                          child: SvgPicture.asset(
                                            AppIconManager.photos,
                                            // ignore: deprecated_member_use
                                            color: Colors.black38,
                                          ),
                                        ),
                                ),

                                if (picked != null ||
                                    (!removeImage &&
                                        initialImageUrl != null &&
                                        initialImageUrl.isNotEmpty))
                                  Positioned(
                                    right: 6,
                                    top: 6,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          picked = null;
                                          pickedBase64 = null;
                                          pickedImageName = null;
                                          removeImage = true;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black45,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        if (pickImageText.isNotEmpty) ...[
                          Row(
                            children: [
                              const Icon(
                                Icons.insert_drive_file_rounded,
                                size: 18,
                                color: Colors.black45,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  pickImageText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                        ],
                      ],

                      const Divider(height: 1, color: Color(0xFFE8E8EC)),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(ctx, null),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56),
                                side: BorderSide(
                                  // ignore: deprecated_member_use
                                  color: AppColorManager.denim.withOpacity(
                                    0.25,
                                  ),
                                ),
                                backgroundColor: const Color(0xFFF7F9FC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                cancelText,
                                style: TextStyle(
                                  color: AppColorManager.denim,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Save
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(ctx).unfocus();

                                Navigator.pop(
                                  ctx,
                                  EditEntityResult(
                                    nameAr: arCtrl.text.trim(),
                                    nameEn: enCtrl.text.trim(),
                                    imageName: pickedImageName,
                                    base64: pickedBase64,
                                    cityId: enableCity ? cityId : null,
                                    status: enableStatus ? status : null,
                                    removeImage: removeImage,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56),
                                backgroundColor: AppColorManager.denim,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                confirmText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
