part of 'leads_bloc.dart';

@immutable
sealed class LeadsState {}

final class LeadsInitial extends LeadsState {}

final class LeadsLoading extends LeadsState {}

final class LeadsLoaded extends LeadsState {
  final List<Lead> leads;
  final bool hasMore;
  final bool isLoadingMore;
  final String selectedFilter;

  LeadsLoaded({
    required this.leads,
    required this.selectedFilter,
    required this.hasMore,
    required this.isLoadingMore,
  });

  LeadsLoaded copyWith({
    List<Lead>? leads,
    bool? hasMore,
    bool? isLoadingMore,
    String? selectedFilter,
  }) {
    return LeadsLoaded(
      leads: leads ?? this.leads,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class LeadsError extends LeadsState {
  final String message;
  LeadsError(this.message);
}
