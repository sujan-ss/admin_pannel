import 'package:admin_panel/features/sub-admin/get_status_page/widgets/attach_files.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GetStatusPage extends StatelessWidget {
  const GetStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                const Text("Reported Incidents"),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
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
                        titlerow(title: "Lat", value: "1234"),
                        titlerow(title: "Long", value: "1234"),
                        titlerow(title: "Exactlocation", value: "Tirpureshwor"),
                        titlerow(
                            title: "Description",
                            value: "lorem ipsum dolor sit amet"),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text("Get Status")),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {}, child: const Text("Delete")),
                          ],
                        )
                      ],
                    ))
              ],
            )),
            Expanded(child: const AttachFiles())
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