
class ActivitySearchCriteria {
  String? type;
  int? numberOfParticipants;
  String? accessibilityMin;
  String? accessibilityMax;
  String? priceMax;
  String? priceMin;

  ActivitySearchCriteria(
      {this.type,
      this.numberOfParticipants,
      this.accessibilityMin,
      this.accessibilityMax,
      this.priceMax,
      this.priceMin});
}