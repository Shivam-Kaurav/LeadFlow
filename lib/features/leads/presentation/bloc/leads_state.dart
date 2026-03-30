part of 'leads_bloc.dart';

@immutable
sealed class LeadsState {}

final class LeadsInitial extends LeadsState {}

final class LeadsLoading extends LeadsState {}

final class LeadsLoaded extends LeadsState {
  final List<Lead> leads;
  final String selectedFilter;
  LeadsLoaded({required this.leads, required this.selectedFilter});
}

final class LeadsError extends LeadsState {
  final String message;
  LeadsError(this.message);
}
