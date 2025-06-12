import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';
import '../../core/constants/app_constants.dart';

class CacheService {
  Future<void> cacheArticles(List<Article> articles) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final articlesJson = articles.map((article) => article.toJson()).toList();
      await prefs.setString(
          StorageConstants.articlesKey, json.encode(articlesJson));
      await prefs.setInt(StorageConstants.lastFetchTimeKey,
          DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      throw Exception('Failed to cache articles: $e');
    }
  }

  Future<List<Article>?> getCachedArticles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(StorageConstants.articlesKey);
      final lastFetchTime = prefs.getInt(StorageConstants.lastFetchTimeKey);

      if (cachedData == null || lastFetchTime == null) {
        return null;
      }

      // Check if cache is still valid (5 minutes)
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final cacheAge = currentTime - lastFetchTime;
      final maxCacheAge = StorageConstants.cacheValidityDuration *
          60 *
          1000; // Convert to milliseconds

      if (cacheAge > maxCacheAge) {
        return null; // Cache expired
      }

      final List<dynamic> jsonList = json.decode(cachedData);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      return null; // Return null if any error occurs
    }
  }

  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageConstants.articlesKey);
      await prefs.remove(StorageConstants.lastFetchTimeKey);
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }
}
