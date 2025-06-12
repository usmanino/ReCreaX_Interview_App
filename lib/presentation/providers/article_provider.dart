import 'package:flutter/foundation.dart';
import '../../data/models/article.dart';
import '../../data/models/comment.dart';
import '../../data/repositories/article_repository.dart';

class ArticleProvider with ChangeNotifier {
  final ArticleRepository _repository;

  ArticleProvider({required ArticleRepository repository})
      : _repository = repository;

  // Articles state
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  // Comments state
  final Map<int, List<Comment>> _commentsCache = {};
  final Map<int, bool> _commentsLoading = {};
  final Map<int, String?> _commentsErrors = {};

  // Getters
  List<Article> get articles => _filteredArticles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  List<Comment> getComments(int postId) => _commentsCache[postId] ?? [];
  bool isCommentsLoading(int postId) => _commentsLoading[postId] ?? false;
  String? getCommentsError(int postId) => _commentsErrors[postId];

  // Load articles
  Future<void> loadArticles({bool forceRefresh = false}) async {
    _setLoading(true);
    _setError(null);

    try {
      _articles = await _repository.getArticles(forceRefresh: forceRefresh);
      _applySearchFilter();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Load comments for a specific post
  Future<void> loadComments(int postId) async {
    _commentsLoading[postId] = true;
    _commentsErrors[postId] = null;
    notifyListeners();

    try {
      final comments = await _repository.getComments(postId);
      _commentsCache[postId] = comments;
      _commentsErrors[postId] = null;
    } catch (e) {
      _commentsErrors[postId] = e.toString();
    } finally {
      _commentsLoading[postId] = false;
      notifyListeners();
    }
  }

  // Search functionality
  void search(String query) {
    _searchQuery = query;
    _applySearchFilter();
    notifyListeners();
  }

  void _applySearchFilter() {
    if (_searchQuery.isEmpty) {
      _filteredArticles = List.from(_articles);
    } else {
      _filteredArticles = _articles
          .where((article) =>
              article.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  // Refresh articles (pull-to-refresh)
  Future<void> refreshArticles() async {
    await loadArticles(forceRefresh: true);
  }

  // Clear cache
  Future<void> clearCache() async {
    try {
      await _repository.clearCache();
      _articles.clear();
      _filteredArticles.clear();
      _commentsCache.clear();
      _commentsLoading.clear();
      _commentsErrors.clear();
      notifyListeners();
    } catch (e) {
      _setError('Failed to clear cache: $e');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  // Get article by ID
  Article? getArticleById(int id) {
    try {
      return _articles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }
}
