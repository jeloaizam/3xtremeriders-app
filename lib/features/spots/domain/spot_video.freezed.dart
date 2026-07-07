// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotVideo {

 int get id;@JsonKey(name: 'spot_id') int get spotId; String get url; String? get provider; String? get caption;@JsonKey(name: 'vote_count') int get voteCount;
/// Create a copy of SpotVideo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotVideoCopyWith<SpotVideo> get copyWith => _$SpotVideoCopyWithImpl<SpotVideo>(this as SpotVideo, _$identity);

  /// Serializes this SpotVideo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotVideo&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.url, url) || other.url == url)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,url,provider,caption,voteCount);

@override
String toString() {
  return 'SpotVideo(id: $id, spotId: $spotId, url: $url, provider: $provider, caption: $caption, voteCount: $voteCount)';
}


}

/// @nodoc
abstract mixin class $SpotVideoCopyWith<$Res>  {
  factory $SpotVideoCopyWith(SpotVideo value, $Res Function(SpotVideo) _then) = _$SpotVideoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId, String url, String? provider, String? caption,@JsonKey(name: 'vote_count') int voteCount
});




}
/// @nodoc
class _$SpotVideoCopyWithImpl<$Res>
    implements $SpotVideoCopyWith<$Res> {
  _$SpotVideoCopyWithImpl(this._self, this._then);

  final SpotVideo _self;
  final $Res Function(SpotVideo) _then;

/// Create a copy of SpotVideo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spotId = null,Object? url = null,Object? provider = freezed,Object? caption = freezed,Object? voteCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotVideo].
extension SpotVideoPatterns on SpotVideo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotVideo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotVideo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotVideo value)  $default,){
final _that = this;
switch (_that) {
case _SpotVideo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotVideo value)?  $default,){
final _that = this;
switch (_that) {
case _SpotVideo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String url,  String? provider,  String? caption, @JsonKey(name: 'vote_count')  int voteCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotVideo() when $default != null:
return $default(_that.id,_that.spotId,_that.url,_that.provider,_that.caption,_that.voteCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String url,  String? provider,  String? caption, @JsonKey(name: 'vote_count')  int voteCount)  $default,) {final _that = this;
switch (_that) {
case _SpotVideo():
return $default(_that.id,_that.spotId,_that.url,_that.provider,_that.caption,_that.voteCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String url,  String? provider,  String? caption, @JsonKey(name: 'vote_count')  int voteCount)?  $default,) {final _that = this;
switch (_that) {
case _SpotVideo() when $default != null:
return $default(_that.id,_that.spotId,_that.url,_that.provider,_that.caption,_that.voteCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotVideo implements SpotVideo {
  const _SpotVideo({required this.id, @JsonKey(name: 'spot_id') required this.spotId, required this.url, this.provider, this.caption, @JsonKey(name: 'vote_count') required this.voteCount});
  factory _SpotVideo.fromJson(Map<String, dynamic> json) => _$SpotVideoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'spot_id') final  int spotId;
@override final  String url;
@override final  String? provider;
@override final  String? caption;
@override@JsonKey(name: 'vote_count') final  int voteCount;

/// Create a copy of SpotVideo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotVideoCopyWith<_SpotVideo> get copyWith => __$SpotVideoCopyWithImpl<_SpotVideo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotVideoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotVideo&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.url, url) || other.url == url)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,url,provider,caption,voteCount);

@override
String toString() {
  return 'SpotVideo(id: $id, spotId: $spotId, url: $url, provider: $provider, caption: $caption, voteCount: $voteCount)';
}


}

/// @nodoc
abstract mixin class _$SpotVideoCopyWith<$Res> implements $SpotVideoCopyWith<$Res> {
  factory _$SpotVideoCopyWith(_SpotVideo value, $Res Function(_SpotVideo) _then) = __$SpotVideoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId, String url, String? provider, String? caption,@JsonKey(name: 'vote_count') int voteCount
});




}
/// @nodoc
class __$SpotVideoCopyWithImpl<$Res>
    implements _$SpotVideoCopyWith<$Res> {
  __$SpotVideoCopyWithImpl(this._self, this._then);

  final _SpotVideo _self;
  final $Res Function(_SpotVideo) _then;

/// Create a copy of SpotVideo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spotId = null,Object? url = null,Object? provider = freezed,Object? caption = freezed,Object? voteCount = null,}) {
  return _then(_SpotVideo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
