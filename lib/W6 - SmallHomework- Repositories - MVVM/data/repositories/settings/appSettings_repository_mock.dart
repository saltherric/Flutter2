import '../../../model/settings/app_settings.dart';
import 'appSettings_repository.dart';

class AppSettingsRepositoryMock implements AppSettingsRepository {
  AppSettings _stored = AppSettings(themeColor: ThemeColor.blue);

  @override
  Future<AppSettings> load() async {
    return _stored;
  }

  @override
  Future<void> save(AppSettings settings) async {
    _stored = settings;
  }
}
