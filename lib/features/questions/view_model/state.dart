part of 'cubit.dart';

@immutable
sealed class QuistionsState {}

final class QuistionsInitial extends QuistionsState {}

final class QuistionsLoading extends QuistionsState {}

final class QuistionsSuccess extends QuistionsState {}

final class QuistionsError extends QuistionsState {
  final String error;

  QuistionsError({required this.error});
}
