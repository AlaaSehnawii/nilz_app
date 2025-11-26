// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/feature/posts/domain/entity/response/post_entity.dart';

class PostContainer extends StatelessWidget {
  final PostEntity post;

  const PostContainer({super.key, required this.post});

  String _localized(LocalizedText? txt, BuildContext context) {
    if (txt == null) return "";
    return context.locale.languageCode == "ar"
        ? txt.ar ?? txt.en ?? ""
        : txt.en ?? txt.ar ?? "";
  }

  String _formatDate(BuildContext context, String? iso) {
    if (iso == null || iso.isEmpty) return "-";
    final date = DateTime.tryParse(iso);
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy', context.locale.languageCode)
        .format(date);
  }

  @override
  Widget build(BuildContext context) {
    final title = _localized(post.title, context);
    final description = _localized(post.description, context);
    final category = _localized(post.postCategory?.name, context);
    final createdAt = post.createdAt ?? "";
    final imageUrl = post.image?.url;


    final List<String> galleryImages = post.gallery
        .where((g) => g.type == null || g.type == 'image')
        .map((g) => g.url)
        .whereType<String>()
        .where((url) => url.isNotEmpty)
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                // TODO: Navigate to post detail
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= HERO IMAGE =================
                  _buildHeroImage(imageUrl, galleryImages),

                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Badge
                        if (category.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 0.8.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColorManager.denim.withOpacity(0.15),
                                  AppColorManager.denim.withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColorManager.denim.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: AppColorManager.denim,
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                        SizedBox(height: 1.8.h),

                        // Title
                        Text(
                          title.isEmpty ? "no_title".tr() : title,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColorManager.textAppColor,
                            height: 1.3,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 1.2.h),

                        // Description
                        Text(
                          description.isEmpty
                              ? "no_description".tr()
                              : description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColorManager.textAppColor
                                .withOpacity(0.75),
                            height: 1.45,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 2.5.h),

                        // Gallery Thumbnails (if exists)
                        if (galleryImages.length > 1)
                          SizedBox(
                            height: 9.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: galleryImages.length > 5
                                  ? 5
                                  : galleryImages.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: 2.w),
                              itemBuilder: (context, index) {
                                if (index == 4 &&
                                    galleryImages.length > 5) {
                                  return _buildMoreImagesThumb(
                                      galleryImages.length - 4);
                                }
                                return _galleryThumbnail(
                                    galleryImages[index]);
                              },
                            ),
                          ),

                        if (galleryImages.length > 1)
                          SizedBox(height: 2.5.h),

                        // Footer: Date + Social Icons
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 15.sp,
                                  color: AppColorManager.textAppColor
                                      .withOpacity(0.6),
                                ),
                                SizedBox(width: 1.5.w),
                                Text(
                                  _formatDate(context, createdAt),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColorManager.textAppColor
                                        .withOpacity(0.65),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            // Social Links (optional)
                            Row(
                              children: [
                                if (post.phoneLink?.link?.isNotEmpty ==
                                    true)
                                  _socialIcon(
                                      Icons.phone, Colors.green),
                                if (post.instaLink?.link?.isNotEmpty ==
                                    true)
                                  _socialIcon(
                                      Icons.camera_alt, Colors.purple),
                                if (post.xLink?.link?.isNotEmpty == true)
                                  _socialIcon(
                                      Icons.alternate_email, Colors.blue),
                                if (post.mailLink?.link?.isNotEmpty ==
                                    true)
                                  _socialIcon(Icons.mail_outline,
                                      Colors.orange),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(String? mainImageUrl, List<String> galleryUrls) {
    String? displayUrl = mainImageUrl;
    if ((displayUrl == null || displayUrl.isEmpty) &&
        galleryUrls.isNotEmpty) {
      displayUrl = galleryUrls.first;
    }

    return Stack(
      children: [
        Container(
          height: 45.w,
          width: double.infinity,
          color: AppColorManager.backgroundGrey.withOpacity(0.2),
          child: displayUrl != null && displayUrl.isNotEmpty
              ? Image.network(
                  displayUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, __, ___) => _placeholderImage(),
                )
              : _placeholderImage(),
        ),
        // Subtle overlay gradient
        Container(
          height: 45.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.15),
              ],
              stops: const [0.4, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: AppColorManager.backgroundGrey.withOpacity(0.3),
      child: Icon(
        Icons.image_outlined,
        size: 40.sp,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _galleryThumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 9.h,
        height: 9.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholderImage(),
        ),
      ),
    );
  }

  Widget _buildMoreImagesThumb(int remaining) {
    return Container(
      width: 9.h,
      height: 9.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Center(
        child: Text(
          "+$remaining",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 2.w),
      padding: EdgeInsets.all(1.8.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Icon(icon, size: 16.sp, color: color),
    );
  }
}