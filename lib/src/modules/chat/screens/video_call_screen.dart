import 'package:agora_uikit/agora_uikit.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late final AgoraClient agoraClient;

  @override
  void initState() {
    super.initState();
    agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: '',
        channelName: '',
      ),
    );
  }

  void initAgora() async {
    try {
      await agoraClient.initialize();
    } on Exception {
      Messenger.error(message: 'Failed to connect');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          AgoraVideoViewer(
            client: agoraClient,
            layoutType: Layout.floating,
          ),
          AgoraVideoButtons(
            client: agoraClient,
            enabledButtons: const [
              BuiltInButtons.toggleMic,
              BuiltInButtons.callEnd,
              BuiltInButtons.toggleCamera,
            ],
          ),
        ],
      ),
    );
  }
}
