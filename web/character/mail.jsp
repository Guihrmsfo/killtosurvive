<%-- 
    Document   : mail
    Created on : 02/11/2012, 20:43:30
    Author     : Guilherme
--%>

<%@page import="objetos.Personagem"%>
<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page import="objetos.PersonagemPadrao"%>
<%@page import="java.util.List"%>
<%@page import="dao.PersonagemPadraoDAO"%>
<%@page import="objetos.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

</c:choose>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<c:choose>

    <c:when test="${param.character == null or param.character == '' or param.character == sessionScope.usuario.personagem.nome}">
        <% session.setAttribute("personagem", ((Usuario) session.getAttribute("usuario")).getPersonagem());
            response.sendRedirect("character.jsp");%>
    </c:when>

    <c:when test="${param.character != null}">
        <% Personagem p = ManipularDados.getPersonagem(request.getParameter("character"));
            if (p != null) {
                session.setAttribute("personagem", p);
            } else {
                response.sendRedirect("character.jsp");
            }
        %>
    </c:when>

</c:choose>

<c:choose>

    <c:when test="${param.message != null and param.message == ''}">
        <% pageContext.setAttribute("result","mailpage.error.messageempty"); %>
    </c:when>

    <c:when test="${param.message != null and param.message != ''}">
        <% if( ManipularDados.enviarMensagem(request.getParameter("title"),
                    request.getParameter("message"), session.getAttribute("personagem"),
                    ((Usuario) session.getAttribute("usuario")).getPersonagem()) ){
            pageContext.setAttribute("result", "mailpage.text.sent");
        }else{
            pageContext.setAttribute("result", "mailpage.error.sent");
        }
        %>
    </c:when>

</c:choose>

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
        <table border="1" width="800" class="main" >
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
                                <h:optionmenucharacter imagem="${sessionScope.personagem.imagemurl}" myCharacter="${sessionScope.usuario.personagem.nome}" searchCharacter="${param.character}" race="${sessionScope.personagem.especie}" myrace="${sessionScope.usuario.personagem.especie}" language="${language}"/>
                            </td>
                            <td valign="top"> 
                                <div class="padding">
                                    <center>
                                        <table width="550">
                                            <tr>
                                                <td align="center">
                                                    <p class="title">
                                                        <fmt:message key="mailpage.text.mail"/>
                                                    </p>
                                                    <c:if test="${pageScope.result != null}">
                                                        <p class="text">
                                                        <fmt:message key="${pageScope.result}"/>
                                                        </p>
                                                    </c:if>
                                                    <div>
                                                        <form method="POST" action="mail.jsp?character=${param.character}"/>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <p class="text">
                                                                        <fmt:message key="mailpage.text.title"/>
                                                                    </p>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <input type="text" size="25" maxlenght="50" name="title">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <p class="text">
                                                                        <fmt:message key="mailpage.text.body"/>
                                                                    </p>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <textarea name="message" value="" maxlength="1000" rows="10" cols="40"></textarea>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    <input type="submit" value="<fmt:message key="submit"/>">
                                                                </td>
                                                            </tr>

                                                        </table>
                                                        </form>
                                                    </div>
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
