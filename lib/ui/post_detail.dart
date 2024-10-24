import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/post_cubit.dart';
import '../cubit/post_state.dart';

class PostDetail extends StatelessWidget {
  final int id;

  PostDetail({required this.id});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostCubit>(context).fetchPostDetail(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали поста', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<PostCubit>(context).fetchPosts();
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (state is PostDetailLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          state.post.title,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 300,
                          height: 4,
                          color: Colors.grey.shade800,
                          margin: const EdgeInsets.only(top: 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      state.post.body,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Деталей нет :('));
          }
        },
      ),
    );
  }
}
