import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/records/sleep_session_record.dart';
import 'package:flutter_health_connect/src/util.dart';

class SleepStageRecord extends IntervalRecord {
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  Metadata metadata;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;
  SleepStageType stage;

  SleepStageRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.stage,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStageRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          stage == other.stage;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      stage.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.toMap(),
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'stage': stage.index,
    };
  }

  @override
  factory SleepStageRecord.fromMap(Map<String, dynamic> map) {
    final endTime = DateTime.tryParse(map['endTime']) ?? DateTime.now();
    final startTime = DateTime.tryParse(map['startTime']) ??
        endTime.subtract(const Duration(days: 1));

    return SleepStageRecord(
        endTime: endTime,
        endZoneOffset: parseOffset(map['endZoneOffset']),
        metadata: Metadata.fromMap(map['metadata']),
        startTime: startTime,
        startZoneOffset: parseOffset(map['startZoneOffset']),
        stage: (map['stage'] != null &&
                map['stage'] as int < SleepStageType.values.length)
            ? SleepStageType.values[map['stage']]
            : SleepStageType.unknown);
  }

  @override
  String toString() {
    return 'SleepStageRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, stage: $stage}';
  }
}
