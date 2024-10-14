<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="vistavogue.beans.BookingHistory" %>
<%@ page import="vistavogue.dao.BookingHistoryDAO" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <main class="main-content">
            <header class="header">Payment</header>
            <div class="content">
                <%
                    int packageId = Integer.parseInt(request.getParameter("packageId"));
                    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                    String packageName = request.getParameter("packageName");

                    Random random = new Random();
                    int randomNum = random.nextInt(11);

                    boolean paymentSuccess = (randomNum % 5 != 0) && (randomNum > 0);

                    BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
                    BookingHistory bookingHistory = bookingHistoryDAO.getBookingHistoryById(bookingId);

                    if (paymentSuccess) {
                        bookingHistory.setStatus("Confirmed");
                        bookingHistoryDAO.updateBookingHistory(bookingHistory);
                        %>
                        <p>Payment successful for package: <%= packageName %></p>
                        <p>Booking ID: <%= bookingId %></p>
                        <p>Number of Travelers: <%= bookingHistory.getNumTravelers() %></p>
                        <p>Travel Date: <%= bookingHistory.getTravelDate() %></p>
                        <p>Status: Confirmed</p>
                        <%
                    } else {
                        bookingHistory.setStatus("Payment Failed");
                        bookingHistoryDAO.updateBookingHistory(bookingHistory);
                        %>
                        <p>Payment failed for package: <%= packageName %></p>
                        <p>Booking ID: <%= bookingId %></p>
                        <p>Number of Travelers: <%= bookingHistory.getNumTravelers() %></p>
                        <p>Travel Date: <%= bookingHistory.getTravelDate() %></p>
                        <p>Status: Payment Failed</p>
                        <%
                    }
                %>
                <a href="dashboard.jsp">Back to dashboard</a>
            </div>
        </main>
    </div>
</body>
</html>
