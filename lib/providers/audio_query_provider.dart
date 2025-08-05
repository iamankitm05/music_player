import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'audio_query_provider.g.dart';

@Riverpod(keepAlive: true)
OnAudioQuery audioQuery(Ref ref) {
  return OnAudioQuery();
}
