<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="vistavogue.beans.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tourism Dashboard</title>
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
flex-wrap: wrap;
padding: 20px;
gap: 20px;
}

.box {
flex: 1 1 calc(50% - 20px);
height: 200px;
display: flex;
align-items: center;
justify-content: center;
font-size: 18px;
font-weight: bold;
color: white;
}

.box1 {
background-color: #d3d3d3; /* light gray color */
color: black;
}

.box2 {
background-color: #ff4500; /* orange red color */
}

.box3 {
background-color: #ffe4c4; /* bisque color */
color: black;
}

.box4 {
background-color: #ff7f50; /* coral color */
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
            <header class="header">Tourism Dashboard</header>
            <div class="content">
                <!-- Main content goes here -->
                <%
                    // Get the content attribute and include the page
                    String contentPage = (String) request.getAttribute("content");
                    if (contentPage != null) {
                %>
                    <jsp:include page="<%= contentPage %>" />
                <%
                    } else {
                        out.println("No content to display.");
                    }
                %>
            </div>
        </main>
    </div>
</body>
</html>
