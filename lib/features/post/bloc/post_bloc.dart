import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_api/features/post/repository/post_repository.dart';
import 'package:meta/meta.dart';

import '../../models/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }
  Future<FutureOr<void>>postInitialFetchEvent( PostInitialFetchEvent event,Emitter<PostState>emit) async {
    emit(PostFetchingLoadingState());

    List<PostModel> posts=await PostRepository.fetchPosts();
         emit(PostFetchingSuccessfulState(posts: posts));
  }

  Future<FutureOr<void>>postAddEvent(PostAddEvent event,Emitter<PostState>emit) async {
    bool success = await PostRepository.addPost();
    print(success);
    if(success){
      emit(PostAdditionSuccessState());
    }else{
      emit(PostAdditionErrorState());
    }
  }
}
