
import 'package:bloc/bloc.dart';
import 'package:blood_donor/core/utils/app_bloc_observer.dart';
import 'package:blood_donor/root/app_root.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async{

   WidgetsFlutterBinding.ensureInitialized();
 

  BlocOverrides.runZoned(
    () =>runApp(  EasyLocalization(
          supportedLocales: const [Locale('ar'), Locale('en')],
          path: 'lang',
          startLocale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          child: const BloodDonor())),
    blocObserver: AppBlocObserver()
  );
}
