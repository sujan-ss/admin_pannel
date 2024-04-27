import 'package:admin_panel/features/sub-admin/get_status_page/widgets/attach_files.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/incident_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GetStatusPage extends StatelessWidget {
  const GetStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(child: IncidentWidget()),
            Expanded(child: AttachFiles())
          ],
        ),
      ),
    );
  }

  Row titlerow({required String title, required String value}) {
    return Row(
      children: [
        Text("$title: "),
        Text(value),
      ],
    );
  }
}

// Text("Long:"),
//                       Text("Exactlocation:"),
//                       Text("Description:"),