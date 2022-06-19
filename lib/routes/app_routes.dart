import 'package:dorkar/config/text_styles.dart';
import 'package:dorkar/pages/home/home_page.dart';
import 'package:dorkar/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/login/login_page.dart';

final router = GoRouter(
  initialLocation: '/home',
    routes: [
      GoRoute(
          name: homePage,
          path: '/home',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: HomePage(),
            );
          }),
      GoRoute(
          name: loginPage,
          path: '/login',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: LoginPage(),
            );
          }),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
              style: mediumText(12.sp),
            ),
          ),
        ),
      );
    });