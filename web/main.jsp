
<%-- 
    Document   : main
    Created on : 19/08/2012, 00:00:15
    Author     : Tavares
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
        <table >
            <tr>
                <td colspan=2>
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
            <tr>
                <td Width=420 align=center valign=top>
                    <p align="left" class="maintext"><b><fmt:message key="main.text.text1"/></b>
                        <br><fmt:message key="main.text.text2"/><br><fmt:message key="main.text.text3"/>
                        <br><br><b><fmt:message key="main.text.text4"/></b>
                        <br>-<b><fmt:message key="main.text.humans"/>:</b> <fmt:message key="main.text.text5"/>.
                        <br>-<b><fmt:message key="main.text.ashens"/>:</b> <fmt:message key="main.text.text6"/>.
                        <br>-<b><fmt:message key="main.text.vendettas"/>:</b> <fmt:message key="main.text.text7"/>.
                        <br><br><fmt:message key="main.text.text8"/> <a href="register.jsp"><u><fmt:message key="main.text.text9"/></u></a> <fmt:message key="main.text.text10"/>
                    </p>
                </td>

                <td Width=150 align=left valign="top"> 
                    <table align="left">
                        <FORM METHOD=POST ACTION="login.jsp">
                            <tr> <td><b><fmt:message key="login.text.login" /></b></td></tr>
                            <tr><td><fmt:message key="login.text.username" /></td></tr>
                            <tr><td><INPUT TYPE=text NAME=username SIZE=20></td></tr>
                            <tr><td><fmt:message key="login.text.password" /></td></tr>
                            <tr><td><INPUT TYPE=password NAME="password" SIZE=20></td></tr>
                            <tr><td align=right><fmt:message key="login.button.submit" var="buttonValue1" />
                                    <input type="submit" value="${buttonValue1}"></td></tr>
                            <tr><td>
                                    <c:if test="${param.FailLogin != null}">
                                        <font size="2" color="red"><fmt:message key="login.error.login"/></font>
                                    </c:if>

                                    <c:if test="${param.resendEmail != null}">
                                        <font size="2" color="white">

                                        <c:if test="${param.resendEmail == '0'}">
                                            <fmt:message key="login.text.reenviado"/>
                                        </c:if>

                                        <c:if test="${param.resendEmail == '1'}">
                                            <fmt:message key="login.text.reenviarFail"/>
                                        </c:if>

                                        </font> 
                                    </c:if>

                                </td></tr>
                        </form>
                    </table>
                </td>
            </tr>
        </table>
    </td></tr>

</table>
</center>
</body>
</html>
