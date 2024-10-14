<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vistavogue.dao.CustomizationRequestDAO" %>
<%@ page import="vistavogue.beans.CustomizationRequest" %>
<%@ page import="vistavogue.beans.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Custom Package Requests</title>
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
            <header class="header">Custom Package Requests</header>
            <div class="content">
                <%
                CustomizationRequestDAO customPackageRequestDAO = new CustomizationRequestDAO();
                    List<CustomizationRequest> CustomizationRequestcustomRequests = customPackageRequestDAO. getAllCustomizationRequests();
                %>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Package Details</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (CustomizationRequest req : CustomizationRequestcustomRequests) {
                        %>
                        <tr>
                            <td><%= req.getUserId() %></td>
                            <td><%= req.getRequestDetails() %></td>
                            <td><%= req.getStatus() %></td>
                            <td>
                                <a href="approvecustomrequest.jsp?requestId=<%= req.getId() %>">Approve</a>
                                <a href="rejectcustomrequest.jsp?requestId=<%= req.getId() %>">Reject</a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>