import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/data/repos/category_repository.dart';
import 'package:furniture_app/features/dashboard/categories/view/components/buttons/submit_category_button.dart';
import 'package:furniture_app/features/dashboard/categories/view/components/widgets/main_category_image.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/category_form_cubit/category_form_cubit.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/category_submission_cubit/category_submission_cubit.dart';

class AddCategoryPage extends StatelessWidget {
  final CategoryModel? category;

  const AddCategoryPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    /// Create a global key for the form
    final _formKey = GlobalKey<FormState>();

    return MultiBlocProvider(
      providers: [
        /// Provide the CategoryFormCubit
        BlocProvider(
          create: (context) => CategoryFormCubit()
            ..initialize(
              name: category?.name ?? '',
              existingImageUrl: category?.imageUrl ?? '',
            ),
        ),

        /// Provide the CategorySubmissionCubit
        BlocProvider(
          create: (context) => CategorySubmissionCubit(
            categoryRepository: CategoryRepository(),
          ),
        ),
      ],
      child: BlocConsumer<CategorySubmissionCubit, CategorySubmissionState>(
        listener: (context, state) {
          if (state is CategorySubmissionSuccess) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Category submitted successfully.')),
            );

            // Navigate back to the previous screen
            Navigator.pop(context);
          } else if (state is CategorySubmissionError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, submissionState) {
          final formCubit = context.read<CategoryFormCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text(category == null ? 'Add Category' : 'Edit Category'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: BlocBuilder<CategoryFormCubit, CategoryFormState>(
                  builder: (context, formState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Name Field
                        TextFormField(
                          initialValue: formState.name,
                          onChanged: (value) =>
                              formCubit.updateField(name: value),
                          decoration:
                              const InputDecoration(labelText: 'Category Name'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter the category name.';
                            }
                            return null;
                          },
                        ),

                        /// <--- Vertical spacing --->
                        const SizedBox(height: 20),

                        // Category Image Picker
                        const MainCategoryImage(),

                        /// <--- Vertical spacing --->
                        const SizedBox(height: 20),

                        // Submit Button
                        submissionState is CategorySubmissionLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SubmitCategoryButton(
                                category: category,
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
