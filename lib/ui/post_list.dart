import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/post_state.dart';
import '../cubit/post_cubit.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Постики',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(state.posts[index].title),
                    leading: const Icon(Icons.list_alt),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: state.posts[index].id,
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Нет постиков :('));
          }
        },
      ),
    );
  }
}
