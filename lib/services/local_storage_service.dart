import 'package:fpdart/fpdart.dart';
import 'package:music_player/models/track_model.dart';

class LocalStorageService {
  Future<Either<String, List<TrackModel>>> getTracks({
    int page = 0,
    int pageCount = 30,
  }) async {
    try {
      return right([TrackModel()]);
    } catch (e) {
      return left('Failed to load tracks: $e');
    }
  }
}
