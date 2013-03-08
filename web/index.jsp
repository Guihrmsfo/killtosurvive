<%-- 
    Document   : index
    Created on : 13/08/2012, 22:13:38
    Author     : Guilherme
--%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
            <font size="2"><fmt:message key="index.text.areyoulost" />
            <a href="main.jsp"><fmt:message key="index.text.main" /></a></font>
        </form>


    <center>
        <table border=0> 
            <tr>
                <td colspan=2>
                    <img src="imagens/logo.gif" Width=683 Height=450 alt="Kill To Survive">
                </td>
            </tr>
            <tr>
                <td>
            <center>
                <table border="0">
                    <FORM METHOD=POST ACTION="login.jsp">
                        <tr> <td colspan=2><b><fmt:message key="login.text.login" /></b></td></tr>
                        <tr><td><fmt:message key="login.text.username" /></td><td><INPUT TYPE=text NAME=username SIZE=25></td></tr>
                        <tr><td><fmt:message key="login.text.password" /></td><td><INPUT TYPE=password NAME="password" SIZE=25></td></tr>
                        <tr><td colspan=2 align=right>
                                <fmt:message key="login.button.submit" var="buttonValue" />
                                <input type="submit" value="${buttonValue}">
                        <tr><td colspan=2 align="center"><font size="2"><fmt:message key="login.text.naocadastrado1" /> <a href="register.jsp"><u><fmt:message key="login.text.naocadastrado2" /></u></a></font></td></tr>    
                    </form>
                </table>
            </center>
            </td>
            </tr>
        </table>
    </center>
</body>
<adress>
    <font size="1">Kill To Survive: IFSP - Turma 333 Ímpares</font>
</adress>
</html>
