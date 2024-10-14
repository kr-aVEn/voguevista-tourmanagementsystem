<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, vistavogue.beans.*, vistavogue.dao.*" %>
<%
    // Get the user from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String[] locationIds = request.getParameterValues("locationIds");
        if (locationIds != null && locationIds.length > 0) {
            PackageRequest packageRequest = new PackageRequest();
            packageRequest.setUsername(user.getUsername());
            packageRequest.setLocationIds(String.join(",", locationIds));
            packageRequest.setStatus("Pending");

            PackageRequestDao packageRequestDao = new PackageRequestDao();
            packageRequestDao.createPackageRequest(packageRequest);

            response.sendRedirect("packages.jsp");
        } else {
            out.println("No locations selected. <a href='createPackage.jsp'>Go back</a>");
        }
    } else {
        // Display available locations
        LocationDAO locationDao = new LocationDAO();
        List<Location> locations = locationDao.getAllLocations();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Custom Package</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 20%;
            background-color: #a52a2a; /* brown color */
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        .welcome {
            margin-bottom: 20px;
            font-size: 20px;
            text-align: center;
        }
        .nav {
            width: 100%;
        }
        .nav-item {
            display: block;
            padding: 15px;
            background-color: #8b4513; /* darker brown color */
            color: white;
            text-align: center;
            margin-bottom: 10px;
            text-decoration: none;
            border-radius: 5px;
        }
        .nav-item:hover {
            background-color: #6b3a0d; /* even darker brown color */
        }
        .main-content {
            width: 80%;
            display: flex;
            flex-direction: column;
        }
        .header {
            background-color: #b0e0e6; /* light blue color */
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 2px solid #a52a2a;
        }
        .content {
            padding: 20px;
        }
        .form-container {
            width: 100%;
            padding: 20px;
        }
        .form-container h2 {
            margin-bottom: 20px;
        }
        .form-container table {
            width: 100%;
            border-collapse: collapse;
        }
        .form-container th, .form-container td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .form-container th {
            background-color: #f2f2f2;
        }
        .form-container button {
            padding: 10px 20px;
            background-color: #ff4500; /* orange red color */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #ff6347; /* tomato color */
        }
    </style>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
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
            <header class="header">Create Custom Package</header>
            <div class="content">
                <div class="form-container">
                    <form action="" method="post">
                        <h2>Select Locations</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Select</th>
                                    <th>Location Name</th>
                                    <th>Description</th>
                                   
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Location location : locations) { %>
                                    <tr>
                                        <td><input type="checkbox" name="locationIds" value="<%= location.getId() %>"></td>
                                        <td><%= location.getName() %></td>
                                        <td><%= location.getDescription() %></td>
                                      
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <button type="submit">Request Package</button>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
<%
    }
%>
