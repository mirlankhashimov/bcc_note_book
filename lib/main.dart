import 'package:bcc_note_book/features/tasks/presentation/blocs/settings/locale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'di/injection.dart';
import 'features/tasks/presentation/blocs/note_bloc.dart';
import 'features/tasks/presentation/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final getIt = GetIt.instance;

void main() async {
  configureDependencies();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LocaleBloc()),
          BlocProvider(create: (context) => NoteBloc())
        ],
        child: BlocBuilder<LocaleBloc, LocaleState>(builder: (context, state) {
          String lang;
          if (state is ChangedLangState) {
            lang = state.lang;
          } else {
            lang = AppLocalizations.of(context)?.localeName ?? 'ru';
          }

          return MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(lang),
              title: 'App Title',
              home: const HomeScreen());
        }));
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   MyHomePageState createState() => MyHomePageState();
// }
//
// class MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => NoteBloc(),
//         ),
//       ],
//       child: const HomeScreen(),
//     );
//   }
// }
