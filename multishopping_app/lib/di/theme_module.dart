import 'package:get_it/get_it.dart';
import 'package:multishopping_app/core/store/error/error_store.dart';
import 'package:multishopping_app/presentation/profile/store/language/language_store.dart';
import 'package:multishopping_app/data/repository/setting/setting_repository.dart';
import 'package:multishopping_app/data/repository/setting/setting_repository_impl.dart';
import 'package:multishopping_app/data/sharedpref/shared_preference_helper.dart';
import 'package:multishopping_app/presentation/profile/store/theme/theme_store.dart';
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
    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
