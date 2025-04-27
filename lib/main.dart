import 'package:chat_gpt_app_updated/Feature/Auth/Presentation/views/signUp/signUp_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'Feature/Auth/Presentation/manager/login_cubit/login_cubit.dart';
import 'Feature/Auth/Presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'Feature/Auth/Presentation/views/login/Login_view.dart';
import 'Feature/Home/presentation/manger/providers/chats_provider.dart';
import 'Feature/Home/presentation/manger/providers/models_provider.dart';
import 'Feature/Home/presentation/views/chat_screen.dart';
import 'Feature/Home/presentation/views/widgets/home_view.dart';
import 'Feature/OnBoarding/presentation/views/widgets/on_boarding_view.dart';
import 'Feature/Splash/presentation/view/splash_view.dart';
import 'Feature/ai_model/presentation/views/ai_send_info_view.dart';
import 'Feature/ai_model/presentation/views/widgets/decision_screen.dart';
import 'core/constants/constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled:false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
        ],
        child: MaterialApp(
          routes: {
            "HomeView": (context) => const ChatScreen(),
            "LoginView": (context) => const LoginPage(),
          },
          title: 'Flutter ChatBOT',
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              fontFamily: "Almarai",
              appBarTheme: AppBarTheme(
                color: cardColor,
              )),
          home: const AiSendInfoView(),
        ),
      ),
    );
  }
}
