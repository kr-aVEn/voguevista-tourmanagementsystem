package vistavogue.beans;

public class Review {
	
	    private int id;
	    private int userId;
	    private int packageId;
	    private String review;
	    private int rating;
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public Review(int id, int userId, int packageId, String review, int rating) {
			super();
			this.id = id;
			this.userId = userId;
			this.packageId = packageId;
			this.review = review;
			this.rating = rating;
		}
		public int getUserId() {
			return userId;
		}
		public void setUserId(int userId) {
			this.userId = userId;
		}
		public int getPackageId() {
			return packageId;
		}
		public void setPackageId(int packageId) {
			this.packageId = packageId;
		}
		public String getReview() {
			return review;
		}
		public void setReview(String review) {	
			this.review = review;
		}
		public Review() {
			super();
		}
		public int getRating() {
			return rating;
		}
		public void setRating(int rating) {
			this.rating = rating;
		}

	 

}
