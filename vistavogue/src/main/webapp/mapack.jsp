<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vistavogue.dao.PackageDAO" %>
<%@ page import="vistavogue.dao.ActivityDAO" %>
<%@ page import="vistavogue.beans.Package" %>
<%@ page import="vistavogue.beans.Location" %>
<%@ page import="vistavogue.beans.Activity" %>
<%@ page import="vistavogue.DistanceUtil" %>
<%@ page import="vistavogue.beans.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    session.setAttribute("user", user);

    int packageId = Integer.parseInt(request.getParameter("packageId"));
    PackageDAO packageDAO = new PackageDAO();
    Package pkg = packageDAO.getPackage(packageId);
    session.setAttribute("packid", pkg.getId());
    List<Location> locations = packageDAO.getLocationsForPackage(packageId);
    double totalDistance = DistanceUtil.calculateTotalDistance(locations);
    Location startLocation = locations.get(0);
    ActivityDAO activityDao = new ActivityDAO();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Package Details</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        a.button {
            text-decoration: none;
        }
        * {
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
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .nav {
            width: 100%;
            margin-top: 20px;
        }
        .nav-item {
            display: block;
            padding: 15px;
            background-color: #34495e;
            color: white;
            text-align: center;
            width: 100%;
            margin-bottom: 10px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .nav-item:hover {
            background-color: #1abc9c;
            transform: scale(1.05);
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
            flex-direction: column;
            gap: 20px;
        }
        .location-list {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .location-list h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .location-list ul {
            list-style-type: none;
        }
        .location-list ul li {
            margin-bottom: 5px;
            font-size: 18px;
            padding: 10px;
            background-color: #ecf0f1;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .location-list ul li:hover {
            background-color: #bdc3c7;
        }
        .buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }
        .buttons button {
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            background-color: #3498db;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .buttons button:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }
        #back {
            background-color: #996A9E;
        }
        #map {
            margin-top: 14px;
            height: 600px;
            width: 100%;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        function showActivities(index) {
            var activitiesDiv = document.getElementById('activities-' + index);
            if (activitiesDiv.style.display === 'none') {
                activitiesDiv.style.display = 'block';
            } else {
                activitiesDiv.style.display = 'none';
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            var locations = [
                <% for (Location location : locations) { %>
                    {
                        name: "<%= location.getName() %>",
                        latitude: <%= location.getLatitude() %>,
                        longitude: <%= location.getLongitude() %>,
                        description: "<%= location.getDescription() %>",
                        distance: "<%= DistanceUtil.calculateDistanceFromStart(location, startLocation) %>"
                    }<%= locations.indexOf(location) != locations.size() - 1 ? "," : "" %>
                <% } %>
            ];
            showMap(locations);
        });

        function showMap(locations) {
            var map = L.map('map').setView([locations[0].latitude, locations[0].longitude], 10);

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

            for (var i = 0; i < locations.length; i++) {
                L.marker([locations[i].latitude, locations[i].longitude]).addTo(map)
                    .bindPopup(locations[i].name);
            }

            var latlngs = locations.map(function(location) {
                return [location.latitude, location.longitude];
            });

            var polyline = L.polyline(latlngs, {color: 'red'}).addTo(map);
            map.fitBounds(polyline.getBounds());
        }
    </script>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <div class="welcome">Package Details</div>
            <nav class="nav">
                <div class="nav-item"><strong>Package</strong></div>
                <div class="nav-item"><strong>Duration:</strong> <%= pkg.getDuration() %> days</div>
                <div class="nav-item"><strong>Cost:</strong> ₹<%= pkg.getCost() %></div>
                <div class="nav-item"><strong>Rating:</strong> ⭐</div>
                <div class="nav-item"><strong>Total Distance:</strong> <%= String.format("%.2f", totalDistance) %> km</div>
                <button class="nav-item" onclick="window.location.href='booking.jsp?packageId=<%= pkg.getId() %>'">Book Now</button>
                <button class="nav-item" onclick="window.location.href='addReview.jsp?packageId=<%= pkg.getId() %>'">Add Review</button>
                <button class="nav-item" onclick="window.location.href='ratePackage.jsp?packageId=<%= pkg.getId() %>'">Rate</button>
                <button class="nav-item" onclick="window.location.href='customise.jsp?packageId=<%= pkg.getId() %>'">Request Customization</button>
                <button class="nav-item" id="back" onclick="window.location.href='packages.jsp'">Back</button>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header"><%= pkg.getName() %></header>
            <div class="content">
                <div class="location-list">
                    <h3>Locations:</h3>
                    <ul>
                        <% for (Location location : locations) { %>
                            <li>
                                <strong><%= location.getName() %></strong>
                                <br>Description: <%= location.getDescription() %>
                                <br>
                                <button onclick="showActivities(<%= locations.indexOf(location) %>)">Show Activities</button>
                                <div id="activities-<%= locations.indexOf(location) %>" style="display: none;">
                                    <h4>Activities:</h4>
                                    <ul>
                                        <% 
                                        int locid = location.getId();
                                        List<Activity> activities = activityDao.getAllActivities(locid);
                                        for (Activity activity : activities) { %>
                                            <li><%= activity.getActivityname() %></li>
                                        <% } %>
                                    </ul>
                                </div>
                            </li>
                        <% } %>
                    </ul>
                </div>
                <div id="map"></div>
            </div>
        </main>
    </div>
</body>
</html>
