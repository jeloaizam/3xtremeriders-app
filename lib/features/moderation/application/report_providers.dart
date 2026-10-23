import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_providers.dart';
import '../data/report_api.dart';
import '../domain/report.dart';

part 'report_providers.g.dart';

/// Backs [ModerationQueueScreen] — `targetType` is always 'spot' for now
/// (this round's only moderated content type, see the moderation plan),
/// `state` picks which of the 3 review states to show.
@riverpod
Future<List<Report>> reportQueue(Ref ref, int state, String targetType) async {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  final idToken = await user?.getIdToken();
  if (idToken == null) return [];

  return ref
      .watch(reportApiProvider)
      .list(state: state, targetType: targetType, idToken: idToken);
}
