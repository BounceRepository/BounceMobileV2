import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class FeedListServiceImpl implements IFeedListService {
  final IApi _api;

  FeedListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Feed>> getAllMyFeed() async {
    var url = FeedApiURLS.getAllFeed + '?groupId=1';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Feed>> getAllFamilyFeed() async {
    var url = FeedApiURLS.getAllFeed + '?groupId=4';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Feed>> getAllParentingFeed() async {
    var url = FeedApiURLS.getAllFeed + '?groupId=7';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Feed>> getAllRelationshipFeed() async {
    var url = FeedApiURLS.getAllFeed + '?groupId=1';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Feed>> getAllSelfCareFeed() async {
    var url = FeedApiURLS.getAllFeed + '?groupId=2';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Feed>> getAllSexualityFeed() async {
    var url = FeedApiURLS.getAllFeed + '?groupId=6';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Feed>> getAllWorkEthnicsFeed() async {
    var url = FeedApiURLS.getAllFeed + '?groupId=3';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
