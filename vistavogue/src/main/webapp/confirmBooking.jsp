<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="vistavogue.beans.BookingHistory" %>
<%@ page import="vistavogue.dao.BookingHistoryDAO" %>
<%@ page import="vistavogue.beans.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Booking</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <%
                User user = (User) session.getAttribute("user");
                if (user == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
            <div class="welcome">Welcome, <%= user.getUsername() %></div>
            <nav class="nav">
                <a href="profile.jsp" class="nav-item">Profile</a>
                <a href="packages.jsp" class="nav-item">Packages</a>
                <a href="locations.jsp" class="nav-item">Locations</a>
                <a href="ratings.jsp" class="nav-item">Ratings</a>
                <a href="bookings.jsp" class="nav-item">Bookings</a>
                <a href="dashboard.jsp" class="nav-item">Dashboard</a>
                <a href="Logout.jsp" class="nav-item">Log Out</a>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Confirm Booking</header>
            <div class="content">
                <%
                    String username = request.getParameter("username");
                    String packageName = request.getParameter("packageName");
                    int packageId = Integer.parseInt(request.getParameter("packageId"));
                    int numTravelers = Integer.parseInt(request.getParameter("numTravelers"));
                    Date travelDate = Date.valueOf(request.getParameter("travelDate"));

                    BookingHistory bookingHistory = new BookingHistory();
                    bookingHistory.setUsername(username);
                    bookingHistory.setPackageId(packageId);
                    bookingHistory.setNumTravelers(numTravelers);
                    bookingHistory.setTravelDate(travelDate);

                    Calendar calendar = Calendar.getInstance();
                    Date bookingDate = new Date(calendar.getTime().getTime());
                    bookingHistory.setBookingDate(bookingDate);

                    bookingHistory.setStatus("Pending");

                    BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
                    int bookingId = bookingHistoryDAO.insertBookingHistory(bookingHistory);

                    bookingHistory.setId(bookingId);
                %>
                <p>Booking request submitted. Redirecting to payment...</p>
                <%
                    session.setAttribute("bookingHistory", bookingHistory);
                    response.sendRedirect("Payment.jsp?packageId=" + bookingHistory.getPackageId() + "&bookingId=" + bookingId + "&packageName=" + packageName);
                %>
            </div>
        </main>
    </div>
</body>
</html>
