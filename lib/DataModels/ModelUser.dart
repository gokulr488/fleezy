class ModelUser {
  String uid;
  String roleName; //Avaiable roles Driver,Admin
  String fullName;
  String userEmailId;
  String phoneNumber;
  String password;
  ModelUser(
      {this.uid,
      this.roleName,
      this.fullName,
      this.userEmailId,
      this.phoneNumber,
      this.password});
}
