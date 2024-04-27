import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/bloc/incident_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncidentWidget extends StatefulWidget {
  const IncidentWidget({super.key});

  @override
  State<IncidentWidget> createState() => _IncidentWidgetState();
}

class _IncidentWidgetState extends State<IncidentWidget> {
  String dropwondownValue = "pending";
  @override
  Widget build(BuildContext context) {
    final status = ["pending", "approved", "rejected"];

    return BlocProvider(
      create: (context) => IncidentBloc()..add(const GetIncident()),
      child: BlocBuilder<IncidentBloc, IncidentState>(
        builder: (context, state) {
          if (state is IncidentFetchInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IncidentFetchSuccess) {
            return Column(
              children: [
                const Text("Reported Incidents"),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
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
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(state
                                        .incidents[index].userModel.imageUrl),
                                  ),
                                  title: Text(
                                      "${state.incidents[index].userModel.firstName} ${state.incidents[index].userModel.lastName}"),
                                  subtitle: Text(
                                      state.incidents[index].userModel.email),
                                ),
                                titlerow(
                                    title: "Lat",
                                    value: state.incidents[index].lat),
                                titlerow(
                                    title: "Long",
                                    value: state.incidents[index].long),
                                titlerow(
                                    title: "Exactlocation",
                                    value: state.incidents[index].locationName),
                                titlerow(
                                    title: "Description",
                                    value: "lorem ipsum dolor sit amet"),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text("Status: "),
                                    DropdownButton(
                                      value: dropwondownValue,
                                      items: status
                                          .map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        dropwondownValue = value.toString();
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("Submit")),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                        onPressed: () {
                                          BlocProvider.of<IncidentBloc>(context)
                                              .add(DeleteIncident(
                                                  state.incidents[index].id));
                                        },
                                        child: const Text("Delete")),
                                  ],
                                )
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.incidents.length),
                )
              ],
            );
          } else if (state is IncidentFetchFailure) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

Row titlerow({required String title, required String value}) {
  return Row(
    children: [
      Text("$title: "),
      Text(value),
    ],
  );
}
