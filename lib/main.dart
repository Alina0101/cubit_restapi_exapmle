import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/post_cubit.dart';
import 'repositories/post_repository.dart';
import 'services/post_api_service.dart';
import 'ui/post_list.dart';
import 'ui/post_detail.dart';

void main() {
  final postRepository = PostRepository(PostApiService());

  runApp(MyApp(postRepository: postRepository));
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository;

  MyApp({required this.postRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(postRepository)..fetchPosts(),
      child: MaterialApp(
        title: 'Posts',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PostList(),
        routes: {
          '/detail': (context) {
            final postId = ModalRoute.of(context)!.settings.arguments as int;
            return PostDetail(id: postId);
          },
        },
      ),
    );
  }
}
