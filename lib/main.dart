import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:news_reminder_app/application/application_setup_module.dart';
import 'package:news_reminder_app/auth_service.dart';
import 'package:news_reminder_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_reminder_app/my_app.dart';
import 'package:news_reminder_app/project_constants.dart';
import 'package:news_reminder_app/user_model.dart';

import 'firebase_options.dart';

void setupGetItLocator() {
  // Register your services here
  getIt.registerServices();
  AuthModule.setupLocator();
  getIt.registerLazySingleton<UserModel>(
    () => UserModel(username: "loading...", email: "loading..."),
  );
  getIt.registerFactory(() => AuthBloc(getIt<AuthService>()));
}

void main() async {
  setupGetItLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getIt<AuthBloc>(),
      ),
    ],
    child: MyApp(),
  ));
}
