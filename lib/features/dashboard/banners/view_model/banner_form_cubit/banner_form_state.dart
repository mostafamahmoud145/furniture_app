part of 'banner_form_cubit.dart';

class BannerFormState {
  final String imageUrl;
  final Uint8List? imageBytes;

  BannerFormState({
    this.imageUrl = '',
    this.imageBytes,
  });

  BannerFormState copyWith({
    String? imageUrl,
    Uint8List? imageBytes,
  }) {
    return BannerFormState(
      imageUrl: imageUrl ?? this.imageUrl,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }
}
