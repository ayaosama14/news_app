import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/core/repo/home_repo_implementation.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/presentation/manager/auth/login/login_cubit.dart';
import 'package:news_app/features/presentation/manager/auth/signup/signup_cubit.dart';
import 'package:news_app/features/presentation/manager/every_news/every_news_cubit.dart';
import 'package:news_app/features/presentation/manager/top_headlines/top_headlines_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'core/models/news_model/hive_bookMark_model.dart';
import 'core/utils/app_routes.dart';
import 'features/presentation/views/other_screens/splash_screen.dart';
import 'firebase_options.dart';

// bdcd432edce64b73b050a35f7def53cf
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(HiveBookMarkModelAdapter());
  await Hive.openBox<HiveBookMarkModel>('bookMarks');
  setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription subscription;
  var isConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected = await InternetConnectionChecker().hasConnection;
        if (!isConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TopHeadlinesCubit(getIt.get<HomeRepoImplementation>())
                ..fetchBreakingNews(),
        ),
        BlocProvider(
          create: (context) =>
              EveryNewCubit(getIt.get<HomeRepoImplementation>())
                ..fetchEveryNews(),
        ),
        BlocProvider(create: (context) => signupCubit()),
        BlocProvider(create: (context) => LoginCubit())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isConnected = await InternetConnectionChecker().hasConnection;
                if (!isConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
