import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

class ExampleUserSiteList extends ConsumerWidget {
  static final userSiteList = FirepodMapString(
    name: 'ExampleUserSiteList',
    path: '/data/{user}/sites',
    watch: true,
    autoSave: true,
  );
  static final siteTitle = FirepodScalarString(
    name: 'ExampleUserSiteList',
    path: '/data/{user}/sites/{site}',
    watch: true,
    autoSave: true,
  );

  static final testing = FirepodListObject(
    name: 'Site List',
    path: '/data/{user}/sites',
    decoder: Site.convert.from.dynamicMap.to.model,
    encoder: Site.convert.to.dynamicMap.from.model,
    idField: 'id',
    valueField: 'name',
  );

  const ExampleUserSiteList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(userSiteList.value);
    final selectedTitle = ref.watch(siteTitle.value);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'User Site List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        Text(
          selectedTitle,
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
