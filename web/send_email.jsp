<%-- 
    Document   : sendEmail
    Created on : 30/08/2012, 18:03:57
    Author     : Guilherme
--%>

<%@page import="dao.UsuarioDAO"%>
<%@page import="objetos.Usuario"%>
<%@page import="email.EmailSessionBean"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<!DOCTYPE html>

<c:if test="${sessionScope.usuario_RegisterPage == null}">
    <jsp:forward page="main.jsp"/>
</c:if>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
    </head>
    <body>
        <%
            EmailSessionBean emailSession = new EmailSessionBean();
            UsuarioDAO udao = new UsuarioDAO();
            Usuario novo = udao.consultarPorNome(session.getAttribute("usuario_RegisterPage").toString());
            if (emailSession.enviarEmail(novo.getEmail(), "Valide sua conta Kill To Survive", null, EmailSessionBean.EMAILVALIDAR, novo)) {
        %>
        <jsp:forward page="main.jsp">
            <jsp:param name="resendEmail" value="0"/>
        </jsp:forward>
        <%} else {
        %>
        <jsp:forward page="main.jsp">
            <jsp:param name="resendEmail" value="1"/>
        </jsp:forward>
        <%    }
        %>

    </body>
</html>
