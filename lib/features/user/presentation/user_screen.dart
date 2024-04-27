import 'package:admin_panel/features/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserBloc()..add(const GetUserEvent()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserFetchSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                      child: Column(
                        children: [
                          const Text(
                            "Verified User",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: state.users.isEmpty
                                ? const Center(child: Text("No User Found"))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 26),
                                    child: ListView.separated(
                                      itemCount: state.users.length,
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                      itemBuilder: (context, index) {
                                        final user = state.users[index];

                                        return Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(user.imageUrl),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${user.firstName} ${user.lastName}"),
                                                Text(user.email),
                                              ],
                                            ),
                                            const Spacer(),
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: Image.network(
                                                            user.imageUrl),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text("Show image"),
                                            ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: Image.network(
                                                            user.imageUrl),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child:
                                                  const Text("Show password"),
                                            ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<UserBloc>().add(
                                                    DeleteUserEvent(user.id));
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is UserFetchFailure) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            );
          },
        ),
      ),
    );
  }
}
