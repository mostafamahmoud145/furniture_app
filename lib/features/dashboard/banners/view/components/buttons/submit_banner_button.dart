import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/banners/view_model/banner_form_cubit/banner_form_cubit.dart';
import 'package:furniture_app/features/dashboard/banners/view_model/banner_submission_cubit/banner_submission_cubit.dart';

class SubmitBannerButton extends StatelessWidget {
  const SubmitBannerButton({
    super.key,
    required this.banner,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final BannerModel? banner;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerFormCubit, BannerFormState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                (state.imageBytes != null ||
                    state.imageUrl.trim().isNotEmpty)) {
              BlocProvider.of<BannerSubmissionCubit>(context).submitBanner(
                id: banner?.id ?? '',
                newImage: state.imageBytes,
                existingImageUrl: state.imageUrl,
              );
            }
          },
          child: const Text('Submit'),
        );
      },
    );
  }
}
