import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';
import 'package:leadflow/features/leads/domain/usecases/get_leads.dart';

part 'leads_event.dart';
part 'leads_state.dart';

class LeadsBloc extends Bloc<LeadsEvent, LeadsState> {
  final GetLeads getLeads;
  LeadsBloc(this.getLeads) : super(LeadsInitial()) {
    on<LoadLeadsEvent>(_onLoadLeads);
    on<FilterLeadsEvent>(_onFilterLeads);
    on<SearchLeadsEvent>(_onSearchLeads);
  }
  List<Lead> leads = [];

  void _onLoadLeads(LoadLeadsEvent event, Emitter<LeadsState> emit) async {
    emit(LeadsLoading());

    try {
      leads = await getLeads();
      emit(LeadsLoaded(leads: leads, selectedFilter: 'All'));
    } catch (e) {
      emit(LeadsError('Failed to load leads'));
    }
  }

  void _onFilterLeads(FilterLeadsEvent event, Emitter<LeadsState> emit) {
    if (state is LeadsLoaded) {
      final filtered = event.status == 'All'
          ? leads
          : leads.where((e) => e.status == event.status).toList();
      emit(LeadsLoaded(leads: filtered, selectedFilter: event.status));
    }
  }

  void _onSearchLeads(SearchLeadsEvent event, Emitter<LeadsState> emit) {
    final currentState = state;

    if (currentState is LeadsLoaded) {
      final filtered = leads.where((lead) {
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
