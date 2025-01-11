import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/category_form_cubit/category_form_cubit.dart';

class MainCategoryImage extends StatelessWidget {
  const MainCategoryImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryFormCubit, CategoryFormState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => BlocProvider.of<CategoryFormCubit>(context).pickImage(),
          child: state.imageBytes != null
              ? Image.memory(
                  state.imageBytes!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : state.imageUrl.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/icons/load.gif',
                      image: state.imageUrl,
                      height: 100,
                      width: 100,
                    )
                  : Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.add_a_photo, size: 50),
                    ),
        );
      },
    );
  }
}
