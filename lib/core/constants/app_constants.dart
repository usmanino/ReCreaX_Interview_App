class ApiConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '/posts';
  static const String commentsEndpoint = '/comments';
}

class StorageConstants {
  static const String articlesKey = 'cached_articles';
  static const String lastFetchTimeKey = 'last_fetch_time';
  static const int cacheValidityDuration = 5; // minutes
}

class AppConstants {
  static const String appTitle = 'Articles Reader';
  static const int snippetLength = 50;
}
