import '../models/post_model.dart';
import '../services/post_api_service.dart';

class PostRepository {
  final PostApiService apiService;

  PostRepository(this.apiService);

  Future<List<Post>> getPosts() async {
    return await apiService.fetchPosts();
  }

  Future<Post> getPostDetail(int id) async {
    return await apiService.fetchPostDetail(id);
  }
}
