import 'package:get_it/get_it.dart';
import '../../data/datasources/api_service.dart';
import '../../data/datasources/cache_service.dart';
import '../../data/repositories/article_repository.dart';
import '../../presentation/providers/article_provider.dart';
import '../../presentation/providers/theme_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Data sources
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<CacheService>(() => CacheService());

  // Repository
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepository(
      apiService: sl<ApiService>(),
      cacheService: sl<CacheService>(),
    ),
  );

  // Providers
  sl.registerFactory<ArticleProvider>(
    () => ArticleProvider(repository: sl<ArticleRepository>()),
  );

  sl.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
}
