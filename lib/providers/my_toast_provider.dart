import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/utils/my_toast.dart';

part 'my_toast_provider.g.dart';

@Riverpod(keepAlive: true)
MyToast myToast(Ref ref) {
  return MyToast();
}
