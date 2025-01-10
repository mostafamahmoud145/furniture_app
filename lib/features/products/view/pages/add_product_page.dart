import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/products/data/repos/image_repository.dart';
import 'package:furniture_app/features/products/data/repos/product_repository.dart';
import 'package:furniture_app/features/products/view_model/product_form_cubit/product_form_cubit.dart';
import 'package:furniture_app/features/products/view_model/product_submission_cubit/product_submission_cubit.dart';

class ProductFormPage extends StatelessWidget {
  const ProductFormPage({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductFormCubit()
            ..initialize(
              name: product?.name ?? '',
              description: product?.description ?? '',
              price: product?.price ?? 0,
              isBestSeller: product?.isBestSeller ?? false,
              productCode: product?.productCode ?? '',
              existingImageUrls: product?.images ?? [],
            ),
        ),
        BlocProvider(
          create: (context) => ProductSubmissionCubit(
            productRepository: ProductRepository(),
            imageRepository: ImageRepository(),
          ),
        ),
      ],
      child: BlocConsumer<ProductSubmissionCubit, ProductSubmissionState>(
        listener: (context, submissionState) {
          if (submissionState is ProductSubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(submissionState.message)),
            );
            // Navigator.pop(context);
          } else if (submissionState is ProductSubmissionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(submissionState.message)),
            );
          }
        },
        builder: (context, submissionState) {
          final formCubit = context.read<ProductFormCubit>();
          final submissionCubit = context.read<ProductSubmissionCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text('Product Form')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<ProductFormCubit, ProductFormState>(
                builder: (context, formState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// <--- Name Field --->
                      TextFormField(
                        initialValue: formState.name,
                        onChanged: (value) =>
                            formCubit.updateField(name: value),
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),

                      /// <--- Description Field --->
                      TextFormField(
                        initialValue: formState.description,
                        onChanged: (value) =>
                            formCubit.updateField(description: value),
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                      ),

                      /// <--- Price Field --->
                      TextFormField(
                        initialValue: formState.price.toString(),
                        onChanged: (value) => formCubit.updateField(
                            price: num.tryParse(value) ?? 0),
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                      ),

                      /// <--- Product Code Field --->
                      TextFormField(
                        initialValue: formState.productCode,
                        onChanged: (value) =>
                            formCubit.updateField(productCode: value),
                        decoration:
                            const InputDecoration(labelText: 'Product Code'),
                      ),

                      /// <--- Version Spacing --->
                      const SizedBox(height: 20),

                      /// <--- Main Images --->
                      const Text(
                        'Main Image (Required):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => context
                            .read<ProductFormCubit>()
                            .pickImage(isMain: true),
                        child: formState.mainImage != null
                            ? Image.memory(formState.mainImage!,
                                width: 150, height: 150, fit: BoxFit.cover)
                            : Container(
                                width: 150,
                                height: 150,
                                color: Colors.grey[300],
                                child: const Icon(Icons.add_a_photo, size: 50),
                              ),
                      ),

                      /// <--- Version Spacing --->
                      const SizedBox(height: 20),

                      /// <--- Optional Images --->
                      const Text(
                        'Optional Images:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: List.generate(3, (index) {
                          return GestureDetector(
                            onTap: () => context
                                .read<ProductFormCubit>()
                                .pickImage(isMain: false, index: index),
                            child: formState.optionalImages[index] != null
                                ? Image.memory(formState.optionalImages[index]!,
                                    width: 100, height: 100, fit: BoxFit.cover)
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey[300],
                                    child:
                                        const Icon(Icons.add_a_photo, size: 30),
                                  ),
                          );
                        }),
                      ),

                      /// <--- Version Spacing --->
                      const SizedBox(height: 20),

                      /// <--- Is Best Seller --->
                      SwitchListTile(
                        title: const Text('Is Best Seller'),
                        value: formState.isBestSeller,
                        onChanged: (value) =>
                            formCubit.updateField(isBestSeller: value),
                      ),

                      /// <--- Version Spacing --->
                      const SizedBox(height: 20),

                      /// <--- Submit Button --->
                      Center(
                        child: submissionState is ProductSubmissionLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  submissionCubit.submitProduct(
                                    id: product?.id ??
                                        '', // Pass ID here for editing
                                    name: formState.name,
                                    description: formState.description,
                                    price: formState.price,
                                    isBestSeller: formState.isBestSeller,
                                    productCode: formState.productCode,
                                    mainImage: formState.mainImage,
                                    optionalImages: formState.optionalImages,
                                    existingImageUrls: formState.existingImageUrls,
                                  );
                                },
                                child: const Text('Submit'),
                              ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
