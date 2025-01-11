import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/banners/data/repos/banner_repository.dart';
import 'package:furniture_app/features/dashboard/banners/view/components/buttons/submit_banner_button.dart';
import 'package:furniture_app/features/dashboard/banners/view/components/widgets/main_banner_image.dart';
import 'package:furniture_app/features/dashboard/banners/view_model/banner_form_cubit/banner_form_cubit.dart';
import 'package:furniture_app/features/dashboard/banners/view_model/banner_submission_cubit/banner_submission_cubit.dart';

class AddBannerPage extends StatelessWidget {
  final BannerModel? banner;

  const AddBannerPage({super.key, this.banner});

  @override
  Widget build(BuildContext context) {
    /// Create a global key for the form
    final _formKey = GlobalKey<FormState>();

    return MultiBlocProvider(
      providers: [
        /// Provide the BannerFormCubit
        BlocProvider(
          create: (context) => BannerFormCubit()
            ..initialize(
              existingImageUrl: banner?.imageUrl ?? '',
            ),
        ),

        /// Provide the BannerSubmissionCubit
        BlocProvider(
          create: (context) => BannerSubmissionCubit(
            bannerRepository: BannerRepository(),
          ),
        ),
      ],
      child: BlocConsumer<BannerSubmissionCubit, BannerSubmissionState>(
        listener: (context, state) {
          if (state is BannerSubmissionSuccess) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Banner submitted successfully.')),
            );

            // Navigate back to the previous screen
            Navigator.pop(context);
          } else if (state is BannerSubmissionError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, submissionState) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(banner == null ? 'Add Banner' : 'Edit Banner'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: BlocBuilder<BannerFormCubit, BannerFormState>(
                  builder: (context, formState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Banner Image Picker
                        const MainBannerImage(),

                        /// <--- Vertical spacing --->
                        const SizedBox(height: 20),

                        // Submit Button
                        submissionState is BannerSubmissionLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SubmitBannerButton(
                                banner: banner,
                                formKey: _formKey,
                              ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
