<%-- 
    Document   : register
    Created on : 25/08/2012, 17:13:38
    Author     : Guilherme
--%>


<%@page import="objetos.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<c:if test="${sessionScope.usuario_RegisterPage == null}">
    <c:set var="usuario_RegisterPage" scope="session" value=""/>
</c:if>

<c:if test="${sessionScope.Email1_registerPage == null}">
    <c:set var="Email1_registerPage" scope="session" value=""/>
</c:if>

<c:if test="${sessionScope.Email2_registerPage == null}">
    <c:set var="Email2_registerPage" scope="session" value=""/>
</c:if>

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
            <tr>
                <td align="center">
                    <b><fmt:message key="register.text.topic"/></b>
                    <br>
                    <table>
                        <FORM METHOD=POST ACTION="register_account.jsp">

                            <tr><td colspan="2"><fmt:message key="login.text.username" /></td>
                            </tr>
                            <tr><td><INPUT TYPE=text NAME=username SIZE=30 value="${sessionScope.usuario_RegisterPage}">
                                </td>

                            </tr>
                            <tr><td colspan="2"><fmt:message key="register.text.email" /></td>
                            </tr>
                            <tr><td><INPUT TYPE=text NAME=email SIZE=30 value="${sessionScope.Email1_registerPage}">
                                </td>

                            </tr>
                            <tr><td colspan="2"><fmt:message key="register.text.repeatemail" /></td>
                            </tr>
                            <tr><td><INPUT TYPE=text NAME=email2 SIZE=30 value="${sessionScope.Email2_registerPage}">
                                </td>

                            </tr>
                            <tr><td colspan="2"><fmt:message key="login.text.password" /></td>
                            </tr>
                            <tr><td><INPUT TYPE=password NAME="password" SIZE=30></td>

                            </tr>
                            <tr><td colspan="2"><fmt:message key="register.text.repeatpassword" /></td>
                            </tr>
                            <tr><td><INPUT TYPE=password NAME="password2" SIZE=30></td>

                            </tr>
                            <tr><td colspan="2"><fmt:message key="register.text.iagree" /> 
                                    <a target="_blank" href="rules.jsp"><u><fmt:message key="register.text.rules" />.</u></a>
                                    <input type="checkbox" name="acceptrules" value="ON"/>
                                </td>
                            </tr>
                            <tr><td align=left colspan="2"><fmt:message key="register.button.submit" var="buttonValue2" />
                                    <input type="submit" value="${buttonValue2}"></td></tr>
                        </form>

                    </table>
                </td>
            </tr>
            <tr><td> <center>

                <c:choose>
                    <c:when test="${-3 == param.resultadoTryRegister}">
                        <fmt:message key="register.error.error"/>.
                    </c:when>
                    <c:when test="${0 == param.resultadoTryRegister}">
                        <fmt:message key="register.error.agreement"/>.
                    </c:when>

                    <c:when test="${1 == param.resultadoTryRegister}">
                        <fmt:message key="register.error.incomplete"/>.
                    </c:when>   

                    <c:when test="${2 == param.resultadoTryRegister}">
                        <fmt:message key="register.error.email"/>.
                    </c:when>

                    <c:when test="${3 == param.resultadoTryRegister}">
                        <fmt:message key="register.error.password"/>.
                    </c:when>

                    <c:when test="${4 ==param.resultadoTryRegister}">
                        <fmt:message key="register.error.usernameAlreadyExists"/>.
                    </c:when>

                    <c:when test="${5 == param.resultadoTryRegister}">
                        <fmt:message key="register.error.emailAlreadyExists"/>.
                    </c:when>
                        
                    <c:when test="${6 == param.resultadoTryRegister}">
                        <fmt:message key="register.error.specialCaracter"/>.
                    </c:when>
                </c:choose>
                        
                </td>
            </center>
            </tr>
        </table>
    </center>

</body>
</html>