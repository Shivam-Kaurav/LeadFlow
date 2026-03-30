import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';

part 'leads_event.dart';
part 'leads_state.dart';

class LeadsBloc extends Bloc<LeadsEvent, LeadsState> {
  LeadsBloc() : super(LeadsInitial()) {
    on<LoadLeadsEvent>(_onLoadLeads);
    on<FilterLeadsEvent>(_onFilterLeads);
    on<SearchLeadsEvent>(_onSearchLeads);
  }
  List<Lead> allLeads = [];

  void _onLoadLeads(LoadLeadsEvent event, Emitter<LeadsState> emit) async {
    emit(LeadsLoading());

    allLeads = [
      Lead(id: '1', name: 'Shivam', phone: '9999999999', status: 'Fresh'),
      Lead(id: '2', name: 'Rahul', phone: '8888888888', status: 'Pending'),
      Lead(id: '3', name: 'Amit', phone: '7777777777', status: 'Meeting'),
    ];
    emit(LeadsLoaded(leads: allLeads, selectedFilter: 'All'));
  }

  void _onFilterLeads(FilterLeadsEvent event, Emitter<LeadsState> emit) {
    if (state is LeadsLoaded) {
      final filtered = event.status == 'All'
          ? allLeads
          : allLeads.where((e) => e.status == event.status).toList();
      emit(LeadsLoaded(leads: filtered, selectedFilter: event.status));
    }
  }

  void _onSearchLeads(SearchLeadsEvent event, Emitter<LeadsState> emit) {
    final currentState = state;

    if (currentState is LeadsLoaded) {
      final filtered = allLeads.where((lead) {
        return lead.name.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      emit(
        LeadsLoaded(
          leads: filtered,
          selectedFilter: currentState.selectedFilter,
        ),
      );
    }
  }
}
