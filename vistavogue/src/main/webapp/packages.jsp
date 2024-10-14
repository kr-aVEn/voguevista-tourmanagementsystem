<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="vistavogue.dao.PackageDAO" %>
<%@ page import="vistavogue.beans.Package" %>
<%@ page import="vistavogue.beans.Location" %>
<%@ page import="vistavogue.DBConnection" %>
<%@ page import="vistavogue.beans.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    session.setAttribute("user", user);
%>
<%
    PackageDAO packageDAO = new PackageDAO();
    List<Package> packages = packageDAO.getAllPackages();
    Collections.shuffle(packages); // Randomize locations
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Packages</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f2f5;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 20%;
            background-color: #2c3e50;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            position: fixed;
            height: 100vh;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .welcome {
            margin-bottom: 20px;
            font-size: 22px;
            font-weight: bold;
            text-align: center;
        }
        .nav {
            width: 100%;
        }
        .nav-item {
            display: block;
            padding: 15px;
            background-color: #34495e;
            color: white;
            text-align: center;
            margin-bottom: 10px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .nav-item:hover {
            background-color: #1abc9c;
        }
        .main-content {
            width: 80%;
            margin-left: 20%;
            display: flex;
            flex-direction: column;
            padding: 40px;
            overflow-y: auto;
        }
        .header {
            background-color: #3498db;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .content {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .package-card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: calc(33.333% - 20px);
            padding: 20px;
            display: flex;
            flex-direction: column;
        }
        .package-card h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .package-card p {
            font-size: 16px;
            margin-bottom: 5px;
        }
        .package-card button {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            border-radius: 5px;
            border: none;
            background-color: #3498db;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .package-card button:hover {
            background-color: #2980b9;
        }
        .location-list {
            display: none;
            margin-top: 10px;
            padding: 10px;
            background-color: #ecf0f1;
            border-radius: 5px;
        }
        .location-list h4 {
            margin-bottom: 10px;
        }
        .location-list ul {
            list-style-type: none;
        }
        .location-list ul li {
            margin-bottom: 5px;
        }
        .rating {
            font-size: 18px;
            color: #f39c12;
            margin-top: 10px;
        }
   </style>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <div class="welcome">Welcome, <%= user.getUsername() %></div>
            <nav class="nav">
                <a href="profile.jsp" class="nav-item">Profile</a>
                <a href="locations.jsp" class="nav-item">Locations</a>
                <a href="dashboard.jsp" class="nav-item">Dashboard</a>
                <a href="custompackage.jsp" class="nav-item">Create Custom Package</a>
                <a href="Logout.jsp" class="nav-item">Log Out</a>
                <% if ("admin".equals(user.getRole())) { %>
                    <a href="addpackage.jsp" class="nav-item">Add Package</a>
                    <a href="managepackages.jsp" class="nav-item">Manage Packages</a>
                    <a href="viewcustompackagerequests.jsp" class="nav-item">View Custom Package Requests</a>
                   
                <% } %>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Available Packages</header>
            <div class="content">
                <%
                    for (Package pkg : packages) {
                %>
                <div class="package-card">
                    <h3><%= pkg.getName() %></h3>
                    <p>Duration: <%= pkg.getDuration() %> days</p>
                    <p>Cost: <%= pkg.getCost() %></p>
                    <p class="rating">Rating: ⭐⭐⭐⭐⭐</p>
                    <button onclick="window.location.href='mapack.jsp?packageId=<%= pkg.getId() %>'">More Details</button>
                    <button onclick="window.location.href='booked.jsp?packageId=<%= pkg.getId() %>'">Book Now</button>
                    <% if ("admin".equals(user.getRole())) { %>
                        <button onclick="window.location.href='editpackage.jsp?packageId=<%= pkg.getId() %>'">Edit</button>
                        <button onclick="deletePackage(<%= pkg.getId() %>)">Delete</button>
                    <% } %>
                </div>
                <%
                    }
                %>
            </div>
        </main>
    </div>
    <script>
        function deletePackage(packageId) {
            if (confirm('Are you sure you want to delete this package?')) {
                window.location.href = 'deletepackage.jsp?packageId=' + packageId;
            }
        }
    </script>
</body>
</html>