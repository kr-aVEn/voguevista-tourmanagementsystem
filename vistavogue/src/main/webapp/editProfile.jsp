<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="vistavogue.beans.User" %>
<%@ page import="vistavogue.dao.UserDAO" %>
<%

    User user1 = (User) session.getAttribute("user");

    if (user1 == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String place = request.getParameter("place");
    String password = request.getParameter("pass");

    if (username != null && email != null && place != null && password != null) {
        User user2 = new User();
        user2.setUsername(username);
        user2.setEmail(email);
        user2.setPlace(place);
        user2.setPassword(password);
        user2.setRole(user1.getRole()); 
        UserDAO userDao = new UserDAO();
        boolean updateSuccess = userDao.updateUser(user1, user2);

        if (updateSuccess) {
            session.setAttribute("user", user2);
            response.sendRedirect("profile.jsp?message=Profile updated successfully");
        } else {
            response.sendRedirect("editProfile.jsp?error=Failed to update profile");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="styles.css">
    <style>
       
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 20%;
            background-color: #a52a2a;
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
            background-color: #8b4513;
            color: white;
            text-align: center;
            margin-bottom: 10px;
            text-decoration: none;
            border-radius: 5px;
        }
        .nav-item:hover {
            background-color: #6b3a0d;
        }
        .main-content {
            width: 80%;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }
        .header {
            background-color: #b0e0e6;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 2px solid #a52a2a;
        }
        .content {
            display: flex;
            flex-direction: column;
            padding: 20px;
        }
        .profile-edit {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: auto;
        }
        .profile-edit label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        .profile-edit input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .edit-button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .edit-button:hover {
            background-color: #218838;
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
                <a href="editProfile.jsp" class="nav-item">Edit Profile</a>
                <a href="dashboard.jsp" class="nav-item">Dashboard</a>
                <a href="logout.jsp" class="nav-item">Log Out</a>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Edit Profile</header>
            <div class="content">
                <form action="editProfile.jsp" method="post" class="profile-edit">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required>
                    
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                    
                    <label for="place">Place:</label>
                    <input type="text" id="place" name="place" value="<%= user.getPlace() %>" required>
                    
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="pass" value="<%= user.getPassword() %>" required>
                    
                    <button type="submit" class="edit-button">Update Profile</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
