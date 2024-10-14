<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="vistavogue.beans.User" %>
<%@ page import="vistavogue.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
      User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String place = request.getParameter("place");
    String role = request.getParameter("role");

    user.setUsername(username);
    user.setEmail(email);
    user.setPlace(place);
    user.setRole(role);

    UserDAO userDao = new UserDAO();
    boolean updateSuccess = userDao.updateUser(user,user);

    if (updateSuccess) {
        session.setAttribute("user", user);
        response.sendRedirect("profile.jsp?message=Profile updated successfully");
    } else {
        response.sendRedirect("editProfile.jsp?error=Failed to update profile");
    }
%>
