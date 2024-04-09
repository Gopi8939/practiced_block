import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:block_test/data/gocery_data.dart';
import 'package:block_test/features/home/model/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWhishlistButtonNavigateEvent>(homeWhishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWhishlistButtonClickedEvent>(
        homeProductWhishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }
  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadingSuccessState(
        products: Grocery.groceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e["price"],
                imageUrl: e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeWhishlistButtonNavigateEvent(
      HomeWhishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("whishlist clicked");
    emit(HomeNavigateToWhishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart clicked");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> homeProductWhishlistButtonClickedEvent(
      HomeProductWhishlistButtonClickedEvent event, Emitter<HomeState> emit) {}
}
