
import 'package:bloc_api/features/models/post_model.dart';
import 'package:bloc_api/features/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LogicState{}
abstract class LogicEvent{}

class LogicInitializeState extends LogicState{}
class LogicErrorState extends LogicState{
  final String error;
  LogicErrorState({required this.error});
}
class LogicLoadingState extends LogicState{}

class ReadUserState extends LogicState{
  final PostModel postModel;
  ReadUserState({required this.postModel});
}

class ReadUserEvent extends LogicEvent{}

class AddUserEvent extends LogicEvent{
  final String title;
  final String body;
  final BuildContext context;
  AddUserEvent({required this.title,required this.body,required this.context});
}

class AddUserLoading extends LogicState{
  bool loading;
  AddUserLoading({required this.loading});
}

class UpdateUserEvent extends LogicEvent{
  final String id;
  final String userId;
  final String title;
  final String body;
  final BuildContext context;
  UpdateUserEvent({required this.id,required this.userId,
    required this.title,required this.body,required this.context});
}

class UpdateUserLoading extends LogicState{
  bool loading;
  UpdateUserLoading({required this.loading});
}

class DeleteUserEvent extends LogicEvent{
  final String id;
  DeleteUserEvent({required this.id});
}

class DeleteUserLoading extends LogicState{
  bool loading;
  DeleteUserLoading({required this.loading});
}

class LogicalService extends Bloc<LogicEvent,LogicState>{
  final RestApiService _service;
  LogicalService(this._service) : super(LogicInitializeState()){
    on<AddUserEvent>((event, emit)async{
      emit(AddUserLoading(loading: true));
      await _service.addUserService(event.title, event.body).then((value){
        emit(AddUserLoading(loading: false));
        Future.delayed( const Duration(milliseconds: 500),(){
          Navigator.pop(event.context);
        });
      }).onError((error, stackTrace){
        emit(AddUserLoading(loading: false));
      });
    });

    on<ReadUserEvent>((event, emit)async{
      emit(LogicLoadingState());
      await _service.readUserService().then((value){
        emit(ReadUserState(postModel: value));
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });

    on<UpdateUserEvent>((event, emit)async{
      emit(UpdateUserLoading(loading: true));
      final Map<String,dynamic> data={
        "id":event.id,
        "userId":event.userId,
        "title":event.title,
        "body":event.body
      };
      await _service.updateUserService(data).then((value){
        emit(UpdateUserLoading(loading: false));
        Future.delayed( const Duration(milliseconds: 500),(){
          Navigator.pop(event.context);
        });
      }).onError((error, stackTrace) {
        emit(UpdateUserLoading(loading: false));
      });
    });

    on<DeleteUserEvent>((event, emit)async{
      emit(DeleteUserLoading(loading: true));
      await _service.deleteUserService(event.id).then((value){
        emit(DeleteUserLoading(loading: false));
      }).onError((error, stackTrace){
        emit(DeleteUserLoading(loading: false));
      });
    });
  }
}