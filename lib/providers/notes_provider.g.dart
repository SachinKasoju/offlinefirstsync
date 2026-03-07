// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notesRepositoryHash() => r'c4041d932ba5c79e1731dce9822ab0c42f1b92e2';

/// Repository Provider
///
/// Copied from [notesRepository].
@ProviderFor(notesRepository)
final notesRepositoryProvider = AutoDisposeProvider<NotesRepository>.internal(
  notesRepository,
  name: r'notesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotesRepositoryRef = AutoDisposeProviderRef<NotesRepository>;
String _$notesNotifierHash() => r'0949ea2fc17749bb94c23bd3cfce497056ca9628';

/// Notes State Notifier
///
/// Copied from [NotesNotifier].
@ProviderFor(NotesNotifier)
final notesNotifierProvider =
    AutoDisposeNotifierProvider<
      NotesNotifier,
      List<Map<String, dynamic>>
    >.internal(
      NotesNotifier.new,
      name: r'notesNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotesNotifier = AutoDisposeNotifier<List<Map<String, dynamic>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
