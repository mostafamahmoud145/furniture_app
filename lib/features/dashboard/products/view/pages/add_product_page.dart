import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/get_categories_cubit/get_categories_cubit.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/dashboard/products/data/repos/product_repository.dart';
import 'package:furniture_app/features/dashboard/products/view/components/buttons/submit_product_button.dart';
import 'package:furniture_app/features/dashboard/products/view/components/widgets/main_product_image.dart';
import 'package:furniture_app/features/dashboard/products/view/components/widgets/optional_images_widget.dart';
import 'package:furniture_app/features/dashboard/products/view_model/product_form_cubit/product_form_cubit.dart';
import 'package:furniture_app/features/dashboard/products/view_model/product_submission_cubit/product_submission_cubit.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    /// Create a global key for the form
    final _formKey = GlobalKey<FormState>();

    return MultiBlocProvider(
      providers: [
        /// Provide the ProductFormCubit
        BlocProvider(
          create: (context) => ProductFormCubit()
            ..initialize(
              name: product?.name ?? '',
              description: product?.description ?? '',
              price: product?.price ?? 0,
              isBestSeller: product?.isBestSeller ?? false,
              productCode: product?.productCode ?? '',
              existingImageUrls: product?.images ?? [],
              imageColors: product?.imageColors ?? [],
            ),
        ),

        /// Provide the ProductSubmissionCubit
        BlocProvider(
          create: (context) => ProductSubmissionCubit(
            productRepository: ProductRepository(),
          ),
        ),

        /// Provide the GetCategoriesCubit
        BlocProvider(
          create: (context) => GetCategoriesCubit()..getCategories(),
        ),
      ],
      child: BlocConsumer<ProductSubmissionCubit, ProductSubmissionState>(
        listener: (context, submissionState) {
          if (submissionState is ProductSubmissionSuccess) {
            /// Show a snackbar with the success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(submissionState.message)),
            );
            Navigator.pop(context);
          } else if (submissionState is ProductSubmissionError) {
            /// Show a snackbar with the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(submissionState.message)),
            );
          }
        },
        builder: (context, submissionState) {
          final formCubit = context.read<ProductFormCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product Form'),
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: BlocConsumer<GetCategoriesCubit, GetCategoriesState>(
                    listener: (context, categoryState) {
                      if (categoryState is GetCategoriesSuccess) {
                        formCubit.updateField(categoryId: product?.categoryId);
                      }
                    },
                    builder: (context, categoryState) {
                      return BlocBuilder<ProductFormCubit, ProductFormState>(
                        builder: (context, formState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Dropdown for Categories
                              if (categoryState is GetCategoriesSuccess)
                                DropdownButtonFormField<String>(
                                  value: formState.categoryId,
                                  onChanged: (value) =>
                                      formCubit.updateField(categoryId: value!),
                                  items: categoryState.categories
                                      .map((category) =>
                                          DropdownMenuItem<String>(
                                            value: category.id,
                                            child: Text(category.name),
                                          ))
                                      .toList(),
                                  decoration: const InputDecoration(
                                    labelText: 'Select Category',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a category.';
                                    }
                                    return null;
                                  },
                                )
                              else if (categoryState is GetCategoriesLoading)
                                const CircularProgressIndicator()
                              else if (categoryState is GetCategoriesError)
                                const Text('Failed to load categories'),

                              /// <--- Vertical spacing --->
                              const SizedBox(height: 20),

                              /// <--- Name Field --->
                              TextFormField(
                                initialValue: formState.name,
                                onChanged: (value) =>
                                    formCubit.updateField(name: value),
                                decoration:
                                    const InputDecoration(labelText: 'Name'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter the product name.';
                                  }
                                  return null;
                                },
                              ),

                              /// <--- Description Field --->
                              TextFormField(
                                initialValue: formState.description,
                                onChanged: (value) =>
                                    formCubit.updateField(description: value),
                                decoration: const InputDecoration(
                                    labelText: 'Description'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter the product description.';
                                  }
                                  return null;
                                },
                              ),

                              /// <--- Price Field --->
                              TextFormField(
                                initialValue: formState.price.toString(),
                                onChanged: (value) => formCubit.updateField(
                                    price: num.tryParse(value) ?? 0),
                                decoration:
                                    const InputDecoration(labelText: 'Price'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter the product price.';
                                  }
                                  if (num.tryParse(value) == null ||
                                      num.tryParse(value)! <= 0) {
                                    return 'Please enter a valid positive price.';
                                  }
                                  return null;
                                },
                              ),

                              /// <--- Product Code Field --->
                              TextFormField(
                                initialValue: formState.productCode,
                                onChanged: (value) =>
                                    formCubit.updateField(productCode: value),
                                decoration: const InputDecoration(
                                    labelText: 'Product Code'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter the product code.';
                                  }
                                  return null;
                                },
                              ),

                              /// <--- Vertical spacing --->
                              const SizedBox(height: 20),

                              /// <--- Main Image --->
                              const MainProductImage(),

                              /// <--- Vertical spacing --->
                              const SizedBox(
                                height: 20,
                              ),

                              /// <--- Optional Images --->
                              const OptionalImagesWidget(),

                              /// <--- Vertical spacing --->
                              const SizedBox(height: 20),

                              /// Color Picker Section
                              const Text(
                                'Pick Colors:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 20),

                              Wrap(
                                spacing: 10,
                                children: List.generate(
                                  formState.imageColors.length + 1,
                                  (index) {
                                    final isLast =
                                        index == formState.imageColors.length;

                                    Color selectedColor = Colors.black;

                                    return GestureDetector(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text(isLast
                                              ? 'Pick a Color'
                                              : 'Edit Color'),
                                          content: SingleChildScrollView(
                                            child: ColorPicker(
                                              pickerColor: isLast
                                                  ? Colors.red
                                                  : formCubit.mapToColor(
                                                      formState
                                                          .imageColors[index]),
                                              onColorChanged: (color) {
                                                selectedColor = color;
                                              },
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                final colorMap = formCubit
                                                    .colorToMap(selectedColor);

                                                if (isLast) {
                                                  // Add a new color
                                                  formCubit.addColor(colorMap);
                                                } else {
                                                  // Edit an existing color
                                                  formCubit.updateColor(
                                                      index, colorMap);
                                                }
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Choose'),
                                            ),
                                          ],
                                        ),
                                      ).then((onValue) {}),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isLast
                                              ? Colors.grey[300]
                                              : formCubit.mapToColor(
                                                  formState.imageColors[index]),
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: isLast
                                            ? const Icon(Icons.add,
                                                color: Colors.black)
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              /// <--- Vertical spacing --->
                              const SizedBox(height: 20),

                              /// <--- Submit Button --->
                              Center(
                                child:
                                    submissionState is ProductSubmissionLoading
                                        ? const CircularProgressIndicator()
                                        : SubmitProductButton(
                                            formKey: _formKey,
                                            product: product),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
