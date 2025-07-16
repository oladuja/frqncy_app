import 'package:flutter/material.dart';
import 'package:adapty_flutter/adapty_flutter.dart';

class SubscriptionPlan {
  final String id;
  final String title;
  final String description;
  final String price;
  final String period;
  final AdaptyPaywallProduct product;
  final bool isPopular;

  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.period,
    required this.product,
    this.isPopular = false,
  });
}

class AdaptyPlansService {
  // Load all plans from a specific paywall
  Future<List<SubscriptionPlan>> loadPlansFromPaywall(
    String placementId,
  ) async {
    try {
      // Get the paywall
      final paywall = await Adapty().getPaywall(placementId: placementId);

      // Get products for this paywall
      final products = await Adapty().getPaywallProducts(paywall: paywall);

      // Convert products to subscription plans
      List<SubscriptionPlan> plans = [];

      for (final product in products) {
        final plan = SubscriptionPlan(
          id: product.vendorProductId,
          title: product.localizedTitle,
          description: product.localizedDescription,
          price: product.price.amount.toString(),
          period: _getPeriodString(product.subscription!.period),
          product: product,
          isPopular: _isPopularPlan(product.vendorProductId),
        );
        plans.add(plan);
      }

      // Sort plans by duration (weekly, monthly, yearly)
      plans.sort((a, b) => _sortByDuration(a.period, b.period));

      return plans;
    } catch (e) {
      print('Error loading plans: $e');
      return [];
    }
  }

  // Load plans from multiple paywalls
  Future<List<SubscriptionPlan>> loadAllPlans(List<String> placementIds) async {
    List<SubscriptionPlan> allPlans = [];

    for (final placementId in placementIds) {
      final plans = await loadPlansFromPaywall(placementId);
      allPlans.addAll(plans);
    }

    // Remove duplicates based on product ID
    final uniquePlans = <String, SubscriptionPlan>{};
    for (final plan in allPlans) {
      uniquePlans[plan.id] = plan;
    }

    return uniquePlans.values.toList();
  }

  // Helper method to convert subscription period to readable string
  String _getPeriodString(AdaptySubscriptionPeriod? period) {
    if (period == null) return 'One-time';

    switch (period.unit) {
      case AdaptyPeriodUnit.day:
        return period.numberOfUnits == 1
            ? 'Daily'
            : '${period.numberOfUnits} days';
      case AdaptyPeriodUnit.week:
        return period.numberOfUnits == 1
            ? 'Weekly'
            : '${period.numberOfUnits} weeks';
      case AdaptyPeriodUnit.month:
        return period.numberOfUnits == 1
            ? 'Monthly'
            : '${period.numberOfUnits} months';
      case AdaptyPeriodUnit.year:
        return period.numberOfUnits == 1
            ? 'Yearly'
            : '${period.numberOfUnits} years';
      default:
        return 'Unknown';
    }
  }

  // Helper method to determine if a plan is popular
  bool _isPopularPlan(String productId) {
    // You can customize this logic based on your product IDs
    return productId.toLowerCase().contains('yearly') ||
        productId.toLowerCase().contains('annual');
  }

  // Helper method to sort plans by duration
  int _sortByDuration(String periodA, String periodB) {
    final durationOrder = {'Daily': 1, 'Weekly': 2, 'Monthly': 3, 'Yearly': 4};

    return (durationOrder[periodA] ?? 999) - (durationOrder[periodB] ?? 999);
  }
}

// Widget to display subscription plans
class SubscriptionPlansScreen extends StatefulWidget {
  @override
  _SubscriptionPlansScreenState createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  final AdaptyPlansService _plansService = AdaptyPlansService();
  List<SubscriptionPlan> _plans = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Replace with your actual placement IDs
      final placementIds = ['monthly'];

      final plans = await _plansService.loadAllPlans(placementIds);

      setState(() {
        _plans = plans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Plans'),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _loadPlans)],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('Error loading plans: $_error'),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _loadPlans, child: Text('Retry')),
          ],
        ),
      );
    }

    if (_plans.isEmpty) {
      return Center(child: Text('No subscription plans available'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _plans.length,
      itemBuilder: (context, index) {
        final plan = _plans[index];
        return _buildPlanCard(plan);
      },
    );
  }

  Widget _buildPlanCard(SubscriptionPlan plan) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              plan.isPopular ? Border.all(color: Colors.blue, width: 2) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    plan.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (plan.isPopular)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'POPULAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              plan.description,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.price,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      plan.period,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _subscribeToPlan(plan),
                  child: Text('Subscribe'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _subscribeToPlan(SubscriptionPlan plan) async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Make the purchase
      final profile = await Adapty().makePurchase(product: plan.product);

      // Hide loading
      Navigator.pop(context);

      // Check if purchase was successful
      // if (profile) {
      //   _showSuccessDialog('Subscription successful!');
      // } else {
      //   _showErrorDialog('Purchase failed. Please try again.');
      // }
    } catch (e) {
      // Hide loading
      Navigator.pop(context);
      _showErrorDialog('Error: ${e.toString()}');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Success'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }
}
