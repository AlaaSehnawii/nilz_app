// ignore_for_file: deprecated_member_use, unused_field

import 'package:flutter/material.dart';
import 'package:nilz_app/core/widget/bar/search_bar.dart';
import 'package:nilz_app/feature/posts/presentation/ui/widget/post_list.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SEARCH BAR
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomSearchBar(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _query = v.trim()),
          ),
        ),
        const SizedBox(height: 8),

        // LIST AREA
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: PostList(), // PostCubit is provided in NavBar
            ),
          ),
        ),
      ],
    );
  }
}
