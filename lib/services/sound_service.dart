import 'package:audioplayers/audioplayers.dart';
class SoundService {
  static final AudioPlayer _player = AudioPlayer();
  static Future<void> playCashSound() async {
    await _player.play(UrlSource('https://www.soundjay.com/misc/sounds/cash-register-purchase-1.mp3'));
  }
}
