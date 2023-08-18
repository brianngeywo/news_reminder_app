import 'package:get_it/get_it.dart';
import 'package:news_reminder_app/auth_service.dart';
import 'package:news_reminder_app/user_model.dart';

GetIt getIt = GetIt.instance;
final authServiceProvider = getIt<AuthService>();
UserModel loggedInUser = getIt<UserModel>();
