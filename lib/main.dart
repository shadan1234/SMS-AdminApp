import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_admin/constants/app_theme.dart';
import 'package:sms_admin/constants/bottom_page.dart';
import 'package:sms_admin/constants/size_config.dart';
import 'package:sms_admin/feat/auth/screens/auth-screen.dart';

import 'package:sms_admin/feat/auth/services/auth_service.dart';
import 'package:sms_admin/router.dart';
import 'package:sms_admin/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // print(Plugins.getInstance().plugins);
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
 

  @override
  void initState() {
    super.initState();
    authService.checkTokenValidity(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
   
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Event-Management',
      theme: AppTheme.themeData,
      onGenerateRoute: (settings) => generateRoute(settings),
      home:  _getHomeScreen(),
    );
  }
}
 Widget _getHomeScreen() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.user.token.isNotEmpty) {
         return BottomBar();
        } else {
          return  AuthScreen();
        }
      },
    );
  }

