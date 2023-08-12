import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_design/provider/event_provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../provider/blog_provider.dart';
import '../provider/course_provider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late CourseProvider courseProvider;
  late BlogProvider blogProvider;
  late EventProvider eventProvider;
  bool callOnce = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Fix the orientation to portrait mode
    ]);
  }

  @override
  void didChangeDependencies() {
    courseProvider = Provider.of(context);
    blogProvider = Provider.of(context);
    eventProvider = Provider.of(context);
    if (callOnce) {
      blogProvider.getLatestBlogServiceData();
      blogProvider.getBlogCategoryServiceData();
      courseProvider.getCourseServiceData();
      blogProvider.getPopularBlogServiceData();
      blogProvider.getArchivesBlogServiceData();
      eventProvider.getEvents();
      callOnce = false;
    }

    timer = Timer(const Duration(seconds: 7), () {
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed('bottom_nav_screen');
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SimpleCircularProgressBar(
              progressColors: [Colors.amber, Colors.red],
              progressStrokeWidth: 2,
              size: 135,
              backStrokeWidth: 0,
              mergeMode: true,
              animationDuration: 4,
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('images/pencilbox.png'),
              radius: 50,
            )
          ],
        ),
      ),
    );
  }
}
