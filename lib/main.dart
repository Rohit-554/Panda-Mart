import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:panda_mart/core/routes/app_routes.dart';
import 'package:panda_mart/views/viewModels/auth_viewmodel.dart';
import 'package:panda_mart/views/viewModels/product_viewmodel.dart';
import 'package:panda_mart/views/viewModels/remote_config_viewmodel.dart';
import 'package:panda_mart/views/auth/login_screen.dart';
import 'package:panda_mart/views/splash_screen/controllers.onboarding/onboarding_controller.dart';
import 'package:panda_mart/views/splash_screen/onboarding.dart';
import 'package:panda_mart/views/splash_screen/screens.onboarding/widgets/onboarding_page.dart';
import 'core/config/themes/app_theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<AuthViewModel>()),
          ChangeNotifierProvider(create: (_) => sl<ProductViewModel>()),
          ChangeNotifierProvider(create: (_) => OnBoardingController()),
          ChangeNotifierProvider(create: (_) => sl<RemoteConfigViewModel>())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Panda Mart',
        theme: appTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const Onboarding(),
      ),
    );

  }
}
