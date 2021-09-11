class CovidProvince {
  String? txnDate;
  String? province;
  int? newCase;
  int? totalCase;
  int? newCaseExcludeabroad;
  int? totalCaseExcludeabroad;
  int? newDeath;
  int? totalDeath;
  String? updateDate;

  CovidProvince(
      {this.txnDate,
      this.province,
      this.newCase,
      this.totalCase,
      this.newCaseExcludeabroad,
      this.totalCaseExcludeabroad,
      this.newDeath,
      this.totalDeath,
      this.updateDate});

  CovidProvince.fromJson(Map<String, dynamic> json) {
    txnDate = json['txn_date'];
    province = json['province'];
    newCase = json['new_case'];
    totalCase = json['total_case'];
    newCaseExcludeabroad = json['new_case_excludeabroad'];
    totalCaseExcludeabroad = json['total_case_excludeabroad'];
    newDeath = json['new_death'];
    totalDeath = json['total_death'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn_date'] = this.txnDate;
    data['province'] = this.province;
    data['new_case'] = this.newCase;
    data['total_case'] = this.totalCase;
    data['new_case_excludeabroad'] = this.newCaseExcludeabroad;
    data['total_case_excludeabroad'] = this.totalCaseExcludeabroad;
    data['new_death'] = this.newDeath;
    data['total_death'] = this.totalDeath;
    data['update_date'] = this.updateDate;
    return data;
  }
}
