import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicLinkController extends GetxController {
  static MusicLinkController get to => Get.find();

  RxList<AudioSource> audio_list = [
    AudioSource.uri(Uri.parse(
        "https://readm-bucket.s3.ap-northeast-2.amazonaws.com/20.mp3")),
    AudioSource.uri(Uri.parse(
        "https://readm-bucket.s3.ap-northeast-2.amazonaws.com/30.mp3")),
    AudioSource.uri(Uri.parse(
        "https://readm-bucket.s3.ap-northeast-2.amazonaws.com/56.mp3")),
  ].obs;

  void addAudio_List(String link) {
    audio_list.add(AudioSource.uri(Uri.parse(link)));
  }

  void deleteAudioElem(int index) {
    if (index < audio_list.length) {
      audio_list.removeAt(index);
    }
  }
}
