<%-- 
    Document   : behavior
    Created on : 20/10/2012, 20:20:42
    Author     : Guilherme
--%>

<%@page import="bdd.ManipularDados"%>
<%@page import="dao.UsuarioDAO"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page import="objetos.PersonagemPadrao"%>
<%@page import="java.util.List"%>
<%@page import="dao.PersonagemPadraoDAO"%>
<%@page import="objetos.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<c:choose>
    <c:when test="${sessionScope.usuario == null}">
        <%response.sendRedirect("../main.jsp");%>
    </c:when>

    <c:when test="${sessionScope.usuario.personagem == null}">
        <%response.sendRedirect("../create_character.jsp");%>
    </c:when>
    
    <c:when test="${param.superior!=null}">
        <%ManipularDados.alterarComportamento(session.getAttribute("usuario"), "superior", request.getParameter("superior"));%>
    </c:when>
    
    <c:when test="${param.equal!=null}">
        <%ManipularDados.alterarComportamento(session.getAttribute("usuario"), "igual", request.getParameter("equal"));%>
    </c:when>
    
    <c:when test="${param.inferior!=null}">
        <%ManipularDados.alterarComportamento(session.getAttribute("usuario"), "inferior", request.getParameter("inferior"));%>
    </c:when>
    
</c:choose>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
        <link rel="icon" type="image/x-icon" href="../imagens/icon.ico" />
        <link rel="shortcut icon" type="image/x-icon" href="../imagens/icon.ico"/>
        <link rel="stylesheet" type="text/css" href="../index.css">
        <link rel="stylesheet" type="text/css" href="../tables.css">
        <link rel="stylesheet" type="text/css" href="../character.css">
    </head>
    <body style="background-image: url(../imagens/bg3.png);">

    <center>
        <div class="usertopmenu" align="right"><h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true" message="${sessionScope.usuario.personagem.statusMensagemNova}"/> </div>
        <br>
        <table border="1" width="800" >
            <tr>
                <td colspan="2">
            <center>
                <img src="../imagens/killtosurvive.gif" Width=400 Height=73 alt="Kill To Survive">
            </center>
            </td>
            </tr>
            <tr>
                <td colspan="2">
                    <h:gamemenu language="${language}"/>
                </td>
            </tr>
            <tr>
                <td>
                    <table height="500">
                        <tr>
                            <td valign="top" align="right" width="200" height="170">
                                <h:optionmenucharacter imagem="${sessionScope.usuario.personagem.imagemurl}" language="${language}"/>
                            </td>

                            <td valign="top" width="550"> 
                                <div class="padding">
                                    <center>
                                        <table width="400">
                                            <tr>
                                                <td align="center">
                                                    <p class="title">
                                                        <fmt:message key="behaviorpage.text.behavior"/>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h:behavior language="${language}" option="superior" title="behaviorpage.text.superior" current="${usuario.personagem.comportamento_Superior}"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h:behavior language="${language}" option="equal" title="behaviorpage.text.equal" current="${usuario.personagem.comportamento_Igual}"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h:behavior language="${language}" option="inferior" title="behaviorpage.text.inferior" current="${usuario.personagem.comportamento_Inferior}" />
                                                </td>
                                            </tr>
                                        </table>
                                    </center>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </center>
</body>
</html>
