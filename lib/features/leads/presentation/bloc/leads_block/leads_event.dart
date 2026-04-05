part of 'leads_bloc.dart';

@immutable
sealed class LeadsEvent {}

class LoadLeadsEvent extends LeadsEvent {}

class LoadMoreLeadsEvent extends LeadsEvent {}

class RefreshLeadsEvent extends LeadsEvent {}

class FilterLeadsEvent extends LeadsEvent {
  final String status;
  FilterLeadsEvent(this.status);
}

class SearchLeadsEvent extends LeadsEvent {
  final String query;
  SearchLeadsEvent(this.query);
}

class ApplyAdvancedFilterEvent extends LeadsEvent {
  final LeadFilter filter;
  ApplyAdvancedFilterEvent(this.filter);
}
