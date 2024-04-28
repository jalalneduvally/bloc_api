import 'package:bloc_api/features/logic/logic.dart';
import 'package:bloc_api/features/models/post_model.dart';
import 'package:bloc_api/features/view/add_user_view.dart';
import 'package:bloc_api/features/view/update_user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
   context.read<LogicalService>().add(ReadUserEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body:_buildBody,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUserView(),));
          Future.delayed(Duration(milliseconds: 500),(){
            context.read<LogicalService>().add(ReadUserEvent());
          });
          },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget get _buildBody{
    return BlocBuilder<LogicalService,LogicState>(
      builder: (context, state) {
      if(state is LogicInitializeState || state is LogicLoadingState){
        return const Center(child: CircularProgressIndicator(),);
      }else if(state is LogicErrorState){
        String error=state.error;
        return Center(child: Text(error),);
      }else if(state is ReadUserState){
        var data=state.postModel;
        return RefreshIndicator(
          onRefresh: ()async {
            context.read<LogicalService>().add(ReadUserEvent());
          },
          child: GestureDetector(
            onTap: ()async {
            await  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                UpdateUserView(id: data.id.toString(), userId: data.userId.toString(),
                    title: data.title, body: data.body),));
            },
            child: ListTile(
              leading: Text(data.id.toString()),
              title: Text(data.title),
            subtitle: Text(data.body),
            trailing: IconButton(
                onPressed: () {
                  context.read<LogicalService>().add(DeleteUserEvent(id: data.id.toString()));
                  context.read<LogicalService>().add(ReadUserEvent());
            }, icon: const Icon(Icons.delete)),),
          ),
        );
      }else{
        return Container();
      }
    },);
  }

  // Widget _buildListView(PostModel postModel){
  //   return ListView.builder(
  //     itemCount: 1,
  //       itemBuilder: (context, index) {
  //
  //       },);
  // }
}
