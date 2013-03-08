<%--
    Document   : rules
    Created on : 25/08/2012, 23:35:24
    Author     : Guilherme
--%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />
<!DOCTYPE html>
<html lang="${language}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title><fmt:message key="rules.text.title"/> - Kill To Survive</title>
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
        <table>
            <tr>
                <td width="653">
            <center>
                <p class="maintext">
                    <b><fmt:message key="rules.text.title"/></b>
                </p>
                <p class="maintext" align="left">
                    <fmt:message key="rules.text.text1"/>
                    <br>
                    <fmt:message key="rules.text.text2"/>
                    <br><br>
                    <fmt:message key="rules.text.text3"/>
                    <br><br>
                    <fmt:message key="rules.text.rule1"/>
                    <br><br>
                    <fmt:message key="rules.text.rule2"/>
                    <br><br>
                    <fmt:message key="rules.text.rule3"/>
                    <br><br>
                    <fmt:message key="rules.text.rule4"/>
                    <br><br>
                    <fmt:message key="rules.text.rule5"/>
                    <br><br>
                    <fmt:message key="rules.text.rule6"/>
                    <br><br>
                    <fmt:message key="rules.text.rule7"/>
                    <br><br>
                    <fmt:message key="rules.text.rule8"/>
                    <br><br>
                    <fmt:message key="rules.text.rule9"/>
                    <br><br>
                    <fmt:message key="rules.text.text4"/>
                    <br>
                    <fmt:message key="rules.text.text5"/>
                    <br>
                    <fmt:message key="rules.text.text6"/>
                    <br>
                    <fmt:message key="rules.text.text7"/>
                    <br>
                    <fmt:message key="rules.text.text8"/>
                    <br>
                    <fmt:message key="rules.text.text9"/>
                    <br>
                    <fmt:message key="rules.text.text10"/>
                </p>
            </center>
            </td>
            </tr>
        </table>
    </td>
</tr>
</table>
</center>
</body>
</html>