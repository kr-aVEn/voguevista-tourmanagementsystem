<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="vistavogue.beans.User,vistavogue.dao.PackageDAO" %>
<%@ page import="vistavogue.beans.Package" %>
<%@ page import="vistavogue.beans.Location"%>
<%
int packageId = Integer.parseInt(request.getParameter("packageId"));
PackageDAO packageDAO = new PackageDAO();
Package pkg = packageDAO.getPackage(packageId);
List<Location> locations = packageDAO.getLocationsForPackage(packageId); 
%>
  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Package</title>
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

.nav-item
{
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
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            overflow-y: auto;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        form {
            width: 100%;
            max-width: 500px;
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        ul {
            list-style: none;
            margin-bottom: 20px;
        }
        ul li {
            background-color: #f4f4f9;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 5px;
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
                <a href="packages.jsp" class="nav-item">Packages</a>
                <a href="locations.jsp" class="nav-item">Locations</a>
                <a href="ratings.jsp" class="nav-item">Ratings</a>
                <a href="bookings.jsp" class="nav-item">Bookings</a>
                <a href="dashboard.jsp" class="nav-item">Dashboard</a>
                <a href="Logout.jsp" class="nav-item">Log Out</a>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Book Package</header>
            <div class="content">
                <h2>Book a Package</h2>
                <form action="confirmBooking.jsp" method="post">
                    <input type="hidden" name="username" value="<%= user.getUsername() %>">
                    <input type="hidden" name="packageId" value="<%= pkg.getId() %>">
                    <label for="packageId">Package Name:</label>
                     <ul id="locations">
                        
                            <li><strong><%= pkg.getName() %></strong></li>
                       
                    </ul>
                    <input type="text" id="packageName" name="packageName" value="<%= pkg.getName() %>" readonly>
                    <label for="locations">Places:</label>
                    <ul id="locations">
                        <% for (Location location : locations) { %>
                            <li><strong><%= location.getName() %></strong></li>
                        <% } %>
                    </ul>
                    <label for="numTravelers">Number of Travelers:</label>
                    <input type="number" id="numTravelers" name="numTravelers" required>
                    <label for="travelDate">Travel Date:</label>
                    <input type="date" id="travelDate" name="travelDate" required>
                    <input type="submit" value="Book Package">
                </form>
            </div>
        </main>
    </div>
</body>
</html>