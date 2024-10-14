<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.dao.CustomizationRequestDAO" %>
<%@ page import="vistavogue.beans.CustomizationRequest" %>
<%@ page import="vistavogue.beans.User" %>
 <%
                User user = (User) session.getAttribute("user");
                if (user == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                int packid=(int)session.getAttribute("packid");
            %>
<%

    String username = user.getUsername();
    int packageId = Integer.parseInt(request.getParameter("packageId"));
    String requestDetails = request.getParameter("requestDetails");
    String status = "pending";
    
    if (requestDetails != null && !requestDetails.isEmpty()) {
        CustomizationRequest req = new CustomizationRequest();
        req.setUserId(user.getUsername());
        req.setPackageId(packageId);
        req.setRequestDetails(requestDetails);
        req.setStatus(status);
        
        CustomizationRequestDAO dao = new CustomizationRequestDAO();
        dao.saveRequest(req);
        
        out.println("<p>Customization request submitted successfully!</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Customization</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">
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
            flex-direction: column;
            gap: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 18px;
        }
        .form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .buttons {
            display: flex;
            gap: 10px;
        }
        .buttons button {
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            background-color: #3498db;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .buttons button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <div class="welcome">Customize Package</div>
            <nav class="nav">
                <div class="nav-item"><strong>Package Customization</strong></div>
                <button class="nav-item" onclick="window.location.href='packages.jsp'">Back to Packages</button>
            </nav>
        </aside>
        <main class="main-content">
            <header class="header">Request Customization for Package ID: <%= packageId %></header>
            <div class="content">
                <form method="post" action="">
                    <div class="form-group">
                        <label for="requestDetails">Customization Request Details:</label>
                        <textarea id="requestDetails" name="requestDetails" rows="10" required></textarea>
                    </div>
                    <div class="buttons">
                        <button type="submit">Submit Request</button>
                        <button type="button" onclick="window.location.href='packages.jsp'">Cancel</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
