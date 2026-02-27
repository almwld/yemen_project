import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playSuccess() async {
    try {
      await _player.play(AssetSource('sounds/success_click.mp3'));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }
}
