// import 'package:provider/provider.dart';
// import 'main_common.dart';


// /// Configure provider dependencies for dev environment
// List<InheritedProvider> get devProviders {
//   final locationRepository = loca();

//   return [
 
//     // 1 - Inject the song repository
//     Provider<SongRepository>(create: (_) => SongRepositoryMock()),

//     // 2 - Inject the player state
//     ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

//     // 3 - Inject the  app setting state
//     ChangeNotifierProvider<AppSettingsState>(
//       create: (_) => AppSettingsState(repository: appSettingsRepository),
//     ),
//   ];
// }

// void main() {
//   mainCommon(devProviders);
// }
