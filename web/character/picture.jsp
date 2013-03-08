<%-- 
    Document   : picture
    Created on : 30/09/2012, 19:45:36
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
    
    <c:when test="${param.link != null}">
        <%
            if (ManipularDados.salvarImagem(
                    (Usuario) session.getAttribute("usuario"),
                    request.getParameter("link"))) {
                pageContext.setAttribute("atualizado", true);
            } else {
                pageContext.setAttribute("atualizado", false);
            }
        %>
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
    <body style="background-image: url(../imagens/bg1.png);">

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
                                <h:optionmenucharacter imagem="${sessionScope.usuario.personagem.imagemurl}" language="${language}"/>
                            </td>

                            <td valign="top" width="550"> 
                                <div class="padding">
                                    <center>
                                        <table width="400">
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <p class="title">
                                                        <fmt:message key="picturepage.text.changepicture"/>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <p class="text" align="center">
                                                        <fmt:message key="picturepage.text.text"/>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="center">
                                                    <form method="post" action="">
                                                        <input type="text" name="link"/>
                                                        <input type="submit" value="<fmt:message key="submit"/>"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" valign="top">
                                                    <p class="text">
                                                        <c:if test="${param.link != null}">
                                                            <c:choose>
                                                                <c:when test="${pageScope.atualizado==true}">
                                                                    <fmt:message key="picturepage.update.success"/>
                                                                </c:when>
                                                                <c:when test="${pageScope.atualizado==false}">
                                                                    <fmt:message key="picturepage.update.fail"/>
                                                                </c:when>
                                                            </c:choose>
                                                        </c:if>
                                                    </p>
                                                </td>
                                            </tr>
                                            </form>
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
