import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

/// Pendiente de revisión. Mirrors the backend's `ReportUpdateState`
/// constants (`app/schemas/report.py`): 1=pending 2=reviewed 3=dismissed
/// 4=actioned.
const reportStatePending = 1;
const reportStateReviewed = 2;
const reportStateDismissed = 3;
const reportStateActioned = 4;

/// Mirrors the backend's `ReportRead` schema (`app/schemas/report.py`).
/// Reports are polymorphic server-side (spot/comment/photo/video/event) —
/// this round only wires up `targetType == 'spot'` on the client, the
/// backend already supports the rest for a future round.
@freezed
abstract class Report with _$Report {
  const factory Report({
    required int id,
    @JsonKey(name: 'rider_id') required int riderId,
    @JsonKey(name: 'target_type') required String targetType,
    @JsonKey(name: 'target_id') required int targetId,
    required String reason,
    String? details,
    required int state,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) =>
      _$ReportFromJson(json);
}
