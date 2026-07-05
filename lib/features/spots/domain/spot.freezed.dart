// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Spot {

 String get name; String get meta; double get rating; IconData get sportIcon; double get lat; double get lng; Color get pinColor;
/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotCopyWith<Spot> get copyWith => _$SpotCopyWithImpl<Spot>(this as Spot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Spot&&(identical(other.name, name) || other.name == name)&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.sportIcon, sportIcon) || other.sportIcon == sportIcon)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.pinColor, pinColor) || other.pinColor == pinColor));
}


@override
int get hashCode => Object.hash(runtimeType,name,meta,rating,sportIcon,lat,lng,pinColor);

@override
String toString() {
  return 'Spot(name: $name, meta: $meta, rating: $rating, sportIcon: $sportIcon, lat: $lat, lng: $lng, pinColor: $pinColor)';
}


}

/// @nodoc
abstract mixin class $SpotCopyWith<$Res>  {
  factory $SpotCopyWith(Spot value, $Res Function(Spot) _then) = _$SpotCopyWithImpl;
@useResult
$Res call({
 String name, String meta, double rating, IconData sportIcon, double lat, double lng, Color pinColor
});




}
/// @nodoc
class _$SpotCopyWithImpl<$Res>
    implements $SpotCopyWith<$Res> {
  _$SpotCopyWithImpl(this._self, this._then);

  final Spot _self;
  final $Res Function(Spot) _then;

/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? meta = null,Object? rating = null,Object? sportIcon = null,Object? lat = null,Object? lng = null,Object? pinColor = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,sportIcon: null == sportIcon ? _self.sportIcon : sportIcon // ignore: cast_nullable_to_non_nullable
as IconData,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,pinColor: null == pinColor ? _self.pinColor : pinColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [Spot].
extension SpotPatterns on Spot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Spot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Spot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Spot value)  $default,){
final _that = this;
switch (_that) {
case _Spot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Spot value)?  $default,){
final _that = this;
switch (_that) {
case _Spot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String meta,  double rating,  IconData sportIcon,  double lat,  double lng,  Color pinColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Spot() when $default != null:
return $default(_that.name,_that.meta,_that.rating,_that.sportIcon,_that.lat,_that.lng,_that.pinColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String meta,  double rating,  IconData sportIcon,  double lat,  double lng,  Color pinColor)  $default,) {final _that = this;
switch (_that) {
case _Spot():
return $default(_that.name,_that.meta,_that.rating,_that.sportIcon,_that.lat,_that.lng,_that.pinColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String meta,  double rating,  IconData sportIcon,  double lat,  double lng,  Color pinColor)?  $default,) {final _that = this;
switch (_that) {
case _Spot() when $default != null:
return $default(_that.name,_that.meta,_that.rating,_that.sportIcon,_that.lat,_that.lng,_that.pinColor);case _:
  return null;

}
}

}

/// @nodoc


class _Spot implements Spot {
  const _Spot({required this.name, required this.meta, required this.rating, required this.sportIcon, required this.lat, required this.lng, required this.pinColor});
  

@override final  String name;
@override final  String meta;
@override final  double rating;
@override final  IconData sportIcon;
@override final  double lat;
@override final  double lng;
@override final  Color pinColor;

/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotCopyWith<_Spot> get copyWith => __$SpotCopyWithImpl<_Spot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Spot&&(identical(other.name, name) || other.name == name)&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.sportIcon, sportIcon) || other.sportIcon == sportIcon)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.pinColor, pinColor) || other.pinColor == pinColor));
}


@override
int get hashCode => Object.hash(runtimeType,name,meta,rating,sportIcon,lat,lng,pinColor);

@override
String toString() {
  return 'Spot(name: $name, meta: $meta, rating: $rating, sportIcon: $sportIcon, lat: $lat, lng: $lng, pinColor: $pinColor)';
}


}

/// @nodoc
abstract mixin class _$SpotCopyWith<$Res> implements $SpotCopyWith<$Res> {
  factory _$SpotCopyWith(_Spot value, $Res Function(_Spot) _then) = __$SpotCopyWithImpl;
@override @useResult
$Res call({
 String name, String meta, double rating, IconData sportIcon, double lat, double lng, Color pinColor
});




}
/// @nodoc
class __$SpotCopyWithImpl<$Res>
    implements _$SpotCopyWith<$Res> {
  __$SpotCopyWithImpl(this._self, this._then);

  final _Spot _self;
  final $Res Function(_Spot) _then;

/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? meta = null,Object? rating = null,Object? sportIcon = null,Object? lat = null,Object? lng = null,Object? pinColor = null,}) {
  return _then(_Spot(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,sportIcon: null == sportIcon ? _self.sportIcon : sportIcon // ignore: cast_nullable_to_non_nullable
as IconData,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,pinColor: null == pinColor ? _self.pinColor : pinColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
