// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/posts/domain/entity/response/post_entity.dart';
import 'package:nilz_app/feature/posts/presentation/cubit/post_cubit.dart';
import 'package:nilz_app/feature/posts/presentation/cubit/post_state.dart';
import 'package:nilz_app/feature/posts/presentation/ui/widget/post_cotainer.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostCubit>().getPost(context: context); 
    });
  }

  DateTime? _parseDate(String? iso) {
    if (iso == null || iso.isEmpty) return null;
    return DateTime.tryParse(iso);
  }

  DateTime? _getSortDate(PostEntity p) {
    return _parseDate(p.date) ?? _parseDate(p.createdAt);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state.status == CubitStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == CubitStatus.error) {
          return Center(
            child: Text(
              state.error.isEmpty ? 'something_went_wrong'.tr() : state.error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }

        final PostsApiResponseEntity entity = state.entity;
        final List<PostEntity> posts = entity.results;

        if (posts.isEmpty) {
          return Center(
            child: Text(
              'no_requests_found.'.tr(), // or create 'no_posts_found'
              style: const TextStyle(fontSize: 16),
            ),
          );
        }

        // sort by date desc (like reservations)
        final sorted = [...posts]
          ..sort((a, b) {
            final aDate = _getSortDate(a);
            final bDate = _getSortDate(b);

            if (aDate == null && bDate == null) return 0;
            if (aDate == null) return 1;
            if (bDate == null) return -1;
            return bDate.compareTo(aDate);
          });

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final post = sorted[index];
              return PostContainer(post: post);
            },
          ),
        );
      },
    );
  }
}
