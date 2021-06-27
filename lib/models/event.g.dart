// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 2;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      id: fields[0] as int,
      name: fields[1] as String,
      countryId: fields[2] as int,
      imageUrl: fields[3] as String,
      dateHappening: fields[4] as String,
      subheader: fields[5] as String,
      location: fields[6] as String,
      endDate: fields[7] as String,
      eventType: fields[8] as String,
      hostId: fields[9] as int,
      hostName: fields[10] as String,
      eventDesc: fields[11] as String,
      hostContact: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.countryId)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.dateHappening)
      ..writeByte(5)
      ..write(obj.subheader)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.endDate)
      ..writeByte(8)
      ..write(obj.eventType)
      ..writeByte(9)
      ..write(obj.hostId)
      ..writeByte(10)
      ..write(obj.hostName)
      ..writeByte(11)
      ..write(obj.eventDesc)
      ..writeByte(12)
      ..write(obj.hostContact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
