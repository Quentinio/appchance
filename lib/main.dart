import 'package:appchance/repository/games_repo.dart';
import 'package:appchance/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/game_data_bloc.dart';

void main() async {
  /// HydratedStorage
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
  );
  /// Hydrated Storage
  HydratedBlocOverrides.runZoned(()
  => runApp(
    /// Hydrated Storage
    BlocProvider<GameDataBloc>(
      create: (context) => GameDataBloc(GamesRepo()),
      child: MyApp(),
    ),
  ),
      storage: storage
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

