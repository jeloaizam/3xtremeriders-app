// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_media_ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaBucket {

 List<RankedMediaItem> get photos; List<RankedMediaItem> get videos;
/// Create a copy of MediaBucket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaBucketCopyWith<MediaBucket> get copyWith => _$MediaBucketCopyWithImpl<MediaBucket>(this as MediaBucket, _$identity);

  /// Serializes this MediaBucket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaBucket&&const DeepCollectionEquality().equals(other.photos, photos)&&const DeepCollectionEquality().equals(other.videos, videos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(photos),const DeepCollectionEquality().hash(videos));

@override
String toString() {
  return 'MediaBucket(photos: $photos, videos: $videos)';
}


}

/// @nodoc
abstract mixin class $MediaBucketCopyWith<$Res>  {
  factory $MediaBucketCopyWith(MediaBucket value, $Res Function(MediaBucket) _then) = _$MediaBucketCopyWithImpl;
@useResult
$Res call({
 List<RankedMediaItem> photos, List<RankedMediaItem> videos
});




}
/// @nodoc
class _$MediaBucketCopyWithImpl<$Res>
    implements $MediaBucketCopyWith<$Res> {
  _$MediaBucketCopyWithImpl(this._self, this._then);

  final MediaBucket _self;
  final $Res Function(MediaBucket) _then;

/// Create a copy of MediaBucket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? photos = null,Object? videos = null,}) {
  return _then(_self.copyWith(
photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaBucket].
extension MediaBucketPatterns on MediaBucket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaBucket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaBucket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaBucket value)  $default,){
final _that = this;
switch (_that) {
case _MediaBucket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaBucket value)?  $default,){
final _that = this;
switch (_that) {
case _MediaBucket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RankedMediaItem> photos,  List<RankedMediaItem> videos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaBucket() when $default != null:
return $default(_that.photos,_that.videos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RankedMediaItem> photos,  List<RankedMediaItem> videos)  $default,) {final _that = this;
switch (_that) {
case _MediaBucket():
return $default(_that.photos,_that.videos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RankedMediaItem> photos,  List<RankedMediaItem> videos)?  $default,) {final _that = this;
switch (_that) {
case _MediaBucket() when $default != null:
return $default(_that.photos,_that.videos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaBucket implements MediaBucket {
  const _MediaBucket({required final  List<RankedMediaItem> photos, required final  List<RankedMediaItem> videos}): _photos = photos,_videos = videos;
  factory _MediaBucket.fromJson(Map<String, dynamic> json) => _$MediaBucketFromJson(json);

 final  List<RankedMediaItem> _photos;
@override List<RankedMediaItem> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

 final  List<RankedMediaItem> _videos;
@override List<RankedMediaItem> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}


/// Create a copy of MediaBucket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaBucketCopyWith<_MediaBucket> get copyWith => __$MediaBucketCopyWithImpl<_MediaBucket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaBucketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaBucket&&const DeepCollectionEquality().equals(other._photos, _photos)&&const DeepCollectionEquality().equals(other._videos, _videos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_videos));

@override
String toString() {
  return 'MediaBucket(photos: $photos, videos: $videos)';
}


}

/// @nodoc
abstract mixin class _$MediaBucketCopyWith<$Res> implements $MediaBucketCopyWith<$Res> {
  factory _$MediaBucketCopyWith(_MediaBucket value, $Res Function(_MediaBucket) _then) = __$MediaBucketCopyWithImpl;
@override @useResult
$Res call({
 List<RankedMediaItem> photos, List<RankedMediaItem> videos
});




}
/// @nodoc
class __$MediaBucketCopyWithImpl<$Res>
    implements _$MediaBucketCopyWith<$Res> {
  __$MediaBucketCopyWithImpl(this._self, this._then);

  final _MediaBucket _self;
  final $Res Function(_MediaBucket) _then;

/// Create a copy of MediaBucket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? photos = null,Object? videos = null,}) {
  return _then(_MediaBucket(
photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,
  ));
}


}


/// @nodoc
mixin _$SpotMediaRanking {

 MediaBucket get female; MediaBucket get male; MediaBucket get alien;
/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotMediaRankingCopyWith<SpotMediaRanking> get copyWith => _$SpotMediaRankingCopyWithImpl<SpotMediaRanking>(this as SpotMediaRanking, _$identity);

  /// Serializes this SpotMediaRanking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotMediaRanking&&(identical(other.female, female) || other.female == female)&&(identical(other.male, male) || other.male == male)&&(identical(other.alien, alien) || other.alien == alien));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,female,male,alien);

@override
String toString() {
  return 'SpotMediaRanking(female: $female, male: $male, alien: $alien)';
}


}

/// @nodoc
abstract mixin class $SpotMediaRankingCopyWith<$Res>  {
  factory $SpotMediaRankingCopyWith(SpotMediaRanking value, $Res Function(SpotMediaRanking) _then) = _$SpotMediaRankingCopyWithImpl;
@useResult
$Res call({
 MediaBucket female, MediaBucket male, MediaBucket alien
});


$MediaBucketCopyWith<$Res> get female;$MediaBucketCopyWith<$Res> get male;$MediaBucketCopyWith<$Res> get alien;

}
/// @nodoc
class _$SpotMediaRankingCopyWithImpl<$Res>
    implements $SpotMediaRankingCopyWith<$Res> {
  _$SpotMediaRankingCopyWithImpl(this._self, this._then);

  final SpotMediaRanking _self;
  final $Res Function(SpotMediaRanking) _then;

/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? female = null,Object? male = null,Object? alien = null,}) {
  return _then(_self.copyWith(
female: null == female ? _self.female : female // ignore: cast_nullable_to_non_nullable
as MediaBucket,male: null == male ? _self.male : male // ignore: cast_nullable_to_non_nullable
as MediaBucket,alien: null == alien ? _self.alien : alien // ignore: cast_nullable_to_non_nullable
as MediaBucket,
  ));
}
/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaBucketCopyWith<$Res> get female {
  
  return $MediaBucketCopyWith<$Res>(_self.female, (value) {
    return _then(_self.copyWith(female: value));
  });
}/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaBucketCopyWith<$Res> get male {
  
  return $MediaBucketCopyWith<$Res>(_self.male, (value) {
    return _then(_self.copyWith(male: value));
  });
}/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaBucketCopyWith<$Res> get alien {
  
  return $MediaBucketCopyWith<$Res>(_self.alien, (value) {
    return _then(_self.copyWith(alien: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpotMediaRanking].
extension SpotMediaRankingPatterns on SpotMediaRanking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotMediaRanking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotMediaRanking value)  $default,){
final _that = this;
switch (_that) {
case _SpotMediaRanking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotMediaRanking value)?  $default,){
final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MediaBucket female,  MediaBucket male,  MediaBucket alien)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
return $default(_that.female,_that.male,_that.alien);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MediaBucket female,  MediaBucket male,  MediaBucket alien)  $default,) {final _that = this;
switch (_that) {
case _SpotMediaRanking():
return $default(_that.female,_that.male,_that.alien);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MediaBucket female,  MediaBucket male,  MediaBucket alien)?  $default,) {final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
return $default(_that.female,_that.male,_that.alien);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotMediaRanking implements SpotMediaRanking {
  const _SpotMediaRanking({required this.female, required this.male, required this.alien});
  factory _SpotMediaRanking.fromJson(Map<String, dynamic> json) => _$SpotMediaRankingFromJson(json);

@override final  MediaBucket female;
@override final  MediaBucket male;
@override final  MediaBucket alien;

/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotMediaRankingCopyWith<_SpotMediaRanking> get copyWith => __$SpotMediaRankingCopyWithImpl<_SpotMediaRanking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotMediaRankingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotMediaRanking&&(identical(other.female, female) || other.female == female)&&(identical(other.male, male) || other.male == male)&&(identical(other.alien, alien) || other.alien == alien));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,female,male,alien);

@override
String toString() {
  return 'SpotMediaRanking(female: $female, male: $male, alien: $alien)';
}


}

/// @nodoc
abstract mixin class _$SpotMediaRankingCopyWith<$Res> implements $SpotMediaRankingCopyWith<$Res> {
  factory _$SpotMediaRankingCopyWith(_SpotMediaRanking value, $Res Function(_SpotMediaRanking) _then) = __$SpotMediaRankingCopyWithImpl;
@override @useResult
$Res call({
 MediaBucket female, MediaBucket male, MediaBucket alien
});


@override $MediaBucketCopyWith<$Res> get female;@override $MediaBucketCopyWith<$Res> get male;@override $MediaBucketCopyWith<$Res> get alien;

}
/// @nodoc
class __$SpotMediaRankingCopyWithImpl<$Res>
    implements _$SpotMediaRankingCopyWith<$Res> {
  __$SpotMediaRankingCopyWithImpl(this._self, this._then);

  final _SpotMediaRanking _self;
  final $Res Function(_SpotMediaRanking) _then;

/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? female = null,Object? male = null,Object? alien = null,}) {
  return _then(_SpotMediaRanking(
female: null == female ? _self.female : female // ignore: cast_nullable_to_non_nullable
as MediaBucket,male: null == male ? _self.male : male // ignore: cast_nullable_to_non_nullable
as MediaBucket,alien: null == alien ? _self.alien : alien // ignore: cast_nullable_to_non_nullable
as MediaBucket,
  ));
}

/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaBucketCopyWith<$Res> get female {
  
  return $MediaBucketCopyWith<$Res>(_self.female, (value) {
    return _then(_self.copyWith(female: value));
  });
}/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaBucketCopyWith<$Res> get male {
  
  return $MediaBucketCopyWith<$Res>(_self.male, (value) {
    return _then(_self.copyWith(male: value));
  });
}/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaBucketCopyWith<$Res> get alien {
  
  return $MediaBucketCopyWith<$Res>(_self.alien, (value) {
    return _then(_self.copyWith(alien: value));
  });
}
}

// dart format on
