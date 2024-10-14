<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="vistavogue.beans.User" %>
<%@ page import="vistavogue.beans.Location" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Locations</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" >
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
       
      
        #map { height: 800px; }
    </style>
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
   
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
                <a href="dashboard.jsp" class="nav-item">Dashboard</a>
                <a href="customPackage.jsp" class="nav-item">Create Custom Package</a>
                <a href="logout.jsp" class="nav-item">Log Out</a>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Locations</header>
            <h2> Map of <span id=name></span></h2>
    <div id="map"></div>
    <script>
  
    var mapData = sessionStorage.getItem('mapData');
    if (mapData) {
        var data = JSON.parse(mapData);
        console.log("Latitude:", data.latitude);
        console.log("Longitude:", data.longitude);
        console.log("Name:", data.name);
        document.getElementById('name').innerHTML=data.name;
    } else {
        console.error("No data found in sessionStorage.");
    }
        // Initialize map centered on the provided latitude and longitude
        var map = L.map('map').setView([data.latitude, data.longitude], 12);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Add marker for the provided location
        L.marker([data.latitude, data.longitude]).addTo(map).bindPopup(data.name);
    </script>
    </main>
    </div>
</body>
            </html>
            