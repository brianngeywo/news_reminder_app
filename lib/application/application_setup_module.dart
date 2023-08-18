import 'package:get_it/get_it.dart';
import 'package:news_reminder_app/auth_service.dart';
import 'package:news_reminder_app/project_constants.dart';

import '../http_service.dart';
import '../scraper_service.dart';

extension GetItExtensions on GetIt {
  // Register your services here
  void registerServices() {
    // Register your services here
    registerLazySingleton<HttpService>(() => HttpService());
    registerLazySingleton<ScraperService>(() => ScraperService());
  }
}

class AuthModule {
  static void setupLocator() {
    // Register your services here
    // locator.registerLazySingleton(() => null)
    getIt.registerLazySingleton(() => AuthService());
  }
}
