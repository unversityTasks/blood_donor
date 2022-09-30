import 'package:blood_donor/blocs/auth_cubit/auth_cubit.dart';
import 'package:blood_donor/blocs/blood_cubit/blood_cubit.dart';
import 'package:blood_donor/blocs/donors_cubit/donors_cubit.dart';
import 'package:blood_donor/blocs/services_cubit/service_cubit.dart';
import 'package:blood_donor/config/app_theme/app_theme.dart';
import 'package:blood_donor/config/routes/app_routes.dart';
import 'package:blood_donor/config/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class BloodDonor extends StatelessWidget {
  const BloodDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => AuthCubit()),
        ),
        BlocProvider(
          create: ((context) => BloodCubit()),
        ),
        BlocProvider(
          create: ((context) => DonorsCubit()),
        ),
        BlocProvider(
          create: ((context) => ServiceCubit()),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'بنك الدم',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppThemes.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          onGenerateRoute: RouterGenerator.generateRoute,
        );
      }),
    );
  }
}
