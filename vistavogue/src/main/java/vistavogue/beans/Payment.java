package vistavogue.beans;

public class Payment {
    private int id;
    private int bookingId;
    private java.sql.Date paymentDate;
    private double amount;
    private String status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public java.sql.Date getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(java.sql.Date paymentDate) {
		this.paymentDate = paymentDate;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

   
}
