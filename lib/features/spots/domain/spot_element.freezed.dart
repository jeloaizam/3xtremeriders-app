// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotElement {

 int get id;@JsonKey(name: 'spot_id') int get spotId; String get name; String? get description; String? get type; int? get difficulty;
/// Create a copy of SpotElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotElementCopyWith<SpotElement> get copyWith => _$SpotElementCopyWithImpl<SpotElement>(this as SpotElement, _$identity);

  /// Serializes this SpotElement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotElement&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,name,description,type,difficulty);

@override
String toString() {
  return 'SpotElement(id: $id, spotId: $spotId, name: $name, description: $description, type: $type, difficulty: $difficulty)';
}


}

/// @nodoc
abstract mixin class $SpotElementCopyWith<$Res>  {
  factory $SpotElementCopyWith(SpotElement value, $Res Function(SpotElement) _then) = _$SpotElementCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId, String name, String? description, String? type, int? difficulty
});




}
/// @nodoc
class _$SpotElementCopyWithImpl<$Res>
    implements $SpotElementCopyWith<$Res> {
  _$SpotElementCopyWithImpl(this._self, this._then);

  final SpotElement _self;
  final $Res Function(SpotElement) _then;

/// Create a copy of SpotElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spotId = null,Object? name = null,Object? description = freezed,Object? type = freezed,Object? difficulty = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotElement].
extension SpotElementPatterns on SpotElement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotElement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotElement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotElement value)  $default,){
final _that = this;
switch (_that) {
case _SpotElement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotElement value)?  $default,){
final _that = this;
switch (_that) {
case _SpotElement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String name,  String? description,  String? type,  int? difficulty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotElement() when $default != null:
return $default(_that.id,_that.spotId,_that.name,_that.description,_that.type,_that.difficulty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String name,  String? description,  String? type,  int? difficulty)  $default,) {final _that = this;
switch (_that) {
case _SpotElement():
return $default(_that.id,_that.spotId,_that.name,_that.description,_that.type,_that.difficulty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String name,  String? description,  String? type,  int? difficulty)?  $default,) {final _that = this;
switch (_that) {
case _SpotElement() when $default != null:
return $default(_that.id,_that.spotId,_that.name,_that.description,_that.type,_that.difficulty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotElement implements SpotElement {
  const _SpotElement({required this.id, @JsonKey(name: 'spot_id') required this.spotId, required this.name, this.description, this.type, this.difficulty});
  factory _SpotElement.fromJson(Map<String, dynamic> json) => _$SpotElementFromJson(json);

@override final  int id;
@override@JsonKey(name: 'spot_id') final  int spotId;
@override final  String name;
@override final  String? description;
@override final  String? type;
@override final  int? difficulty;

/// Create a copy of SpotElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotElementCopyWith<_SpotElement> get copyWith => __$SpotElementCopyWithImpl<_SpotElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotElement&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,name,description,type,difficulty);

@override
String toString() {
  return 'SpotElement(id: $id, spotId: $spotId, name: $name, description: $description, type: $type, difficulty: $difficulty)';
}


}

/// @nodoc
abstract mixin class _$SpotElementCopyWith<$Res> implements $SpotElementCopyWith<$Res> {
  factory _$SpotElementCopyWith(_SpotElement value, $Res Function(_SpotElement) _then) = __$SpotElementCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId, String name, String? description, String? type, int? difficulty
});




}
/// @nodoc
class __$SpotElementCopyWithImpl<$Res>
    implements _$SpotElementCopyWith<$Res> {
  __$SpotElementCopyWithImpl(this._self, this._then);

  final _SpotElement _self;
  final $Res Function(_SpotElement) _then;

/// Create a copy of SpotElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spotId = null,Object? name = null,Object? description = freezed,Object? type = freezed,Object? difficulty = freezed,}) {
  return _then(_SpotElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
