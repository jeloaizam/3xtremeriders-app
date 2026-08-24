// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranked_media_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankedMediaItem {

 int get id; String get type; String get url;@JsonKey(name: 'thumbnail_url') String? get thumbnailUrl;@JsonKey(name: 'vote_count') int get voteCount;@JsonKey(name: 'uploaded_by') int get uploadedBy; String? get caption;@JsonKey(name: 'created_date') DateTime get createdDate;
/// Create a copy of RankedMediaItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankedMediaItemCopyWith<RankedMediaItem> get copyWith => _$RankedMediaItemCopyWithImpl<RankedMediaItem>(this as RankedMediaItem, _$identity);

  /// Serializes this RankedMediaItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankedMediaItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,url,thumbnailUrl,voteCount,uploadedBy,caption,createdDate);

@override
String toString() {
  return 'RankedMediaItem(id: $id, type: $type, url: $url, thumbnailUrl: $thumbnailUrl, voteCount: $voteCount, uploadedBy: $uploadedBy, caption: $caption, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $RankedMediaItemCopyWith<$Res>  {
  factory $RankedMediaItemCopyWith(RankedMediaItem value, $Res Function(RankedMediaItem) _then) = _$RankedMediaItemCopyWithImpl;
@useResult
$Res call({
 int id, String type, String url,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'vote_count') int voteCount,@JsonKey(name: 'uploaded_by') int uploadedBy, String? caption,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class _$RankedMediaItemCopyWithImpl<$Res>
    implements $RankedMediaItemCopyWith<$Res> {
  _$RankedMediaItemCopyWithImpl(this._self, this._then);

  final RankedMediaItem _self;
  final $Res Function(RankedMediaItem) _then;

/// Create a copy of RankedMediaItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? url = null,Object? thumbnailUrl = freezed,Object? voteCount = null,Object? uploadedBy = null,Object? caption = freezed,Object? createdDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as int,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RankedMediaItem].
extension RankedMediaItemPatterns on RankedMediaItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankedMediaItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankedMediaItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankedMediaItem value)  $default,){
final _that = this;
switch (_that) {
case _RankedMediaItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankedMediaItem value)?  $default,){
final _that = this;
switch (_that) {
case _RankedMediaItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String url, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'uploaded_by')  int uploadedBy,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankedMediaItem() when $default != null:
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.voteCount,_that.uploadedBy,_that.caption,_that.createdDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String url, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'uploaded_by')  int uploadedBy,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)  $default,) {final _that = this;
switch (_that) {
case _RankedMediaItem():
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.voteCount,_that.uploadedBy,_that.caption,_that.createdDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String url, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'uploaded_by')  int uploadedBy,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,) {final _that = this;
switch (_that) {
case _RankedMediaItem() when $default != null:
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.voteCount,_that.uploadedBy,_that.caption,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankedMediaItem implements RankedMediaItem {
  const _RankedMediaItem({required this.id, required this.type, required this.url, @JsonKey(name: 'thumbnail_url') this.thumbnailUrl, @JsonKey(name: 'vote_count') required this.voteCount, @JsonKey(name: 'uploaded_by') required this.uploadedBy, this.caption, @JsonKey(name: 'created_date') required this.createdDate});
  factory _RankedMediaItem.fromJson(Map<String, dynamic> json) => _$RankedMediaItemFromJson(json);

@override final  int id;
@override final  String type;
@override final  String url;
@override@JsonKey(name: 'thumbnail_url') final  String? thumbnailUrl;
@override@JsonKey(name: 'vote_count') final  int voteCount;
@override@JsonKey(name: 'uploaded_by') final  int uploadedBy;
@override final  String? caption;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;

/// Create a copy of RankedMediaItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankedMediaItemCopyWith<_RankedMediaItem> get copyWith => __$RankedMediaItemCopyWithImpl<_RankedMediaItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankedMediaItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankedMediaItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,url,thumbnailUrl,voteCount,uploadedBy,caption,createdDate);

@override
String toString() {
  return 'RankedMediaItem(id: $id, type: $type, url: $url, thumbnailUrl: $thumbnailUrl, voteCount: $voteCount, uploadedBy: $uploadedBy, caption: $caption, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$RankedMediaItemCopyWith<$Res> implements $RankedMediaItemCopyWith<$Res> {
  factory _$RankedMediaItemCopyWith(_RankedMediaItem value, $Res Function(_RankedMediaItem) _then) = __$RankedMediaItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String url,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'vote_count') int voteCount,@JsonKey(name: 'uploaded_by') int uploadedBy, String? caption,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class __$RankedMediaItemCopyWithImpl<$Res>
    implements _$RankedMediaItemCopyWith<$Res> {
  __$RankedMediaItemCopyWithImpl(this._self, this._then);

  final _RankedMediaItem _self;
  final $Res Function(_RankedMediaItem) _then;

/// Create a copy of RankedMediaItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? url = null,Object? thumbnailUrl = freezed,Object? voteCount = null,Object? uploadedBy = null,Object? caption = freezed,Object? createdDate = null,}) {
  return _then(_RankedMediaItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as int,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
