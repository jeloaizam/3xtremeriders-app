// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotPhoto {

 int get id;@JsonKey(name: 'spot_id') int get spotId;@JsonKey(name: 'sport_id') int? get sportId; String get url; String? get caption;@JsonKey(name: 'vote_count') int get voteCount;
/// Create a copy of SpotPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotPhotoCopyWith<SpotPhoto> get copyWith => _$SpotPhotoCopyWithImpl<SpotPhoto>(this as SpotPhoto, _$identity);

  /// Serializes this SpotPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.url, url) || other.url == url)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,sportId,url,caption,voteCount);

@override
String toString() {
  return 'SpotPhoto(id: $id, spotId: $spotId, sportId: $sportId, url: $url, caption: $caption, voteCount: $voteCount)';
}


}

/// @nodoc
abstract mixin class $SpotPhotoCopyWith<$Res>  {
  factory $SpotPhotoCopyWith(SpotPhoto value, $Res Function(SpotPhoto) _then) = _$SpotPhotoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId,@JsonKey(name: 'sport_id') int? sportId, String url, String? caption,@JsonKey(name: 'vote_count') int voteCount
});




}
/// @nodoc
class _$SpotPhotoCopyWithImpl<$Res>
    implements $SpotPhotoCopyWith<$Res> {
  _$SpotPhotoCopyWithImpl(this._self, this._then);

  final SpotPhoto _self;
  final $Res Function(SpotPhoto) _then;

/// Create a copy of SpotPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spotId = null,Object? sportId = freezed,Object? url = null,Object? caption = freezed,Object? voteCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,sportId: freezed == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as int?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotPhoto].
extension SpotPhotoPatterns on SpotPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotPhoto value)  $default,){
final _that = this;
switch (_that) {
case _SpotPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _SpotPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'sport_id')  int? sportId,  String url,  String? caption, @JsonKey(name: 'vote_count')  int voteCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotPhoto() when $default != null:
return $default(_that.id,_that.spotId,_that.sportId,_that.url,_that.caption,_that.voteCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'sport_id')  int? sportId,  String url,  String? caption, @JsonKey(name: 'vote_count')  int voteCount)  $default,) {final _that = this;
switch (_that) {
case _SpotPhoto():
return $default(_that.id,_that.spotId,_that.sportId,_that.url,_that.caption,_that.voteCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'sport_id')  int? sportId,  String url,  String? caption, @JsonKey(name: 'vote_count')  int voteCount)?  $default,) {final _that = this;
switch (_that) {
case _SpotPhoto() when $default != null:
return $default(_that.id,_that.spotId,_that.sportId,_that.url,_that.caption,_that.voteCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotPhoto implements SpotPhoto {
  const _SpotPhoto({required this.id, @JsonKey(name: 'spot_id') required this.spotId, @JsonKey(name: 'sport_id') this.sportId, required this.url, this.caption, @JsonKey(name: 'vote_count') required this.voteCount});
  factory _SpotPhoto.fromJson(Map<String, dynamic> json) => _$SpotPhotoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'spot_id') final  int spotId;
@override@JsonKey(name: 'sport_id') final  int? sportId;
@override final  String url;
@override final  String? caption;
@override@JsonKey(name: 'vote_count') final  int voteCount;

/// Create a copy of SpotPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotPhotoCopyWith<_SpotPhoto> get copyWith => __$SpotPhotoCopyWithImpl<_SpotPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.url, url) || other.url == url)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,sportId,url,caption,voteCount);

@override
String toString() {
  return 'SpotPhoto(id: $id, spotId: $spotId, sportId: $sportId, url: $url, caption: $caption, voteCount: $voteCount)';
}


}

/// @nodoc
abstract mixin class _$SpotPhotoCopyWith<$Res> implements $SpotPhotoCopyWith<$Res> {
  factory _$SpotPhotoCopyWith(_SpotPhoto value, $Res Function(_SpotPhoto) _then) = __$SpotPhotoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId,@JsonKey(name: 'sport_id') int? sportId, String url, String? caption,@JsonKey(name: 'vote_count') int voteCount
});




}
/// @nodoc
class __$SpotPhotoCopyWithImpl<$Res>
    implements _$SpotPhotoCopyWith<$Res> {
  __$SpotPhotoCopyWithImpl(this._self, this._then);

  final _SpotPhoto _self;
  final $Res Function(_SpotPhoto) _then;

/// Create a copy of SpotPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spotId = null,Object? sportId = freezed,Object? url = null,Object? caption = freezed,Object? voteCount = null,}) {
  return _then(_SpotPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,sportId: freezed == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as int?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
