

class JobModel{
  late String title;
  late String description;
  late String location;
  late int noOfWorkers;
  late int wagePerHour;
  late DateTime fromDate;
  late DateTime toDate;
  late String workerType;
  late String jobId;
  late int appliedWorkersCount;

  JobModel({required String title, required String description, required String location, required int noOfWorkers, required int wagePerHour, required DateTime fromDate,
  required DateTime toDate, required String workerType, required this.jobId, required appliedWorkersCount}){
    this.title = title;
    this.description = description;
    this.location = location;
    this.noOfWorkers = noOfWorkers;
    this.wagePerHour = wagePerHour;
    this.fromDate = fromDate;
    this.toDate = toDate;
    this.workerType = workerType;
    this.jobId = jobId;
    this.appliedWorkersCount = appliedWorkersCount;
  }
}
