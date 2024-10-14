package vistavogue.beans;

public class CustomizationRequest {
	   private int id;
	    private String userId;
	    private int packageId;
	    private String requestDetails;
	    private String status;
		public CustomizationRequest(int id, String userId, int packageId, String requestDetails, String status) {
			super();
			this.id = id;
			this.userId = userId;
			this.packageId = packageId;
			this.requestDetails = requestDetails;
			this.status = status;
		}
		public CustomizationRequest() {
			super();
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getUserId() {
			return userId;
		}
		public void setUserId(String userId) {
			this.userId = userId;
		}
		public int getPackageId() {
			return packageId;
		}
		public void setPackageId(int packageId) {
			this.packageId = packageId;
		}
		public String getRequestDetails() {
			return requestDetails;
		}
		public void setRequestDetails(String requestDetails) {
			this.requestDetails = requestDetails;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
}
