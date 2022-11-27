package bbs;
public class Bbs {
   private int bbsID;
   private String bbsTitle;
   private String id;
   private String bbsDate;
   private String bbsContent;
   private int bbsView;
   
   public int getBbsID() {
      return bbsID;
   }
   public void setBbsID(int bbsID) {
      this.bbsID = bbsID;
   }
   public String getBbsTitle() {
      return bbsTitle;
   }
   public void setBbsTitle(String bbsTitle) {
      this.bbsTitle = bbsTitle;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getBbsDate() {
      return bbsDate;
   }
   public void setBbsDate(String bbsDate) {
      this.bbsDate = bbsDate;
   }
   public String getBbsContent() {
      return bbsContent;
   }
   public void setBbsContent(String bbsContent) {
      this.bbsContent = bbsContent;
   }
   public int getBbsView() {
	   return bbsView;
   }
   public void setBbsView(int bbsView) {
	   this.bbsView = bbsView;
   }
}