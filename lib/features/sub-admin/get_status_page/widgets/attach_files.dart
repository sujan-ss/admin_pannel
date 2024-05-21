import 'package:admin_panel/features/dialog/audio_player_dialog.dart';
import 'package:admin_panel/features/dialog/video_player_dialog.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/bloc/attachfiles_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;

class AttachFiles extends StatelessWidget {
  const AttachFiles({super.key});
  @override
  Widget build(BuildContext context) {
    final status = ["pending", "approved", "rejected"];
    late String curremtStatus;

    return BlocProvider(
      create: (context) => AttachfilesBloc()..add(GetAttachedFile()),
      child: BlocConsumer<AttachfilesBloc, AttachfilesState>(
        listener: (context, state) {
          if (state is AttachedFileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<AttachfilesBloc, AttachfilesState>(
            builder: (context, state) {
              if (state is AttachfilesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AttachfilesLoaded) {
                return Column(
                  children: [
                    const Text("Attach Files"),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: state.attachFiles.length,
                        itemBuilder: (context, index) {
                          String currentStatus =
                              state.attachFiles[index].status;
                          return StatefulBuilder(builder: (context, setState) {
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    titlerow(
                                        title: "Description",
                                        value: state
                                            .attachFiles[index].description),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: SizedBox(
                                                        height: 600,
                                                        width: 600,
                                                        child: Image.network(
                                                            state
                                                                .attachFiles[
                                                                    index]
                                                                .photoUrl),
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons.photo),
                                            label: const Text("View Photo")),
                                        const SizedBox(width: 10),
                                        ElevatedButton.icon(
                                            onPressed: () {
                                              CustomVideoPlayer
                                                  .showVideoPlayerDialog(
                                                      context,
                                                      state.attachFiles[index]
                                                          .videoUrl);
                                            },
                                            icon: const Icon(Icons.movie),
                                            label: const Text("View Video")),
                                        const SizedBox(width: 10),
                                        ElevatedButton.icon(
                                            onPressed: () {
                                              final audioUrl = state
                                                  .attachFiles[index].audioUrl;
                                              html.window.open(
                                                  "http://commondatastorage.googleapis.com/codeskulptor-demos/pyman_assets/ateapill.ogg",
                                                  '_blank');
                                              // AudioPlayerDialog().showAudioPlayer(
                                              //     context: context,
                                              //     audioUrl: state
                                              //         .attachFiles[index]
                                              //         .audioUrl);
                                            },
                                            icon: const Icon(Icons.audiotrack),
                                            label: const Text("View Audio")),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Status: "),
                                        DropdownButton(
                                          value: currentStatus,
                                          items: status
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            currentStatus = value.toString();
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<AttachfilesBloc>(
                                                      context)
                                                  .add(ChangeAttachFileStatus(
                                                      state.attachFiles[index]
                                                          .id,
                                                      currentStatus));
                                            },
                                            child: const Text("Update Status")),
                                        const SizedBox(width: 10),
                                        ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<AttachfilesBloc>(
                                                      context)
                                                  .add(DeleteAttachedFile(state
                                                      .attachFiles[index].id));
                                            },
                                            child: const Text("Delete")),
                                      ],
                                    )
                                  ],
                                ));
                          });
                        },
                      ),
                    )
                  ],
                );
              } else {
                return SizedBox();
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
