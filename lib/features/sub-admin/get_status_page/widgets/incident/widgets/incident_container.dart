import 'package:admin_panel/features/sub-admin/get_status_page/widgets/attach_files.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/bloc/incident_bloc.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/data/domain/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncidentContainer extends StatefulWidget {
  const IncidentContainer({super.key, required this.state});
  final IncidentModel state;

  @override
  State<IncidentContainer> createState() => _IncidentContainerState();
}

class _IncidentContainerState extends State<IncidentContainer> {
  late IncidentModel state;
  late String apiStauts;
  late String policeStatus;

  @override
  void initState() {
    state = widget.state;
    apiStauts = state.status;
    policeStatus = state.police;
    super.initState();
  }

  final status = ["pending", "approved", "rejected"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncidentBloc()..add(const GetPoliceEvent()),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(state.userModel.imageUrl),
                ),
                title: Text(
                    "${state.userModel.firstName} ${state.userModel.lastName}"),
                subtitle: Text(state.userModel.email),
              ),
              titlerow(title: "Lat", value: state.lat),
              titlerow(title: "Long", value: state.long),
              titlerow(title: "Exactlocation", value: state.locationName),
              titlerow(
                  title: "Description", value: "lorem ipsum dolor sit amet"),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Status: "),
                  DropdownButton(
                    value: apiStauts,
                    items: status
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      apiStauts = value.toString();
                      setState(() {});
                    },
                  ),
                ],
              ),
              BlocBuilder<IncidentBloc, IncidentState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      const Text("Police: "),
                      if (state is PoliceFetchSuccess)
                        DropdownButton(
                          value: policeStatus,
                          items: ["none", ...state.police]
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            policeStatus = value.toString();
                            setState(() {});
                          },
                        ),
                      if (state is PoliceFetchInProgress)
                        const CircularProgressIndicator(),
                      if (state is PoliceFetchFailure) Text(state.message)
                    ],
                  );
                },
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<IncidentBloc>(context).add(UpdatePolice(
                          policeStatus,
                          state.id,
                        ));
                        BlocProvider.of<IncidentBloc>(context)
                            .add(ChangeIncidentStatus(state.id, apiStauts));
                      },
                      child: const Text("Submit")),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<IncidentBloc>(context)
                            .add(DeleteIncident(state.id));
                      },
                      child: const Text("Delete")),
                ],
              )
            ],
          )),
    );
  }
}
