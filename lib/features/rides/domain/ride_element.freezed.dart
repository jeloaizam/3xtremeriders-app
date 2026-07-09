// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RideElement {

 int get id;@JsonKey(name: 'ride_id') int get rideId; String get name; String? get type; String? get brand; String? get model; String? get description;@JsonKey(name: 'icon_image') String? get iconImage;@JsonKey(name: 'created_date') DateTime get createdDate;
/// Create a copy of RideElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideElementCopyWith<RideElement> get copyWith => _$RideElementCopyWithImpl<RideElement>(this as RideElement, _$identity);

  /// Serializes this RideElement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideElement&&(identical(other.id, id) || other.id == id)&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rideId,name,type,brand,model,description,iconImage,createdDate);

@override
String toString() {
  return 'RideElement(id: $id, rideId: $rideId, name: $name, type: $type, brand: $brand, model: $model, description: $description, iconImage: $iconImage, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $RideElementCopyWith<$Res>  {
  factory $RideElementCopyWith(RideElement value, $Res Function(RideElement) _then) = _$RideElementCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'ride_id') int rideId, String name, String? type, String? brand, String? model, String? description,@JsonKey(name: 'icon_image') String? iconImage,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class _$RideElementCopyWithImpl<$Res>
    implements $RideElementCopyWith<$Res> {
  _$RideElementCopyWithImpl(this._self, this._then);

  final RideElement _self;
  final $Res Function(RideElement) _then;

/// Create a copy of RideElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rideId = null,Object? name = null,Object? type = freezed,Object? brand = freezed,Object? model = freezed,Object? description = freezed,Object? iconImage = freezed,Object? createdDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rideId: null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RideElement].
extension RideElementPatterns on RideElement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RideElement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RideElement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RideElement value)  $default,){
final _that = this;
switch (_that) {
case _RideElement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RideElement value)?  $default,){
final _that = this;
switch (_that) {
case _RideElement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ride_id')  int rideId,  String name,  String? type,  String? brand,  String? model,  String? description, @JsonKey(name: 'icon_image')  String? iconImage, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideElement() when $default != null:
return $default(_that.id,_that.rideId,_that.name,_that.type,_that.brand,_that.model,_that.description,_that.iconImage,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ride_id')  int rideId,  String name,  String? type,  String? brand,  String? model,  String? description, @JsonKey(name: 'icon_image')  String? iconImage, @JsonKey(name: 'created_date')  DateTime createdDate)  $default,) {final _that = this;
switch (_that) {
case _RideElement():
return $default(_that.id,_that.rideId,_that.name,_that.type,_that.brand,_that.model,_that.description,_that.iconImage,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'ride_id')  int rideId,  String name,  String? type,  String? brand,  String? model,  String? description, @JsonKey(name: 'icon_image')  String? iconImage, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,) {final _that = this;
switch (_that) {
case _RideElement() when $default != null:
return $default(_that.id,_that.rideId,_that.name,_that.type,_that.brand,_that.model,_that.description,_that.iconImage,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RideElement implements RideElement {
  const _RideElement({required this.id, @JsonKey(name: 'ride_id') required this.rideId, required this.name, this.type, this.brand, this.model, this.description, @JsonKey(name: 'icon_image') this.iconImage, @JsonKey(name: 'created_date') required this.createdDate});
  factory _RideElement.fromJson(Map<String, dynamic> json) => _$RideElementFromJson(json);

@override final  int id;
@override@JsonKey(name: 'ride_id') final  int rideId;
@override final  String name;
@override final  String? type;
@override final  String? brand;
@override final  String? model;
@override final  String? description;
@override@JsonKey(name: 'icon_image') final  String? iconImage;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;

/// Create a copy of RideElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideElementCopyWith<_RideElement> get copyWith => __$RideElementCopyWithImpl<_RideElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RideElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideElement&&(identical(other.id, id) || other.id == id)&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rideId,name,type,brand,model,description,iconImage,createdDate);

@override
String toString() {
  return 'RideElement(id: $id, rideId: $rideId, name: $name, type: $type, brand: $brand, model: $model, description: $description, iconImage: $iconImage, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$RideElementCopyWith<$Res> implements $RideElementCopyWith<$Res> {
  factory _$RideElementCopyWith(_RideElement value, $Res Function(_RideElement) _then) = __$RideElementCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'ride_id') int rideId, String name, String? type, String? brand, String? model, String? description,@JsonKey(name: 'icon_image') String? iconImage,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class __$RideElementCopyWithImpl<$Res>
    implements _$RideElementCopyWith<$Res> {
  __$RideElementCopyWithImpl(this._self, this._then);

  final _RideElement _self;
  final $Res Function(_RideElement) _then;

/// Create a copy of RideElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rideId = null,Object? name = null,Object? type = freezed,Object? brand = freezed,Object? model = freezed,Object? description = freezed,Object? iconImage = freezed,Object? createdDate = null,}) {
  return _then(_RideElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rideId: null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
