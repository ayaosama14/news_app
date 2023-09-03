import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/presentation/views/other_screens/login_screen.dart';
import 'package:news_app/features/presentation/views/other_screens/otp_screen.dart';
import 'package:news_app/features/presentation/views/other_screens/phone_screen.dart';
import 'package:news_app/features/presentation/views/other_screens/sign_up_screen.dart';
import 'package:news_app/features/presentation/views/other_screens/splash_screen.dart';

import '../../features/presentation/views/home_view.dart';
import '../../features/presentation/views/other_screens/item_detail_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'otpScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const OTPScreen();
          },
        ),
        GoRoute(
          path: 'phoneScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const PhoneScreen();
          },
        ),
        GoRoute(
          path: 'signupView',
          builder: (BuildContext context, GoRouterState state) {
            return const signupView();
          },
        ),
        GoRoute(
          path: 'loginView',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          },
        ),
        // GoRoute(
        //   path: 'homeView',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const HomeView();
        //   },
        // ),
        GoRoute(
          path: 'itemDetailScreen',
          builder: (BuildContext context, GoRouterState state) {
            final content = state.extra as String;
            final date = state.extra as String;
            final imageUrl = state.extra as String;
            final source = state.extra as String;
            final title = state.extra as String;
            final category = state.extra as String;
            return ItemDetailScreen(
              content: content,
              date: date,
              imageUrl: imageUrl,
              source: source,
              title: title,
              category: category,
            );
          },
        ),
      ],
    ),
  ],
);
