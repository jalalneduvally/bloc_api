import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/logic.dart';

class UpdateUserView extends StatefulWidget {
  final String id;
  final String userId;
  final String title;
  final String body;
  const UpdateUserView({super.key, required this.id, required this.userId, required this.title, required this.body});

  @override
  State<UpdateUserView> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _userIdController;
  
  @override
  void initState() {
    _titleController=TextEditingController(text: widget.title);
    _bodyController=TextEditingController(text: widget.body);
    _userIdController=TextEditingController(text: widget.userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter title"
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter Body"
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter UserId"
              ),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(onPressed: () {
              context.read<LogicalService>().add(
                  UpdateUserEvent(title: _titleController.text, 
                    body: _bodyController.text, id: widget.id.toString(), userId: _userIdController.text, context: context,));
            }, child: BlocBuilder<LogicalService, LogicState>(
              builder: (context, state) {
                if(state is UpdateUserLoading){
                  bool isLoading=state.loading;
                  return isLoading?CircularProgressIndicator():Text("Update");
                }else {
                  return Text("Update");
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
