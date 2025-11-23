import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/image_manager.dart';
import 'package:video_player/video_player.dart';
import '../../../core/helper/app_info_helper.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController _controller;
  bool _initialized = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _controller = VideoPlayerController.asset(AppImageManager.splashVideo)
      ..setLooping(false)
      ..setVolume(0.0);

    try {
      await _controller.initialize();
      if (!mounted) return;

      setState(() => _initialized = true);

      // Listen for end of playback
      _controller.addListener(_onVideoTick);

      // Start playback
      await _controller.play();
    } catch (e) {
      debugPrint('Splash video init error: $e');
      _goNext(); // fallback
    }
  }

  void _onVideoTick() {
    final v = _controller.value;
    if (v.hasError) {
      debugPrint('Video error: ${v.errorDescription}');
      _goNext();
      return;
    }
    if (v.isInitialized && !v.isPlaying && v.position >= v.duration) {
      _goNext();
    }
  }

  Future<void> _goNext() async {
    if (_navigated || !mounted) return;
    _navigated = true;

    String target;
    try {
      final token = AppSharedPreferences.getToken();
      final isLoggedIn = token.isNotEmpty;
      target = isLoggedIn
          ? AppRouterScreenNames.dashboard
          : AppRouterScreenNames.login;
    } catch (_) {
      target = AppRouterScreenNames.login;
    }

    // Defer to avoid _debugLocked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        target,
            (route) => false,
        arguments: const {'fromSplash': true},
      );
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoTick);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_initialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: AppHeightManager.h2,
                left: AppWidthManager.w5,
                right: AppWidthManager.w5,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextWidget(
                    text: "Version ${AppInfoHelper.getAppVersion()}",
                    color: AppColorManager.background,
                  ),
                  SizedBox(height: AppHeightManager.h1point8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
