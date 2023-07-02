import 'package:bounce_patient_app/src/modules/playlist/controllers/audio_player_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/playlist_list_screen.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NatureSongListView extends StatefulWidget {
  const NatureSongListView({super.key});

  @override
  State<NatureSongListView> createState() => _NatureSongListViewState();
}

class _NatureSongListViewState extends State<NatureSongListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllSong();
    });
  }

  void getAllSong() async {
    final controller = context.read<SongListController>();

    if (controller.songs.isEmpty) {
      try {
        await controller.getAllSong();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongListController>(
      builder: (context, controller, _) {
        if (controller.isBusy) {
          return const CustomLoadingIndicator();
        }

        if (controller.failure != null) {
          //
        }

        if (controller.songs.isEmpty) {
          return const EmptyListView();
        }

        final songs = controller.songs;
        return SongListView(songs: songs);
      },
    );
  }
}
