import 'package:admin_panel/features/sub-admin/get_status_page/presentation/get_Status_page.dart';
import 'package:admin_panel/features/verification/bloc/verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => VerificationBloc()..add(GetUnverifiedUser()),
      child: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocBuilder<VerificationBloc, VerificationState>(
            builder: (context, state) {
              if (state is VerificationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is VerificationLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                          "Unverified User",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: state.users.isEmpty
                              ? const Center(
                                  child: Text("No unverified user found"))
                              : ListView.builder(
                                  itemCount: state.users.length,
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
                                                        Navigator.pop(context),
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      width:
                                                          MediaQuery.of(context)
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
                                            child: const Text("Show image")),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Image.network(user
                                                          .passportImageUrl),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text("Show passport")),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<VerificationBloc>()
                                                  .add(VerifyUser(
                                                      userId: user.id));
                                            },
                                            child: const Text("Verify"))
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is VerificationError) {
                return Center(child: Text(state.error));
              }
              return const SizedBox();
            },
          );
        },
      ),
    ));
  }
}
