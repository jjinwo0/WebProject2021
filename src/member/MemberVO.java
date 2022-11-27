package member;

public class MemberVO {
   private String id;
   private String pwd;
   private String username;
   private String age;
   private String place;
   private String email;
   private String nickname;
   private String introduce;
   private String dogname;
   private String dogdate;
   private String dogbreed;
   private String tel;
   private String instagram;
   private int manager;
   
   
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id=id;
   }
   public String getPwd() {
      return pwd;
   }
   public void setPwd(String pwd) {
      this.pwd=pwd;
   }
   public String getUsername() {
      return username;
   }
   public void setUsername(String username) {
      this.username=username;
   }
   public String getAge() {
      return age;
   }
   public void setAge(String age) {
      this.age=age;
   }
   public String getPlace() {
      return place;
   }
   public void setPlace(String place) {
      this.place=place;
   }
   public String getEmail() {
      return email;
   }
   public void setEmail(String email) {
      this.email=email;
   }
   public String getNickname() {
      return nickname;
   }
   public void setNickname(String nickname) {
      this.nickname = nickname;
   }
   public String getIntroduce() {
      return introduce;
   }
   public void setIntroduce(String introduce) {
      this.introduce = introduce;
   }
   public String getDogname() {
      return dogname;
   }
   public void setDogname(String dogname) {
      this.dogname = dogname;
   }
   public String getDogdate() {
      return dogdate;
   }
   public void setDogdate(String dogdate) {
      this.dogdate = dogdate;
   }
   public String getDogbreed() {
      return dogbreed;
   }
   public void setDogbreed(String dogbreed) {
      this.dogbreed = dogbreed;
   }
   
   public String getTel() {
      return tel;
   }
   public void setTel(String tel) {
      this.tel = tel;
   }
   
   public String getInstagram() {
      return instagram;
   }
   public void setInstagram(String instagram) {
      this.instagram = instagram;
   }
   public int getManager() {
	   return manager;
   }
   public void setManager(int manager) {
	   this.manager=manager;
   }
}