<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="vistavogue.beans.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
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

        .profile-container {
            padding: 20px;
        }

        .profile-info, .profile-edit {
            margin-bottom: 20px;
        }

        .profile-info p, .profile-edit label {
            margin: 10px 0;
        }

        .profile-edit input {
            padding: 5px;
            width: 100%;
            margin-bottom: 10px;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
        }

        .buttons button {
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .delete-button {
            background-color: red;
            color: white;
        }

        .edit-button {
            background-color: green;
            color: white;
        }

        .nav-item {
            background-color: #6b3a0d; /* even darker brown color */
            padding: 15px;
            color: white;
            text-align: center;
            margin-bottom: 10px;
            text-decoration: none;
            border-radius: 5px;
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
                else{
                	session.setAttribute("user", user);
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
            <header class="header">Profile</header>
            <div class="content">
                <div class="profile-container">
                    <div class="profile-info">
                        <h2>User Information</h2>
                        <p>Username: <%= user.getUsername() %></p>
                        <p>Email: <%= user.getEmail() %></p>
                        <p>Place: <%= user.getPlace() %></p>
                        <p>Role: <%= user.getRole() %></p>
                    </div>
                    <div class="buttons">
                        <button class="edit-button" onclick="location.href='editProfile.jsp'">Edit Profile</button>
                        <button class="delete-button" onclick="confirmDelete()">Delete Profile</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script>
        function confirmDelete() {
            if (confirm('Are you sure you want to delete your profile? This action cannot be undone.')) {
                window.location.href = 'deleteUser.jsp';
            }
        }
    </script>
</body>
</html>
