import 'package:bloc_api/features/post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostBloc postBloc = PostBloc();

  @override
  void initState() {
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        postBloc.add(PostAddEvent());
      },),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is !PostActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch(state.runtimeType){
            case PostFetchingLoadingState:
              return const Center(child: CircularProgressIndicator(),);
            case PostFetchingSuccessfulState:
              final successState=state as PostFetchingSuccessfulState;
              return Container(
                child: ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    color: Colors.grey.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(successState.posts[index].title),
                        Text(successState.posts[index].body),
                      ],
                    ),
                  );
                },),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
