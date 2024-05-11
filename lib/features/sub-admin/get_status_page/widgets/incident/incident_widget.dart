import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/bloc/incident_bloc.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/widgets/incident_container.dart';
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
    return BlocProvider(
      create: (context) => IncidentBloc()..add(const GetIncident()),
      child: BlocConsumer<IncidentBloc, IncidentState>(
        listener: (context, state) {
          if (state is IncidentFetchFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is IncidentFetchSuccess) {
            dropwondownValue = state.incidents[0].status;
          } else if (state is UpdateStatusSucess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Status Updated"),
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<IncidentBloc, IncidentState>(
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
                            return IncidentContainer(
                                state: state.incidents[index]);
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
          );
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
