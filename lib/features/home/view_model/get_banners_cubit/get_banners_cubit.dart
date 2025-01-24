import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/banners/data/repos/banner_repository.dart';
import 'package:meta/meta.dart';

part 'get_banners_state.dart';

class GetBannersCubit extends Cubit<GetBannersState> {
  GetBannersCubit() : super(GetBannersInitial());

  final BannerRepository repository = BannerRepository();

  Future<void> getBanners() async {
    emit(GetBannersLoading());
    try {
      final banners = await repository.getBanners();
      emit(GetBannersSuccess(banners: banners));
      print('Valid Banners: $banners');
    } catch (e) {
      print('Error: $e');
      emit(GetBannersError());
    }
  }
}
