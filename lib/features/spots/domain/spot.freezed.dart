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

 int get id; String get name; String get description; double get latitude; double get longitude; int? get difficulty;@JsonKey(name: 'best_season') String? get bestSeason; String? get neighborhood;@JsonKey(name: 'open_hour') String? get openHour;@JsonKey(name: 'close_hour') String? get closeHour;@JsonKey(name: 'created_by') int get createdBy;@JsonKey(name: 'state_id') int? get stateId;@JsonKey(name: 'rating_avg') double? get ratingAvg;@JsonKey(name: 'rating_count') int get ratingCount;@JsonKey(name: 'hazard_avg') double? get hazardAvg;@JsonKey(name: 'hazard_count') int get hazardCount;@JsonKey(name: 'vote_count') int get voteCount;@JsonKey(name: 'cover_photo_url') String? get coverPhotoUrl;@JsonKey(name: 'cover_video_url') String? get coverVideoUrl;@JsonKey(name: 'created_date') DateTime get createdDate;@JsonKey(name: 'updated_date') DateTime? get updatedDate;@JsonKey(name: 'sport_ids') List<int> get sportIds;
/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotCopyWith<Spot> get copyWith => _$SpotCopyWithImpl<Spot>(this as Spot, _$identity);

  /// Serializes this Spot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Spot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.bestSeason, bestSeason) || other.bestSeason == bestSeason)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.openHour, openHour) || other.openHour == openHour)&&(identical(other.closeHour, closeHour) || other.closeHour == closeHour)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.ratingAvg, ratingAvg) || other.ratingAvg == ratingAvg)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.hazardAvg, hazardAvg) || other.hazardAvg == hazardAvg)&&(identical(other.hazardCount, hazardCount) || other.hazardCount == hazardCount)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.coverVideoUrl, coverVideoUrl) || other.coverVideoUrl == coverVideoUrl)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&const DeepCollectionEquality().equals(other.sportIds, sportIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,latitude,longitude,difficulty,bestSeason,neighborhood,openHour,closeHour,createdBy,stateId,ratingAvg,ratingCount,hazardAvg,hazardCount,voteCount,coverPhotoUrl,coverVideoUrl,createdDate,updatedDate,const DeepCollectionEquality().hash(sportIds)]);

@override
String toString() {
  return 'Spot(id: $id, name: $name, description: $description, latitude: $latitude, longitude: $longitude, difficulty: $difficulty, bestSeason: $bestSeason, neighborhood: $neighborhood, openHour: $openHour, closeHour: $closeHour, createdBy: $createdBy, stateId: $stateId, ratingAvg: $ratingAvg, ratingCount: $ratingCount, hazardAvg: $hazardAvg, hazardCount: $hazardCount, voteCount: $voteCount, coverPhotoUrl: $coverPhotoUrl, coverVideoUrl: $coverVideoUrl, createdDate: $createdDate, updatedDate: $updatedDate, sportIds: $sportIds)';
}


}

/// @nodoc
abstract mixin class $SpotCopyWith<$Res>  {
  factory $SpotCopyWith(Spot value, $Res Function(Spot) _then) = _$SpotCopyWithImpl;
@useResult
$Res call({
 int id, String name, String description, double latitude, double longitude, int? difficulty,@JsonKey(name: 'best_season') String? bestSeason, String? neighborhood,@JsonKey(name: 'open_hour') String? openHour,@JsonKey(name: 'close_hour') String? closeHour,@JsonKey(name: 'created_by') int createdBy,@JsonKey(name: 'state_id') int? stateId,@JsonKey(name: 'rating_avg') double? ratingAvg,@JsonKey(name: 'rating_count') int ratingCount,@JsonKey(name: 'hazard_avg') double? hazardAvg,@JsonKey(name: 'hazard_count') int hazardCount,@JsonKey(name: 'vote_count') int voteCount,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'cover_video_url') String? coverVideoUrl,@JsonKey(name: 'created_date') DateTime createdDate,@JsonKey(name: 'updated_date') DateTime? updatedDate,@JsonKey(name: 'sport_ids') List<int> sportIds
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? latitude = null,Object? longitude = null,Object? difficulty = freezed,Object? bestSeason = freezed,Object? neighborhood = freezed,Object? openHour = freezed,Object? closeHour = freezed,Object? createdBy = null,Object? stateId = freezed,Object? ratingAvg = freezed,Object? ratingCount = null,Object? hazardAvg = freezed,Object? hazardCount = null,Object? voteCount = null,Object? coverPhotoUrl = freezed,Object? coverVideoUrl = freezed,Object? createdDate = null,Object? updatedDate = freezed,Object? sportIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int?,bestSeason: freezed == bestSeason ? _self.bestSeason : bestSeason // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String?,openHour: freezed == openHour ? _self.openHour : openHour // ignore: cast_nullable_to_non_nullable
as String?,closeHour: freezed == closeHour ? _self.closeHour : closeHour // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,ratingAvg: freezed == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,hazardAvg: freezed == hazardAvg ? _self.hazardAvg : hazardAvg // ignore: cast_nullable_to_non_nullable
as double?,hazardCount: null == hazardCount ? _self.hazardCount : hazardCount // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverVideoUrl: freezed == coverVideoUrl ? _self.coverVideoUrl : coverVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,updatedDate: freezed == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sportIds: null == sportIds ? _self.sportIds : sportIds // ignore: cast_nullable_to_non_nullable
as List<int>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String description,  double latitude,  double longitude,  int? difficulty, @JsonKey(name: 'best_season')  String? bestSeason,  String? neighborhood, @JsonKey(name: 'open_hour')  String? openHour, @JsonKey(name: 'close_hour')  String? closeHour, @JsonKey(name: 'created_by')  int createdBy, @JsonKey(name: 'state_id')  int? stateId, @JsonKey(name: 'rating_avg')  double? ratingAvg, @JsonKey(name: 'rating_count')  int ratingCount, @JsonKey(name: 'hazard_avg')  double? hazardAvg, @JsonKey(name: 'hazard_count')  int hazardCount, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'cover_video_url')  String? coverVideoUrl, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'updated_date')  DateTime? updatedDate, @JsonKey(name: 'sport_ids')  List<int> sportIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Spot() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.difficulty,_that.bestSeason,_that.neighborhood,_that.openHour,_that.closeHour,_that.createdBy,_that.stateId,_that.ratingAvg,_that.ratingCount,_that.hazardAvg,_that.hazardCount,_that.voteCount,_that.coverPhotoUrl,_that.coverVideoUrl,_that.createdDate,_that.updatedDate,_that.sportIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String description,  double latitude,  double longitude,  int? difficulty, @JsonKey(name: 'best_season')  String? bestSeason,  String? neighborhood, @JsonKey(name: 'open_hour')  String? openHour, @JsonKey(name: 'close_hour')  String? closeHour, @JsonKey(name: 'created_by')  int createdBy, @JsonKey(name: 'state_id')  int? stateId, @JsonKey(name: 'rating_avg')  double? ratingAvg, @JsonKey(name: 'rating_count')  int ratingCount, @JsonKey(name: 'hazard_avg')  double? hazardAvg, @JsonKey(name: 'hazard_count')  int hazardCount, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'cover_video_url')  String? coverVideoUrl, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'updated_date')  DateTime? updatedDate, @JsonKey(name: 'sport_ids')  List<int> sportIds)  $default,) {final _that = this;
switch (_that) {
case _Spot():
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.difficulty,_that.bestSeason,_that.neighborhood,_that.openHour,_that.closeHour,_that.createdBy,_that.stateId,_that.ratingAvg,_that.ratingCount,_that.hazardAvg,_that.hazardCount,_that.voteCount,_that.coverPhotoUrl,_that.coverVideoUrl,_that.createdDate,_that.updatedDate,_that.sportIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String description,  double latitude,  double longitude,  int? difficulty, @JsonKey(name: 'best_season')  String? bestSeason,  String? neighborhood, @JsonKey(name: 'open_hour')  String? openHour, @JsonKey(name: 'close_hour')  String? closeHour, @JsonKey(name: 'created_by')  int createdBy, @JsonKey(name: 'state_id')  int? stateId, @JsonKey(name: 'rating_avg')  double? ratingAvg, @JsonKey(name: 'rating_count')  int ratingCount, @JsonKey(name: 'hazard_avg')  double? hazardAvg, @JsonKey(name: 'hazard_count')  int hazardCount, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'cover_video_url')  String? coverVideoUrl, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'updated_date')  DateTime? updatedDate, @JsonKey(name: 'sport_ids')  List<int> sportIds)?  $default,) {final _that = this;
switch (_that) {
case _Spot() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.difficulty,_that.bestSeason,_that.neighborhood,_that.openHour,_that.closeHour,_that.createdBy,_that.stateId,_that.ratingAvg,_that.ratingCount,_that.hazardAvg,_that.hazardCount,_that.voteCount,_that.coverPhotoUrl,_that.coverVideoUrl,_that.createdDate,_that.updatedDate,_that.sportIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Spot implements Spot {
  const _Spot({required this.id, required this.name, required this.description, required this.latitude, required this.longitude, this.difficulty, @JsonKey(name: 'best_season') this.bestSeason, this.neighborhood, @JsonKey(name: 'open_hour') this.openHour, @JsonKey(name: 'close_hour') this.closeHour, @JsonKey(name: 'created_by') required this.createdBy, @JsonKey(name: 'state_id') this.stateId, @JsonKey(name: 'rating_avg') this.ratingAvg, @JsonKey(name: 'rating_count') required this.ratingCount, @JsonKey(name: 'hazard_avg') this.hazardAvg, @JsonKey(name: 'hazard_count') required this.hazardCount, @JsonKey(name: 'vote_count') required this.voteCount, @JsonKey(name: 'cover_photo_url') this.coverPhotoUrl, @JsonKey(name: 'cover_video_url') this.coverVideoUrl, @JsonKey(name: 'created_date') required this.createdDate, @JsonKey(name: 'updated_date') this.updatedDate, @JsonKey(name: 'sport_ids') final  List<int> sportIds = const []}): _sportIds = sportIds;
  factory _Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);

@override final  int id;
@override final  String name;
@override final  String description;
@override final  double latitude;
@override final  double longitude;
@override final  int? difficulty;
@override@JsonKey(name: 'best_season') final  String? bestSeason;
@override final  String? neighborhood;
@override@JsonKey(name: 'open_hour') final  String? openHour;
@override@JsonKey(name: 'close_hour') final  String? closeHour;
@override@JsonKey(name: 'created_by') final  int createdBy;
@override@JsonKey(name: 'state_id') final  int? stateId;
@override@JsonKey(name: 'rating_avg') final  double? ratingAvg;
@override@JsonKey(name: 'rating_count') final  int ratingCount;
@override@JsonKey(name: 'hazard_avg') final  double? hazardAvg;
@override@JsonKey(name: 'hazard_count') final  int hazardCount;
@override@JsonKey(name: 'vote_count') final  int voteCount;
@override@JsonKey(name: 'cover_photo_url') final  String? coverPhotoUrl;
@override@JsonKey(name: 'cover_video_url') final  String? coverVideoUrl;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;
@override@JsonKey(name: 'updated_date') final  DateTime? updatedDate;
 final  List<int> _sportIds;
@override@JsonKey(name: 'sport_ids') List<int> get sportIds {
  if (_sportIds is EqualUnmodifiableListView) return _sportIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sportIds);
}


/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotCopyWith<_Spot> get copyWith => __$SpotCopyWithImpl<_Spot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Spot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.bestSeason, bestSeason) || other.bestSeason == bestSeason)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.openHour, openHour) || other.openHour == openHour)&&(identical(other.closeHour, closeHour) || other.closeHour == closeHour)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.ratingAvg, ratingAvg) || other.ratingAvg == ratingAvg)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.hazardAvg, hazardAvg) || other.hazardAvg == hazardAvg)&&(identical(other.hazardCount, hazardCount) || other.hazardCount == hazardCount)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.coverVideoUrl, coverVideoUrl) || other.coverVideoUrl == coverVideoUrl)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&const DeepCollectionEquality().equals(other._sportIds, _sportIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,latitude,longitude,difficulty,bestSeason,neighborhood,openHour,closeHour,createdBy,stateId,ratingAvg,ratingCount,hazardAvg,hazardCount,voteCount,coverPhotoUrl,coverVideoUrl,createdDate,updatedDate,const DeepCollectionEquality().hash(_sportIds)]);

@override
String toString() {
  return 'Spot(id: $id, name: $name, description: $description, latitude: $latitude, longitude: $longitude, difficulty: $difficulty, bestSeason: $bestSeason, neighborhood: $neighborhood, openHour: $openHour, closeHour: $closeHour, createdBy: $createdBy, stateId: $stateId, ratingAvg: $ratingAvg, ratingCount: $ratingCount, hazardAvg: $hazardAvg, hazardCount: $hazardCount, voteCount: $voteCount, coverPhotoUrl: $coverPhotoUrl, coverVideoUrl: $coverVideoUrl, createdDate: $createdDate, updatedDate: $updatedDate, sportIds: $sportIds)';
}


}

/// @nodoc
abstract mixin class _$SpotCopyWith<$Res> implements $SpotCopyWith<$Res> {
  factory _$SpotCopyWith(_Spot value, $Res Function(_Spot) _then) = __$SpotCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String description, double latitude, double longitude, int? difficulty,@JsonKey(name: 'best_season') String? bestSeason, String? neighborhood,@JsonKey(name: 'open_hour') String? openHour,@JsonKey(name: 'close_hour') String? closeHour,@JsonKey(name: 'created_by') int createdBy,@JsonKey(name: 'state_id') int? stateId,@JsonKey(name: 'rating_avg') double? ratingAvg,@JsonKey(name: 'rating_count') int ratingCount,@JsonKey(name: 'hazard_avg') double? hazardAvg,@JsonKey(name: 'hazard_count') int hazardCount,@JsonKey(name: 'vote_count') int voteCount,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'cover_video_url') String? coverVideoUrl,@JsonKey(name: 'created_date') DateTime createdDate,@JsonKey(name: 'updated_date') DateTime? updatedDate,@JsonKey(name: 'sport_ids') List<int> sportIds
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? latitude = null,Object? longitude = null,Object? difficulty = freezed,Object? bestSeason = freezed,Object? neighborhood = freezed,Object? openHour = freezed,Object? closeHour = freezed,Object? createdBy = null,Object? stateId = freezed,Object? ratingAvg = freezed,Object? ratingCount = null,Object? hazardAvg = freezed,Object? hazardCount = null,Object? voteCount = null,Object? coverPhotoUrl = freezed,Object? coverVideoUrl = freezed,Object? createdDate = null,Object? updatedDate = freezed,Object? sportIds = null,}) {
  return _then(_Spot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int?,bestSeason: freezed == bestSeason ? _self.bestSeason : bestSeason // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String?,openHour: freezed == openHour ? _self.openHour : openHour // ignore: cast_nullable_to_non_nullable
as String?,closeHour: freezed == closeHour ? _self.closeHour : closeHour // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,ratingAvg: freezed == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,hazardAvg: freezed == hazardAvg ? _self.hazardAvg : hazardAvg // ignore: cast_nullable_to_non_nullable
as double?,hazardCount: null == hazardCount ? _self.hazardCount : hazardCount // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverVideoUrl: freezed == coverVideoUrl ? _self.coverVideoUrl : coverVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,updatedDate: freezed == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sportIds: null == sportIds ? _self._sportIds : sportIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
