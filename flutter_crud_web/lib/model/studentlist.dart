class StudentListModel {

  Object? rollNo, name, percentage, branch;

  StudentListModel({
    this.rollNo,
    this.name,
    this.percentage,
    this.branch});

  factory StudentListModel.fromJson(Map<String, dynamic> json) {
    return StudentListModel(
        rollNo: json["rollNo"],
        name: json["name"],
        percentage: json["percentage"],
        branch: json["branch"]
    );
  }
}