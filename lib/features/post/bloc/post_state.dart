part of 'post_bloc.dart';

@immutable
sealed class PostState {}

abstract class PostActionState extends PostState{}

final class PostInitial extends PostState {}

class PostFetchingLoadingState extends PostState{}

class PostFetchingErrorState extends PostState{}

class PostFetchingSuccessfulState extends PostState{
  final List<PostModel>posts;
  PostFetchingSuccessfulState({
    required this.posts
});
}

class PostAdditionSuccessState extends PostActionState{}
class PostAdditionErrorState extends PostActionState{}