class AudioPositionData {
  final Duration position;
  final Duration bufferPosition;
  final Duration duration;

  AudioPositionData({
    required this.position,
    required this.bufferPosition,
    required this.duration,
  });
}
