import 'package:dorkar/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'config/colors.dart';
import 'controller/providers/home_provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //=========Disabled landscape mode=========
  //-----------------------------------------

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //==========contains the status and navigation bar settings=======
  //-----------------------------------------------------------------

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: primaryRed,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //=========initializer part of bloc and provider===========
      //--------------------------------------------------------

      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context) {
          return const Dorkar();
        },
      ),
    );
  }
}

class Dorkar extends StatefulWidget {
  const Dorkar({Key? key}) : super(key: key);

  @override
  State<Dorkar> createState() => _DorkarState();
}

class _DorkarState extends State<Dorkar> {
  @override
  Widget build(BuildContext context) {
    //=========initialization of go_router=============
    //-------------------------------------------------

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        //=========initialization of screen_util===========
        //-------------------------------------------------

        ScreenUtil.setContext(context);
        ScreenUtil.init(
          context,
          designSize: const Size(360, 690),
        );
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
    );
  }
}
