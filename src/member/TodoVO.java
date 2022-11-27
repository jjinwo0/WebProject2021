package member;

public class TodoVO {
   private int index;
   private String id;
   private String date;
   private String content;
   

   public int getIndex() {
	return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id=id;
   }
   public String getDate() {
	   return date;
   }
   public void setDate(String date) {
	   this.date = date;
   }
   public String getContent() {
	   return content;
   }
   public void setContent(String content) {
	   this.content = content;
   }
   
}