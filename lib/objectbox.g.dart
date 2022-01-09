// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'DataModels/ModelReport.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4900922487780503117),
      name: 'ModelReport',
      lastPropertyId: const IdUid(25, 5239119918162127178),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2905701778793394399),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 282744498516048172),
            name: 'reportId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1864303905578543555),
            name: 'income',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6338536966574793218),
            name: 'pendingBal',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5386921636093419609),
            name: 'driverSal',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7223996200506544325),
            name: 'expense',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4013968525874644811),
            name: 'totalTrips',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 5812166643093027897),
            name: 'pendingPayTrips',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 997343046413598606),
            name: 'cancelledTrips',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 1323977385902354683),
            name: 'kmsTravelled',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 1930449870278088160),
            name: 'fuelCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 494713303425537184),
            name: 'ltrs',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 5636760950943428573),
            name: 'serviceCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 3390348448983058002),
            name: 'repairCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 1209474401456609378),
            name: 'spareCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 2631213897051956900),
            name: 'noOfService',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 7572459961524256010),
            name: 'noOfFines',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 4460842517603561329),
            name: 'fineCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 1608335200272161857),
            name: 'taxInsuranceCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 3398470707601595400),
            name: 'otherCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 8853050515371830580),
            name: 'fastagCost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 4459552704691798398),
            name: 'regNo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(23, 4682363337431779364),
            name: 'month',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(24, 1644435721783597296),
            name: 'year',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(25, 5239119918162127178),
            name: 'companyId',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String directory,
        int maxDBSizeInKB,
        int fileMode,
        int maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 4900922487780503117),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ModelReport: EntityDefinition<ModelReport>(
        model: _entities[0],
        toOneRelations: (ModelReport object) => [],
        toManyRelations: (ModelReport object) => {},
        getId: (ModelReport object) => object.id,
        setId: (ModelReport object, int id) {
          object.id = id;
        },
        objectToFB: (ModelReport object, fb.Builder fbb) {
          final reportIdOffset =
              object.reportId == null ? null : fbb.writeString(object.reportId);
          final regNoOffset =
              object.regNo == null ? null : fbb.writeString(object.regNo);
          final monthOffset =
              object.month == null ? null : fbb.writeString(object.month);
          final companyIdOffset = object.companyId == null
              ? null
              : fbb.writeString(object.companyId);
          fbb.startTable(26);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, reportIdOffset);
          fbb.addFloat64(2, object.income);
          fbb.addFloat64(3, object.pendingBal);
          fbb.addFloat64(4, object.driverSal);
          fbb.addFloat64(5, object.expense);
          fbb.addInt64(6, object.totalTrips);
          fbb.addInt64(7, object.pendingPayTrips);
          fbb.addInt64(8, object.cancelledTrips);
          fbb.addFloat64(9, object.kmsTravelled);
          fbb.addFloat64(10, object.fuelCost);
          fbb.addFloat64(11, object.ltrs);
          fbb.addFloat64(12, object.serviceCost);
          fbb.addFloat64(13, object.repairCost);
          fbb.addFloat64(14, object.spareCost);
          fbb.addInt64(15, object.noOfService);
          fbb.addInt64(16, object.noOfFines);
          fbb.addFloat64(17, object.fineCost);
          fbb.addFloat64(18, object.taxInsuranceCost);
          fbb.addFloat64(19, object.otherCost);
          fbb.addFloat64(20, object.fastagCost);
          fbb.addOffset(21, regNoOffset);
          fbb.addOffset(22, monthOffset);
          fbb.addInt64(23, object.year);
          fbb.addOffset(24, companyIdOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ModelReport(
              reportId: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              companyId: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 52),
              income: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              pendingBal: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              driverSal: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              expense: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              totalTrips: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              pendingPayTrips: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              cancelledTrips: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              kmsTravelled: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 22),
              fuelCost:
                  const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 24),
              ltrs: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 26),
              serviceCost: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 28),
              repairCost: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 30),
              spareCost: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 32),
              noOfService: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 34),
              noOfFines: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 36),
              fineCost: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 38),
              taxInsuranceCost: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 40),
              otherCost: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 42),
              fastagCost: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 44),
              month: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 48),
              regNo: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 46),
              year: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 50),
              id: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ModelReport] entity fields to define ObjectBox queries.
class ModelReport_ {
  /// see [ModelReport.id]
  static final id =
      QueryIntegerProperty<ModelReport>(_entities[0].properties[0]);

  /// see [ModelReport.reportId]
  static final reportId =
      QueryStringProperty<ModelReport>(_entities[0].properties[1]);

  /// see [ModelReport.income]
  static final income =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[2]);

  /// see [ModelReport.pendingBal]
  static final pendingBal =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[3]);

  /// see [ModelReport.driverSal]
  static final driverSal =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[4]);

  /// see [ModelReport.expense]
  static final expense =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[5]);

  /// see [ModelReport.totalTrips]
  static final totalTrips =
      QueryIntegerProperty<ModelReport>(_entities[0].properties[6]);

  /// see [ModelReport.pendingPayTrips]
  static final pendingPayTrips =
      QueryIntegerProperty<ModelReport>(_entities[0].properties[7]);

  /// see [ModelReport.cancelledTrips]
  static final cancelledTrips =
      QueryIntegerProperty<ModelReport>(_entities[0].properties[8]);

  /// see [ModelReport.kmsTravelled]
  static final kmsTravelled =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[9]);

  /// see [ModelReport.fuelCost]
  static final fuelCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[10]);

  /// see [ModelReport.ltrs]
  static final ltrs =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[11]);

  /// see [ModelReport.serviceCost]
  static final serviceCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[12]);

  /// see [ModelReport.repairCost]
  static final repairCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[13]);

  /// see [ModelReport.spareCost]
  static final spareCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[14]);

  /// see [ModelReport.noOfService]
  static final noOfService =
      QueryIntegerProperty<ModelReport>(_entities[0].properties[15]);

  /// see [ModelReport.noOfFines]
  static final noOfFines =
      QueryIntegerProperty<ModelReport>(_entities[0].properties[16]);

  /// see [ModelReport.fineCost]
  static final fineCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[17]);

  /// see [ModelReport.taxInsuranceCost]
  static final taxInsuranceCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[18]);

  /// see [ModelReport.otherCost]
  static final otherCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[19]);

  /// see [ModelReport.fastagCost]
  static final fastagCost =
      QueryDoubleProperty<ModelReport>(_entities[0].properties[20]);

  /// see [ModelReport.regNo]
  static final regNo =
      QueryStringProperty<ModelReport>(_entities[0].properties[21]);

  /// see [ModelReport.month]
  static final month =
      QueryStringProperty<ModelReport>(_entities[0].properties[22]);

  /// see [ModelReport.year]
  static final year =
      QueryIntegerProperty<ModelReport>(_entities[0].properties[23]);

  /// see [ModelReport.companyId]
  static final companyId =
      QueryStringProperty<ModelReport>(_entities[0].properties[24]);
}
