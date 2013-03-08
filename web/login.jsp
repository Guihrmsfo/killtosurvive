<%-- 
    Document   : login
    Created on : 25/08/2012, 18:06:24
    Author     : Guilherme
--%>

<%@page import="dao.UsuarioDAO"%>
<%@page import="objetos.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Kill To Survive</title>
        <link rel="icon" type="image/x-icon" href="imagens/icon.ico" />
        <link rel="shortcut icon" type="image/x-icon" href="imagens/icon.ico"/>
        <link rel="stylesheet" type="text/css" href="index.css">
    </head>
    <body style="background-image: url(imagens/index_background.gif);">
        <form>
            <select id="language" name="language" onchange="submit()">
                <option value="en" ${language == 'en' ? 'selected' : ''}>English</option>
                <option value="pt_BR" ${language == 'pt_BR' ? 'selected' : ''}>Português (BR)</option>
            </select>
        </form>
    <center>
        <table >
            <tr>
                <td colspan="2">
                    <img src="imagens/killtosurvive.gif" Width=653 Height=120 alt="Kill To Survive">
                </td>
            </tr>
            <tr><td colspan=2 height=40 valign=top>
            <center>
                <a href="main.jsp"><fmt:message key="menu.text.welcome"/></a>
                - <a href="register.jsp"><fmt:message key="register.text.topic"/></a>
                - <a href="about.jsp"><fmt:message key="menu.text.about"/></a>
            </center>
            </td>
            </tr>
            <tr><td>
            <center>
                <%
                    UsuarioDAO dao = new UsuarioDAO();
                    String nome = request.getParameter("username"), senha = request.getParameter("password");;
                    Usuario usuario = dao.consultarPorNome(nome);
                    if (usuario == null) {
                %>
                <jsp:forward page="main.jsp">
                    <jsp:param name="FailLogin" value="1"/>
                </jsp:forward>
                <%} else {
                    if (senha.equals(usuario.getSenha())) {
                        if (usuario.isValido()) {
                %>
                <% session.setAttribute("usuario", usuario);%>
                <% session.setAttribute("language", usuario.getIdioma());
                    response.sendRedirect("character/character.jsp");
                } else {
                    session.setAttribute("usuario_RegisterPage", usuario.getUsuario());
                %>

                <center><fmt:message key="login.text.contaInvalida"/><br><a href="send_email.jsp"><fmt:message key="login.text.reenviar"/></a></center>

                <%
                    }
                } else {%>
                <jsp:forward page="main.jsp">
                    <jsp:param name="FailLogin" value="1"/>
                </jsp:forward>
                <%                        }
                    }


                %>
            </center>
            </td>
            </tr>
        </table>
    </center>
</body>
</html>