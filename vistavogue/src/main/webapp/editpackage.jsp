<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.dao.PackageDAO" %>
<%@ page import="vistavogue.beans.Package" %>
<%@ page import="vistavogue.beans.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Package</title>
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
            <header class="header">Edit Package</header>
            <div class="content">
                <%
                    int packageId = Integer.parseInt(request.getParameter("packageId"));
                    PackageDAO packageDAO = new PackageDAO();
                    Package pkg = packageDAO.getPackage(packageId);
                %>
                <form action="editpackageaction.jsp" method="post">
                    <input type="hidden" name="id" value="<%= pkg.getId() %>">
                    <label for="name">Package Name:</label>
                    <input type="text" id="name" name="name" value="<%= pkg.getName() %>" required>
                    <br>
                    <label for="duration">Duration (days):</label>
                    <input type="number" id="duration" name="duration" value="<%= pkg.getDuration() %>" required>
                    <br>
                    <label for="cost">Cost:</label>
                    <input type="number" id="cost" name="cost" value="<%= pkg.getCost() %>" required>
                    <br>
                    <button type="submit">Update Package</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>