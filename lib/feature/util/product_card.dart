import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;
  final Color color;
  final String volume;
  final String size;
  final String code;
  final String description;
  final int price;
  final int id;
  final String? model;

  const ProductCard({
    this.onTap,
    super.key,
    required this.id,
    required this.imagePath,
    required this.volume,
    required this.code,
    required this.description,
    required this.price,
    required this.color,
    required this.size,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // height: ,
          // width: 150,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surface, // Added to show background color usage
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // index
                    Text(
                      '+${id}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    ),

                    // product track id
                    Text(
                      '\$$price',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // image
                      Image.asset(
                        imagePath,
                        height: 84,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: color),
                      ),
                    ],
                  ),
                ),
                Gap(10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Code : ${code.toString()}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    // const SizedBox(height: 8),
                    // description
                    Text(
                      model?.isNotEmpty == true
                          ? 'Model: $model'
                          : size.isNotEmpty == true
                              ? 'Size: $size'
                              : 'Volume: $volume',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
