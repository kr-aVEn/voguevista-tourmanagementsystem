<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.beans.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
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
       
    </style>
</head>
  <div class="container">
        <aside class="sidebar">
            <%
                
                User user = (User) session.getAttribute("user");

                
                if (user == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
            
            
             <nav class="nav">
                <a href="profile.jsp" class="nav-item"></a>
                <a href="packages.jsp" class="nav-item"></a>
                <a href="locations.jsp" class="nav-item"></a>
              <div class="welcome">Good bye, <%= user.getUsername() %></div>
                <a href="ratings.jsp" class="nav-item"></a>
                <a href="bookings.jsp" class="nav-item"></a>
                
                <a href="login.jsp" class="nav-item">Click here to login again</a>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Vista Vogue</header>
            <div class="content">
            
               <h1>You have been logged out successfully.</h1>
    

            </div>
        </main>
    </div>

   

</html>
