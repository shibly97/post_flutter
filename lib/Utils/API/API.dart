import 'package:flutter_p/Utils/constants.dart';

const String branchAddEndpoint = '$baseUrl/api/users/add/branch';
const String createAdmin = '$baseUrl/api/users/add/admin';
const String updateUser = '$baseUrl/api/users/add/updateUser';
const String getAllAdmin = '$baseUrl/api/users/get/allAdmin';
const String getAllUsersByAdmin = '$baseUrl/api/users/get/getAllUsersByAdmin';
const String addBranch = '$baseUrl/api/users/add/branch';
const String login = '$baseUrl/api/auth/login';
const String allBranches = '$baseUrl/api/users/get/allBranches';
const String createEmployee = '$baseUrl/api/users/add/employee';

const String createCustomer = '$baseUrl/api/users/add/customer';
const String checkOTP = '$baseUrl/api/users/add/checkOTP';

const String createJob = '$baseUrl/api/job/create';
const String getJobById = '$baseUrl/api/job/get/details';
const String getPendingJobById = '$baseUrl/api/job/get/pendingJobDetails';
const String getJobsByOfficer = '$baseUrl/api/job/get/detailsByOfficer';
const String getRateJobsByOfficer = '$baseUrl/api/job/get/rateDetailsByOfficer';
const String  getJobsByCustomer = '$baseUrl/api/job/get/detailsByCustomer';
const String  getJobsByAdmin = '$baseUrl/api/job/get/detailsByAdmin';
const String  getJobsByRating = '$baseUrl/api/job/get/detailsByRating';
const String  getPendingJobsByAdmin = '$baseUrl/api/job/get/pendingDetailsByAdmin';
const String updateJobStatus = '$baseUrl/api/job/update/status';
const String updateJobRating = '$baseUrl/api/job/update/jobRating';
const String approveJob = '$baseUrl/api/job/update/pending';
const String updateJob = '$baseUrl/api/job/update/';

const String getSequenceByCustomerId = '$baseUrl/api/job/get/sequence';

const String getPostmansByBranch = '$baseUrl/api/employee/get/postman/byBranch';

const String  getComplaintByCustomer = '$baseUrl/api/job/get/complaintByCustomer';
const String  getComplaintByAdmin = '$baseUrl/api/job/get/complaintByAdmin';
const String createComplaint   = '$baseUrl/api/job/create/createCOmplaint';
const String updateComplaint   = '$baseUrl/api/job/update/complaint';
const String getComplaintById = '$baseUrl/api/job/get/complaintDetails';
// const String createJob = '$baseUrl/api/job/details';