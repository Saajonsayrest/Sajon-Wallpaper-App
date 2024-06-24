import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app/view/decorations.dart';

import 'timer_api.dart';

class SearchButtonWidget extends HookConsumerWidget {
  const SearchButtonWidget({
    required this.onSearch,
    this.border = 12,
    super.key,
  });

  final Function(String) onSearch;
  final double border;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _debouncer = Debouncer(milliseconds: 800);

    return DecoratedBox(
      decoration: getShadowDecoration(borderRadius: border),
      child: SizedBox(
        height: 50.h,
        child: Center(
          child: TextFormField(
            onChanged: (value) async {
              _debouncer.run(() async {
                onSearch(value);
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.teal,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
