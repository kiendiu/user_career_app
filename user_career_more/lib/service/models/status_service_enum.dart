import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

enum StatusServiceEnum {
  pending,
  confirmed,
  inProgress,
  completed;

  String get localizedValue => switch (this) {
    StatusServiceEnum.pending => L.more.manageServiceStatusWaiting,
    StatusServiceEnum.confirmed => L.more.manageServiceStatusConfirmed,
    StatusServiceEnum.inProgress => L.more.manageServiceStatusHappened,
    StatusServiceEnum.completed => L.more.manageServiceStatusDone,
  };

  String get rawValue => switch (this) {
    StatusServiceEnum.pending => 'pending',
    StatusServiceEnum.confirmed => 'confirmed',
    StatusServiceEnum.inProgress => 'in_progress',
    StatusServiceEnum.completed => 'completed',
  };

  IconData get icon => switch (this) {
    StatusServiceEnum.pending => Icons.access_time,
    StatusServiceEnum.confirmed => Icons.check_circle_outline,
    StatusServiceEnum.inProgress => Icons.speaker_notes_outlined,
    StatusServiceEnum.completed => Icons.elevator_outlined,
  };
}
