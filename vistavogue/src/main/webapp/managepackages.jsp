<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vistavogue.dao.PackageDAO" %>
<%@ page import="vistavogue.beans.Package" %>
<%@ page import="vistavogue.beans.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Packages</title>
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
            <header class="header">Manage Packages</header>
            <div class="content">
                <%
                    PackageDAO packageDAO = new PackageDAO();
                    List<Package> packages = packageDAO.getAllPackages();
                %>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Duration (days)</th>
                            <th>Cost</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Package pkg : packages) {
                        %>
                        <tr>
                            <td><%= pkg.getName() %></td>
                            <td><%= pkg.getDuration() %></td>
                            <td><%= pkg.getCost() %></td>
                            <td>
                                <a href="editpackage.jsp?packageId=<%= pkg.getId() %>">Edit</a>
                                <a href="deletepackage.jsp?packageId=<%= pkg.getId() %>" onclick="return confirm('Are you sure you want to delete this package?')">Delete</a>
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