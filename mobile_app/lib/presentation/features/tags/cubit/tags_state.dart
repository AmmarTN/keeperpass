part of 'tags_cubit.dart';

@freezed
abstract class TagsState with _$TagsState {
  const TagsState._();

  const factory TagsState({
    /// Every known tag, most used first (web `VaultStore.tags`).
    @Default(<TagInfo>[]) List<TagInfo> tags,
    @Default(false) bool selecting,
    @Default(<String>{}) Set<String> selected,
  }) = _TagsState;

  /// Whether a tag of that exact name exists (web `tagNames`).
  bool has(String name) => tags.any((TagInfo tag) => tag.name == name);
}
