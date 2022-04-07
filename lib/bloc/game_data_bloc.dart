import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';


import '../models/data_model.dart';
import '../repository/games_repo.dart';

part 'game_data_event.dart';
part 'game_data_state.dart';


  /// Added with HydratedMixin
class GameDataBloc extends Bloc<GameDataEvent, GameDataState> {
  final GamesRepo gamesRepo;
  /// Added with HydratedMixin


  // /// HydratedBloc
  // @override
  // GameDataState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final listOfGames = (json['gameData'] as List)
  //         .map((e) => DataModel.fromJson(e as Map<String, dynamic>))
  //         .toList();
  //
  //     return GameDataLoadedState(apiResult: listOfGames);
  //   } catch (e) {
  //     return null;
  //   }
  // }
  //
  // @override
  // Map<String, dynamic>? toJson(GameDataState state) {
  //   if (state is GameDataLoadedState) {
  //     return state.toJson();
  //   } else {
  //     return null;
  //   }
  // }
  // /// HydratedBloc
  // ///
  GameDataBloc(
      this.gamesRepo,
      ) : super(GameDataInitialState()) {
    on<GameDataEvent>((event, emit) async {
      if (event is LoadGameDataEvent) {
        emit(GameDataLoadingState());
        List<DataModel>? apiResult = await gamesRepo.getGamesData();
        if (apiResult == null) {
          emit(GameDataErrorState());
        } else {
          emit(GameDataLoadedState(apiResult: apiResult));
        }
      }
    });
  }


}