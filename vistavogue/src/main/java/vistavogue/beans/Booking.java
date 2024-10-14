package vistavogue.beans;

public class Booking {
    private int id;
    private String username;
    private int packageId;
    private java.sql.Date bookingDate;
    private java.sql.Date travelDate;
    private int numTravelers;
    private String status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getPackageId() {
		return packageId;
	}
	public void setPackageId(int packageId) {
		this.packageId = packageId;
	}
	public java.sql.Date getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(java.sql.Date bookingDate) {
		this.bookingDate = bookingDate;
	}
	public java.sql.Date getTravelDate() {
		return travelDate;
	}
	public void setTravelDate(java.sql.Date travelDate) {
		this.travelDate = travelDate;
	}
	public int getNumTravelers() {
		return numTravelers;
	}
	public void setNumTravelers(int numTravelers) {
		this.numTravelers = numTravelers;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

   
}
