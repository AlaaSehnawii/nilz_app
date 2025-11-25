import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resource/icon_manager.dart';
import '../form_field/text_form_field.dart';

class SimpleOption {
  final String id;
  final String label;

  SimpleOption({required this.id, required this.label});
}

class AddEntityResult {
  final String nameAr;
  final String nameEn;
  final String? imageName;
  final String? base64;
  final String? cityId;
  final bool? status;

  AddEntityResult({
    required this.nameAr,
    required this.nameEn,
    this.imageName,
    this.base64,
    this.cityId,
    this.status,
  });
}

Future<AddEntityResult?> showGenericAddDialog(
  BuildContext context, {
  required String title,
  required String nameArHint,
  required String nameEnHint,
  bool enableImage = false,
  bool enableCity = false,
  bool enableStatus = false,
  String pickImageText = 'Pick Image',
  String noImageSelectedText = 'No image selected',
  List<SimpleOption> cityOptions = const [],
  String cityLabel = 'City',
  String cityHint = 'Select city',
  String? initialCityId,
  String statusLabel = 'Active',
  bool? initialStatus,
  String? initialNameAr,
  String? initialNameEn,

  String confirmText = 'OK',
  String cancelText = 'Cancel',
}) async {
  final formKey = GlobalKey<FormState>();
  final arCtrl = TextEditingController(text: initialNameAr ?? '');
  final enCtrl = TextEditingController(text: initialNameEn ?? '');

  String? imageName;
  String? imageBase64;
  String? cityId = initialCityId;
  bool? status = initialStatus;

  XFile? picked;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file == null) return;
    picked = file;
    final bytes = await file.readAsBytes();
    imageBase64 = base64Encode(bytes);
    imageName = p.basename(file.path);
  }

  return showDialog<AddEntityResult?>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return StatefulBuilder(
        builder: (ctx, setState) {
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
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
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
                          DropdownButtonFormField<String>(
                            initialValue: cityId,
                            isExpanded: true,
                            decoration: InputDecoration(
                              hintText: cityHint,
                              filled: true,
                              fillColor: const Color(0xFFF7F9FC),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColorManager.denim.withOpacity(
                                    0.25,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColorManager.denim.withOpacity(
                                    0.25,
                                  ),
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
                                  value: status ?? false,
                                  onChanged: (v) => setState(() => status = v),
                                  activeColor: AppColorManager.denim,
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

                        // Optional: Image
                        if (enableImage) ...[
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              pickImageText,
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
                              child: Container(
                                width: 124,
                                height: 124,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F1),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: picked == null
                                    ? Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 54,
                                              height: 54,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Colors.black12,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: SvgPicture.asset(
                                                  AppIconManager.photos,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(22),
                                        child: Image.file(
                                          File(picked!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          if ((imageName ?? '').isNotEmpty) ...[
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
                                    imageName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 22),
                        ],
                        const Divider(height: 1, color: Color(0xFFE8E8EC)),
                        const SizedBox(height: 16),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(ctx, null),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(56),
                                  side: BorderSide(
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
                                  if (!formKey.currentState!.validate()) return;
                                  Navigator.pop(
                                    ctx,
                                    AddEntityResult(
                                      nameAr: arCtrl.text.trim(),
                                      nameEn: enCtrl.text.trim(),
                                      imageName:imageName ,
                                      base64: imageBase64,
                                      cityId: enableCity ? cityId : null,
                                      status: enableStatus
                                          ? (status ?? false)
                                          : null,
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
      );
    },
  );
}
