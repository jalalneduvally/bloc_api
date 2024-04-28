import 'package:bloc_api/features/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  TextEditingController bodyController=TextEditingController();
  TextEditingController titleController=TextEditingController();
  @override
  void dispose() {
    bodyController.dispose();
    titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: _buildBody,
    );
  }
  Widget get _buildBody{
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Enter title"
            ),
          ),
          const SizedBox(height: 15,),
          TextField(
            controller: bodyController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Body"
            ),
          ),
          const SizedBox(height: 15,),
          ElevatedButton(onPressed: () {
            context.read<LogicalService>().add(
                AddUserEvent(title: titleController.text, body: bodyController.text, context: context));
          }, child: BlocBuilder<LogicalService, LogicState>(
            builder: (context, state) {
              if(state is AddUserLoading){
                bool isLoading=state.loading;
                return isLoading?CircularProgressIndicator():Text("add");
              }else {
                return Text("Add");
              }
        },
      ))
        ],
      ),
    );
  }
}
