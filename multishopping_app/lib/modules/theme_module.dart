import 'package:get_it/get_it.dart';
import 'package:multishopping_app/error/error_store.dart';
import 'package:multishopping_app/setting/setting_repository.dart';
import 'package:multishopping_app/setting/setting_repository_impl.dart';
import 'package:multishopping_app/sharedpref/shared_preference_helper.dart';
import 'package:multishopping_app/theme/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class ThemeModule {
  static Future<void> configureStoreModuleInjection() async {
    getIt.registerSingletonAsync<SharedPreferences>(
        SharedPreferences.getInstance);
    getIt.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()),
    );

    getIt.registerFactory(() => ErrorStore());
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
