import '../models/article.dart';
import '../models/comment.dart';
import '../datasources/api_service.dart';
import '../datasources/cache_service.dart';

class ArticleRepository {
  final ApiService _apiService;
  final CacheService _cacheService;

  ArticleRepository({
    required ApiService apiService,
    required CacheService cacheService,
  })  : _apiService = apiService,
        _cacheService = cacheService;

  Future<List<Article>> getArticles({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      // Try to get cached articles first
      final cachedArticles = await _cacheService.getCachedArticles();
      if (cachedArticles != null) {
        return cachedArticles;
      }
    }

    // Fetch from API if no cache or force refresh
    final articles = await _apiService.fetchArticles();

    // Cache the fetched articles
    await _cacheService.cacheArticles(articles);

    return articles;
  }

  Future<List<Comment>> getComments(int postId) async {
    return await _apiService.fetchComments(postId);
  }

  Future<void> clearCache() async {
    await _cacheService.clearCache();
  }
}
