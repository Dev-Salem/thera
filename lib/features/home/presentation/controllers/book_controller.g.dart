// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$singleBookProviderHash() =>
    r'01b908050f3a2e539f369823bd5c0953d9c1ad0d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [singleBookProvider].
@ProviderFor(singleBookProvider)
const singleBookProviderProvider = SingleBookProviderFamily();

/// See also [singleBookProvider].
class SingleBookProviderFamily extends Family<AsyncValue<Book>> {
  /// See also [singleBookProvider].
  const SingleBookProviderFamily();

  /// See also [singleBookProvider].
  SingleBookProviderProvider call(
    String bookName,
  ) {
    return SingleBookProviderProvider(
      bookName,
    );
  }

  @override
  SingleBookProviderProvider getProviderOverride(
    covariant SingleBookProviderProvider provider,
  ) {
    return call(
      provider.bookName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleBookProviderProvider';
}

/// See also [singleBookProvider].
class SingleBookProviderProvider extends AutoDisposeFutureProvider<Book> {
  /// See also [singleBookProvider].
  SingleBookProviderProvider(
    String bookName,
  ) : this._internal(
          (ref) => singleBookProvider(
            ref as SingleBookProviderRef,
            bookName,
          ),
          from: singleBookProviderProvider,
          name: r'singleBookProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$singleBookProviderHash,
          dependencies: SingleBookProviderFamily._dependencies,
          allTransitiveDependencies:
              SingleBookProviderFamily._allTransitiveDependencies,
          bookName: bookName,
        );

  SingleBookProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookName,
  }) : super.internal();

  final String bookName;

  @override
  Override overrideWith(
    FutureOr<Book> Function(SingleBookProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SingleBookProviderProvider._internal(
        (ref) => create(ref as SingleBookProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookName: bookName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Book> createElement() {
    return _SingleBookProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleBookProviderProvider && other.bookName == bookName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SingleBookProviderRef on AutoDisposeFutureProviderRef<Book> {
  /// The parameter `bookName` of this provider.
  String get bookName;
}

class _SingleBookProviderProviderElement
    extends AutoDisposeFutureProviderElement<Book> with SingleBookProviderRef {
  _SingleBookProviderProviderElement(super.provider);

  @override
  String get bookName => (origin as SingleBookProviderProvider).bookName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
