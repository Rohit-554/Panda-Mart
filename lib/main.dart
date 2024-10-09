import 'package:flutter/material.dart';
import 'package:panda_mart/routes/app_routes.dart';
import 'package:panda_mart/viewmodel/auth_viewmodel.dart';
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
  await initializeDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<AuthViewModel>()),
          ChangeNotifierProvider(create: (_) => OnBoardingController())
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
