import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/post_repository.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository postRepository;

  PostCubit(this.postRepository) : super(PostInitial());

  Future<void> fetchPosts() async {
    emit(PostLoading());
    try {
      final posts = await postRepository.getPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> fetchPostDetail(int id) async {
    emit(PostLoading());
    try {
      final post = await postRepository.getPostDetail(id);
      emit(PostDetailLoaded(post));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
