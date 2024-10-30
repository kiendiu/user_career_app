import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

enum StatusServiceEnum {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,;

  String get localizedValue => switch (this) {
    StatusServiceEnum.pending => L.more.manageServiceStatusWaiting,
    StatusServiceEnum.confirmed => L.more.manageServiceStatusConfirmed,
    StatusServiceEnum.inProgress => "Đang diễn ra",
    StatusServiceEnum.completed => L.more.manageServiceStatusDone,
    StatusServiceEnum.cancelled => "Đã hủy",
  };

  String get rawValue => switch (this) {
    StatusServiceEnum.pending => 'pending',
    StatusServiceEnum.confirmed => 'confirmed',
    StatusServiceEnum.inProgress => 'in_progress',
    StatusServiceEnum.completed => 'completed',
    StatusServiceEnum.cancelled => 'cancelled',
  };

  IconData get icon => switch (this) {
    StatusServiceEnum.pending => Icons.access_time,
    StatusServiceEnum.confirmed => Icons.check_circle_outline,
    StatusServiceEnum.inProgress => Icons.speaker_notes_outlined,
    StatusServiceEnum.completed => Icons.elevator_outlined,
    StatusServiceEnum.cancelled => Icons.cancel_outlined,
  };
}
