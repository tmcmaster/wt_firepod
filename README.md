# wt_firepod

This library melds firebase APIs with Riverpod providers; hence Firepod.

For all of the Firepod providers:
- The watch property will watch Firebase values and update the provider when they change.
- The autoSave property will update Firebase value when the provider changes.

Supported Types:

- map
  - FirepodMapDouble
  - FirepodMapString
  - FirepodMapBoolean
  - FirepodMapInt
  - FirepodMapObject<T>
- list
  - FirepodListObject<T>
  - FirepodListString
  - FirepodList<M>
  - FirepodListBool
  - FirepodListInt
  - FirepodListDouble
- scalar 
  - FirepodScalarString
  - FirepodScalarInt
  - FirepodScalarBool
  - FirepodScalarDouble

All of the following examples use the following baseUrl:
```dart
  static const basePath = '/v1/testing/list-object';
```

Current user ID, and site ID for multi-site supported apps, can be injected into the path strings.
```dart
  static final siteSettingsProvider = FirepodObject<SiteSettings>(
    name: 'ExampleUserSiteList',
    path: '/data/{user}/site-settings/{site}',
    watch: true,
    autoSave: true,
  );
```

This enables the user to switch between sites, and have the SiteSettings automatically update, 
and propagate throughout the app.

To use the Firepod provider to get the SiteSettings for example:
```dart
class UserSiteSettings extends ConsumerWidget {
  static final siteSettingsProvider = FirepodObject<SiteSettings>(
    name: 'ExampleFirepodSiteSettings',
    path: '/v1/{user}/site-settings/{site}',
    decoder: SiteSettings.fromJson,
    encoder: SiteSettings.toJson,
    none: SiteSettings.none,
    watch: false,
    autoSave: true,
  );
  const UserSiteSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siteSettings = ref.watch(siteSettingsProvider.value);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(siteSettings.siteName),
            Text(siteSettings.contactPhoneNumber),
            ElevatedButton(
              child: const Text('Remove Phone Number'),
              onPressed: () {
                ref.read(siteSettingsProvider.notifier).update(
                  siteSettings.copyWith(
                    contactPhoneNumber: '',
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

```

## Firepod - scalar string value

This creates a Firepod provider that binds to a scalar string value in the database.

```dart
  static final firepodScalarString = FirepodScalarString(
    name: 'ExampleFirepodScalarString',
    path: '$basePath/string',
    watch: true,
    autoSave: true,
  );
```

## Firepod - list of strings provider

This creates a Firepod provider that binds to a list of strings in Firebase.

```dart
  static final stringList = FirepodListString(
    name: 'ExampleFirepodListString',
    path: '$basePath/strings',
    watch: true,
    autoSave: true,
  );
```

## Firepod - map of strings provider

This creates a Firepod provider that binds to a map of strings in Firebase.

```dart
  static final stringMap = FirepodMapString(
    name: 'ExampleFirepodMapString',
    path: '$basePath/site1',
    watch: true,
    autoSave: true,
  );
```