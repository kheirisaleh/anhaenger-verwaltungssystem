import '../models/customer.dart';

abstract interface class CustomerRepository {
  Stream<List<Customer>> watchAll({
    String? search,
    bool includeArchived = false,
  });

  Stream<Customer?> watchById(int id);

  Future<Customer> create(CustomerDraft draft);

  Future<void> update(int id, CustomerDraft draft);

  Future<void> archive(int id);
}
