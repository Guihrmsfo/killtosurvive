<%-- 
    Document   : intro
    Created on : 04/12/2012, 19:37:02
    Author     : Guilherme
--%>

<%@page import="bdd.ManipularDados"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<c:choose>
    <c:when test="${sessionScope.usuario == null}">
        <%response.sendRedirect("main.jsp");%>
    </c:when>
</c:choose>

<% if (session.getAttribute("usuario") != null) {
        session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
        <link rel="icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="shortcut icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="index.css">
    </head>

    <body style="background-image: url(imagens/index_background.gif);">
        <div style="padding-top: 5%;padding-left: 15%;">

            <div style="height: 500px;width:700px;background-color: black;border-radius: 10px;">
                <div style="font-size: 22px;font-weight: bold;font-family: Segoe UI;text-align: center;position: relative;">
                    <fmt:message key="raca"/> <fmt:message key="${sessionScope.usuario.personagem.especie}"/>
                </div>
                <hr>
                <div style="font-size: 16px;font-family: Segoe UI;text-align: center;
                     padding-left: 50px;padding-right:50px">
                    <fmt:message key="${sessionScope.usuario.personagem.especie}.intro"/>
                </div>

                <div style="right: 0%;bottom: 0%;position: absolute;">
                    <img width="300" height="300" src="imagens/classes/${sessionScope.usuario.personagem.especie}/0/classe_soldado.png"/>
                </div>

                <div style="left: 48%; bottom: 20%;position: absolute;">
                    <form action="character/character.jsp" method="post">
                        <input type="submit" value='<fmt:message key="intro.jogar"/>'/>
                    </form>
                </div>
            </div>
        </div>

    </body>

</html>