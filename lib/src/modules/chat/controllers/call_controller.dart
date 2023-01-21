import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';

const _failedToStartVideoEngine = 'Failed to start video engine';
const _failedToJoinCall = 'Failed to join call';

class CallController extends BaseController {
  late RtcEngine _agoraEngine; // Agora engine instance
  RtcEngine get agoraEngine => _agoraEngine;
  int uid = 0; // uid of the local user
  int? _remoteUid; // uid of the remote user
  int? get remoteUid => _remoteUid;
  bool _isJoined = false; // Indicates if the local user has joined the channel
  bool get isJoined => _isJoined;
  bool engineStarted = false;
  bool isMuted = false;
  int _volume = 100;
  bool inSpeakerMode = true;

  Future<void> setupVideoSDKEngine() async {
    try {
      setIsLoading(true);
      // retrieve or request camera and microphone permissions
      await [Permission.microphone, Permission.camera].request();

      //create an instance of the Agora engine
      _agoraEngine = createAgoraRtcEngine();
      await _agoraEngine.initialize(const RtcEngineContext(
        appId: AppConstants.agoraAppId,
      ));

      await _agoraEngine.enableVideo();
      engineStarted = true;
      setIsLoading(false);

      // Register the event handler
      _agoraEngine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            log("Local user uid:${connection.localUid} joined the channel");
            _isJoined = true;
            notifyListeners();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            log("Remote user uid:$remoteUid joined the channel");
            _remoteUid = remoteUid;
            notifyListeners();
          },
          onUserOffline:
              (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
            log("Remote user uid:$remoteUid left the channel");
            notifyListeners();
          },
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
      setIsLoading(false);
      throw Failure(_failedToStartVideoEngine);
    } on Error catch (e) {
      log(e.toString());
      setIsLoading(false);
      throw Failure(_failedToStartVideoEngine);
    }
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    _agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
      appId: AppConstants.agoraAppId,
    ));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("Local user uid:${connection.localUid} joined the channel");
          _isJoined = true;
          notifyListeners();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          log("Remote user uid:$remoteUid joined the channel");
          _remoteUid = remoteUid;
          notifyListeners();
        },
        onUserOffline:
            (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          log("Remote user uid:$remoteUid left the channel");
          _remoteUid = null;
          notifyListeners();
        },
      ),
    );
  }

  Future<void> join(SessionJoiningDetails sessionJoiningDetails) async {
    try {
      await _agoraEngine.startPreview();

      // Set channel options including the client role and channel profile
      const options = ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      );
      log('Token ==> ${sessionJoiningDetails.token}');
      log('Channel Name ==> ${sessionJoiningDetails.channel}');

      await _agoraEngine.joinChannel(
        token: sessionJoiningDetails.token,
        channelId: sessionJoiningDetails.channel,
        options: options,
        uid: uid,
      );
    } on Exception catch (e) {
      log(e.toString());
      setIsLoading(false);
      throw Failure(_failedToJoinCall);
    } on Error catch (e) {
      log(e.toString());
      setIsLoading(false);
      throw Failure(_failedToJoinCall);
    }
  }

  Future<void> leave() async {
    final remoteUid = _remoteUid;

    try {
      _isJoined = false;
      _remoteUid = null;
      isMuted = false;
      engineStarted = false;
      notifyListeners();
      await Future.wait([
        _agoraEngine.leaveChannel(),
        _agoraEngine.release(),
      ]);
    } on Exception catch (e) {
      log(e.toString());
      _isJoined = true;
      _remoteUid = remoteUid;
      isMuted = true;
      engineStarted = true;

      throw Failure(_failedToJoinCall);
    } on Error catch (e) {
      log(e.toString());
      _isJoined = true;
      _remoteUid = remoteUid;
      isMuted = true;
      engineStarted = true;

      throw Failure(_failedToJoinCall);
    }
  }

  Future<void> onMicPressed() async {
    try {
      if (isMuted) {
        await _agoraEngine.muteLocalAudioStream(false);
        isMuted = false;
        notifyListeners();
      } else {
        await _agoraEngine.muteLocalAudioStream(true);
        isMuted = true;
        notifyListeners();
      }
    } on Exception catch (e) {
      log(e.toString());
      throw Failure('Failed to access mic');
    } on Error catch (e) {
      log(e.toString());
      throw Failure('Failed to access mic');
    }
  }

  Future<void> onSpeakerPressed() async {
    final speakerModeStore = inSpeakerMode;

    try {
      if (inSpeakerMode) {
        _volume = 0;
        inSpeakerMode = false;
        notifyListeners();
      } else {
        _volume = 100;
        inSpeakerMode = true;
        notifyListeners();
      }

      await _agoraEngine.adjustRecordingSignalVolume(_volume);
    } on Exception catch (e) {
      if (speakerModeStore) {
        _volume = 100;
        inSpeakerMode = true;
      } else {
        _volume = 0;
        inSpeakerMode = false;
      }
      log(e.toString());
      throw Failure('Failed to access speaker');
    } on Error catch (e) {
      if (speakerModeStore) {
        _volume = 100;
        inSpeakerMode = true;
      } else {
        _volume = 0;
        inSpeakerMode = false;
      }
      log(e.toString());
      throw Failure('Failed to access speaker');
    }
  }
}
