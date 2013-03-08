<%@page import="bdd.CriarObjeto"%>
<%@page import="email.EmailSessionBean"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="objetos.Usuario"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%-- 
    Document   : register_account
    Created on : 25/08/2012, 17:32:08
    Author     : Guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />
<!DOCTYPE html>
<html lang="${language}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
        <link rel="icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="shortcut icon" href="imagens/icon.ico" type="image/x-icon"/>
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
        <table border=0>
            <tr>
                <td>
                    <img src="imagens/killtosurvive.gif" Width=653 Height=120 alt="Kill To Survive">
                </td>
            </tr>
            <tr><td height=40 valign=top>
            <center>
                <a href="main.jsp"><fmt:message key="menu.text.welcome"/></a>
                - <a href="register.jsp"><fmt:message key="register.text.topic"/></a>
                - <a href="about.jsp"><fmt:message key="menu.text.about"/></a>
            </center>
            </td>
            </tr>
            <tr><td>
                    <%
                        session.setAttribute("usuario_RegisterPage", request.getParameter("username"));
                        session.setAttribute("email1_RegisterPage", request.getParameter("email"));
                        session.setAttribute("email2_RegisterPage", request.getParameter("email2"));

                        int i = CriarObjeto.criarUsuario(request.getParameter("username"),
                                request.getParameter("password"),
                                request.getParameter("password2"),
                                request.getParameter("email"),
                                request.getParameter("email2"),
                                session.getAttribute("language").toString(),
                                request.getParameter("acceptrules"));

                        request.setAttribute("i", Integer.toString(i));
                    %>
                    <c:set var="i" value="<%=i%>" scope="page" />
                    <c:choose>
                        <c:when test="${-3 == i}">
                            <jsp:forward page = "register.jsp"> 
                                <jsp:param name = "resultadoTryRegister" value = "-3" /> 
                            </jsp:forward>   
                        </c:when> 

                        <c:when test="${-2 == i}">
                    <center>
                        <fmt:message key="register.text.sendEmailFail"/><br>
                        <a href="send_email.jsp"><fmt:message key="login.text.reenviar"/></a>
                    </center>    
                </c:when>
                <c:when test="${-1 == i}">
                    <% session.setAttribute("usuario_RegisterPage", "");
                        session.setAttribute("email1_RegisterPage", "");
                        session.setAttribute("email2_RegisterPage", "");%>
                    <center><fmt:message key="register.text.registered"/><br><fmt:message key="register.text.emailReminder"/></center>
                    </c:when> 
                    <c:when test="${0 == i}">
                        <jsp:forward page = "register.jsp"> 
                            <jsp:param name = "resultadoTryRegister" value = "0" /> 
                        </jsp:forward>   
                    </c:when> 
                    <c:when test="${1 == i}">
                        <jsp:forward page = "register.jsp"> 
                            <jsp:param name = "resultadoTryRegister" value = "1" /> 
                        </jsp:forward>   
                    </c:when> 
                    <c:when test="${2 == i}">
                        <jsp:forward page = "register.jsp"> 
                            <jsp:param name = "resultadoTryRegister" value = "2" /> 
                        </jsp:forward>   
                    </c:when> 
                    <c:when test="${3 == i}">
                        <jsp:forward page = "register.jsp"> 
                            <jsp:param name = "resultadoTryRegister" value = "3" /> 
                        </jsp:forward>   
                    </c:when> 
                    <c:when test="${4 == i}">
                        <jsp:forward page = "register.jsp"> 
                            <jsp:param name = "resultadoTryRegister" value = "4" /> 
                        </jsp:forward>   
                    </c:when> 
                    <c:when test="${5 == i}">
                        <jsp:forward page = "register.jsp"> 
                            <jsp:param name = "resultadoTryRegister" value = "5" /> 
                        </jsp:forward>   
                    </c:when> 
                    <c:when test="${6 == i}">
                        <jsp:forward page = "register.jsp"> 
                            <jsp:param name = "resultadoTryRegister" value = "6" /> 
                        </jsp:forward>   
                    </c:when> 
                </c:choose>




            </td>
            </tr>
        </table>
    </center>
</body>
</html>
