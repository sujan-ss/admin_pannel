import 'package:admin_panel/features/add_police/bloc/police_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPoliceScreen extends StatefulWidget {
  const AddPoliceScreen({super.key});

  @override
  State<AddPoliceScreen> createState() => _AddPoliceScreenState();
}

class _AddPoliceScreenState extends State<AddPoliceScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PoliceBloc(),
      child: BlocConsumer<PoliceBloc, PoliceState>(
        listener: (context, state) {
          if (state is AddPoliceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Police Added Successfully")));
          } else if (state is AddPoliceFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: "Enter Police Name",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<PoliceBloc>()
                            .add(AddPoilceEvent(_controller.text));
                      },
                      child: Text("Add Police"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
