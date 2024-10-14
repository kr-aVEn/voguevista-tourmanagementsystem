package vistavogue.beans;

public class BookingHistory {
    private int id;
    private String username;
    private int packageId;
    private java.util.Date bookingDate;
    private java.util.Date travelDate;
    private int numTravelers;
    private String status;

    public BookingHistory() {
        super();
    }

    public BookingHistory(int id, String username, int packageId, java.util.Date bookingDate, java.util.Date travelDate, int numTravelers, String status) {
        super();
        this.id = id;
        this.username = username;
        this.packageId = packageId;
        this.bookingDate = bookingDate;
        this.travelDate = travelDate;
        this.numTravelers = numTravelers;
        this.status = status;
    }

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

    public java.util.Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(java.util.Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public java.util.Date getTravelDate() {
        return travelDate;
    }

    public void setTravelDate(java.util.Date travelDate) {
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
