import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/widget/app_bar/title_app_bar.dart';
import '../../../../core/widget/text_form_field/text_form_field.dart';

class CreateReservationScreen extends StatelessWidget {
  const CreateReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.background,
      appBar: MainAppBar(
        title: 'add_reservation'.tr(),
        showArrowBack: false,
        showSuffixIcon: false,
      ),
      body: Column(
        children: [
          MyTextFormField(hintText: "city".tr()),
          Row(children: [Container(), Container()]),
          MyTextFormField(),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                color: AppColorManager.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
