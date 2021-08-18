import 'package:starioo/src/models/song_model.dart';

abstract class AudioPlayerService {
  Future<Duration> loadPlaylist(List<Song> playlist);
}
