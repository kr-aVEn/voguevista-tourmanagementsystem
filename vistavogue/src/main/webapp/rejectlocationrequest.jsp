// approvelocationrequest.jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.dao.CustomizationRequestDAO" %>
<%
    int requestId = Integer.parseInt(request.getParameter("requestId"));
CustomizationRequestDAO locationRequestDAO = new CustomizationRequestDAO();
    locationRequestDAO.updateRequestStatus(requestId, "Approved");

    response.sendRedirect("viewlocationrequests.jsp");
%>
