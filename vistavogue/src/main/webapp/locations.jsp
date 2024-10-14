<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="vistavogue.beans.User" %>
<%@ page import="vistavogue.beans.Location" %>
<%@ page import="vistavogue.beans.Activity" %>
<%@ page import="vistavogue.dao.LocationDAO" %>
<%@ page import="vistavogue.dao.ActivityDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Locations</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
       * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Roboto', sans-serif;
        }
        .container {
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .sidebar {
            width: 20%;
            background-color: #a52a2a; /* brown color */
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            position: fixed;
            height: 100%;
            overflow: hidden;
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
            margin-left: 20%;
            width: 80%;
            display: flex;
            flex-direction: column;
            padding: 20px;
            overflow-y: auto;
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
            display: flex;
            flex-wrap: wrap;
            padding: 20px;
            gap: 20px;
        }
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            flex: 1 1 calc(33% - 20px);
            display: flex;
            flex-direction: column;
            height: 300px;
        }
        .card h3 {
            margin-bottom: 10px;
            font-size: 22px;
            color: #a52a2a;
        }
        .card p {
            margin-bottom: 38px;
            font-size: 16px;
        }
        .card .dropdown {
            margin-top: 10px;
        }
        .card .dropdown button {
            background-color: #a52a2a;
            color: white;
            padding: 8px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 14px;
        }
        .card .dropdown button:hover {
            background-color: #8b4513;
        }
        .card .dropdown-content {
            display: none;
            flex-direction: column;
            margin-top: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 4px;
            max-height: 100px;
            overflow-y: auto;
        }
        .card .dropdown-content p {
            margin: 5px 0;
            font-size: 14px;
            list-style: disc;
            margin-left: 20px;
        }
        .card .show-maps {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 14px;
        }
        .card .show-maps:hover {
            background-color: #0056b3;
        }
    </style>
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
                <a href="locations.jsp" class="nav-item">Locations</a>
                  <a href="addlocation.html" class="nav-item">Add new location</a>
                    <a href="custompackage.jsp" class="nav-item">Create Custom Package</a>
                <a href="dashboard.jsp" class="nav-item">Dashboard</a>
              
                <a href="Logout.jsp" class="nav-item">Log Out</a>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Locations 	</header>
            <div class="content">
                <%
                    LocationDAO locationDao = new LocationDAO();
                    ActivityDAO activityDao = new ActivityDAO();
                    List<Location> locations = locationDao.getAllLocations();
                    for (Location location : locations) {
                        int locid= location.getId();
                        List<Activity> activities = activityDao.getAllActivities(locid);
                %>
                <div class="card">
                    <h3><%= location.getName() %></h3>
                    <p><%=location.getDescription() %></p>
                    <div class="dropdown">
                        <button onclick="toggleDropdown(this)">Show Activities</button>
                        <div class="dropdown-content">
                            <%
                                for (Activity activity : activities) {
                            %>
                            <p><%= activity.getActivityname() %>  : <%= activity.getDescription()  %> </p>
                            <%} %>
                        </div>
                    </div>
                    <button class="show-maps" onclick="showMap('<%= location.getName() %>','<%=  location.getLatitude() %>', '<%= location.getLongitude() %>',)"> Show in Maps</button>
                </div>
                <%
                    }
                %>
            </div>
        </main>
    </div>
    <script>
        function toggleDropdown(button) {
            var dropdownContents = document.querySelectorAll('.dropdown-content');
            dropdownContents.forEach(function(content) {
                content.style.display = 'none';
            });
            var dropdownContent = button.nextElementSibling;
            dropdownContent.style.display = 'flex';
        }

        function showMap(name,latitude, longitude) {
        	 var data = {
        				name:name,
        		        latitude: latitude,
        		        longitude: longitude
        		    };
        		    sessionStorage.setItem('mapData', JSON.stringify(data));
            window.location.href = `map.jsp`;
        }
    </script>
</body>
</html>
