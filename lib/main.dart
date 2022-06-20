import 'package:dorkar/controller/blocs/home/home_bloc.dart';
import 'package:dorkar/data/services/connectivity_repository.dart';
import 'package:dorkar/data/services/home_repository.dart';
import 'package:dorkar/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'config/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/navigation_service.dart';
import 'controller/blocs/category_search/category_search_bloc.dart';
import 'controller/blocs/login/login_bloc.dart';
import 'controller/blocs/search/search_bloc.dart';
import 'controller/providers/home_provider.dart';
import 'controller/providers/login_provider.dart';
import 'data/services/login_repository.dart';
import 'data/services/search_repository.dart';

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
      //=========initializer part of bloc and provider==========
      //--------------------------------------------------------

      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            connectivityRepository: ConnectivityRepository(),
            repository: HomeRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            connectivityRepository: ConnectivityRepository(),
            searchRepository: SearchRepository(),
            //repository: HomeRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => CategorySearchBloc(
            connectivityRepository: ConnectivityRepository(),
            searchRepository: SearchRepository(),
            //repository: HomeRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            connectivityRepository: ConnectivityRepository(),
            loginRepository: LoginRepository(),
            //repository: HomeRepository(),
          ),
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
      key: NavigationService.navigatorKey,
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
