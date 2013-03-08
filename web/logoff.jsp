<%-- 
    Document   : logoff
    Created on : 26/08/2012, 19:53:22
    Author     : Guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
    </head>
    <body>
        <%session.invalidate();
        response.sendRedirect("main.jsp");
%>

    </body>
</html>
