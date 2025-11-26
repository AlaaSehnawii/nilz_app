import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/loading/app_circular_progress_widget.dart';
import 'package:nilz_app/core/widget/bar/note_message.dart';
import 'package:nilz_app/router/app_router.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import '../../domain/entity/request/login_request_entity.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  LoginRequestEntity entity = LoginRequestEntity();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppHeightManager.h15),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppWidthManager.w3Point8,
                    vertical: AppHeightManager.h2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextWidget(
                        text: "welcome_back".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs18,
                        color: AppColorManager.denim,
                      ),
                      SizedBox(height: 20,),
                      SvgPicture.asset(AppIconManager.nilz, height: 70, width: 70,),
                      SizedBox(height: AppHeightManager.h3),
                      AppTextWidget(
                        text: "login_to_continue".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs16,
                        color: AppColorManager.denim,
                      ),
                      SizedBox(height: AppHeightManager.h8),
                      TitleAppFormFiled(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        hint: 'email'.tr(),
                        title: 'email'.tr(),
                        onChanged: (value) {
                          entity.email = value ?? "";
                          return value;
                        },
                      ),
                      SizedBox(height: AppHeightManager.h2),
                      TitleAppFormFiled(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        hint: 'password'.tr(),
                        title: 'password'.tr(),
                        onChanged: (value) {
                          entity.password = value ?? "";
                          return value;
                        },
                      ),
                      SizedBox(height: AppHeightManager.h5),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state.status == CubitStatus.error) {
                            NoteMessage.showErrorSnackBar(
                              context: context,
                              text: state.error,
                            );
                          }
                          if (state.status == CubitStatus.success) {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRouterScreenNames.dashboard);
                          }
                        },
                        builder: (context, state) {
                          if (state.status == CubitStatus.loading) {
                            return const AppCircularProgressWidget();
                          }
                          return MainAppButton(
                            onTap: () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<LoginCubit>().login(
                                  context: context,
                                  entity: entity,
                                );
                              }
                            },
                            alignment: Alignment.center,
                            width: AppWidthManager.w50,
                            borderRadius: BorderRadius.circular(20),
                            color: AppColorManager.denim,
                            padding: EdgeInsets.symmetric(
                              horizontal: AppWidthManager.w3Point8,
                              vertical: AppHeightManager.h1point5,
                            ),
                            child: AppTextWidget(
                              text: "login".tr(),
                              fontSize: FontSizeManager.fs16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
