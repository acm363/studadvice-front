import 'package:get/get.dart';
import 'package:stud_advice/src/screens/home/home_page.dart';
import 'package:stud_advice/src/screens/init_time/init_time_screen.dart';
import 'package:stud_advice/src/screens/legal_conditions/legal_conditions_screen.dart';
import 'package:stud_advice/src/screens/login/login_screen.dart';
import 'package:stud_advice/src/screens/register/register_options_screen.dart';
import 'package:stud_advice/src/screens/register/register_user_information_screen.dart';
import 'package:stud_advice/src/screens/register/register_with_email_screen.dart';

class RoutesConfiguration {
  static const String initialRoute = InitTimeScreen.navigatorId;

  List<GetPage> configureRoutes() {
    return [
      GetPage(
          name: InitTimeScreen.navigatorId, page: () => const InitTimeScreen()),
      GetPage(
          name: HomePageScreen.navigatorId, page: () => const HomePageScreen()),
      GetPage(name: LoginScreen.navigatorId, page: () => const LoginScreen()),
      GetPage(
          name: RegisterOptionsScreen.navigatorId,
          page: () => const RegisterOptionsScreen()),
      GetPage(
          name: RegisterWithEmailScreen.navigatorId,
          page: () => const RegisterWithEmailScreen()),
      GetPage(
          name: LegalTermsScreen.navigatorId, page: () => LegalTermsScreen()),
      GetPage(
          name: RegisterUserInformationScreen.navigatorId,
          page: () => const RegisterUserInformationScreen()),
    ];
  }
}
