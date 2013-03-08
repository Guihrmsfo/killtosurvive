<%-- 
    Document   : mission
    Created on : 20/11/2012, 02:23:52
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

</c:choose>

<c:if test="${param.cancelar != null}">
    <%
        String r = ManipularDados.excluirMissao((Usuario) session.getAttribute("usuario"));
        pageContext.setAttribute("result", r);
    %>
</c:if>

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
    <body style="background-image: url(../imagens/bg4.png);">

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
                                                <td align="center">
                                                    <p class="title">
                                                        <fmt:message key="missionpage.text.title"/>
                                                    </p>
                                                    <c:if test="${pageScope.result != null}">
                                                        ${pageScope.result}
                                                    </c:if>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <c:choose>
                                                        <c:when test="${sessionScope.usuario.personagem.missao == null}">
                                                            <fmt:message key="missionpage.text.nomission"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${sessionScope.usuario.personagem.missao.tipo == 'Treinamento'}">
                                                                    <fmt:message key="missionpage.text.ocupado.treinamento"/>
                                                                </c:when>

                                                                <c:when test="${sessionScope.usuario.personagem.missao.tipo == 'Caça'}">
                                                                    <fmt:message key="missionpage.text.ocupado.caca"/>
                                                                </c:when>

                                                                <c:otherwise>
                                                                    <fmt:message key="missionpage.text.ocupado.missao"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <div style="padding-top: 20px;">
                                                                <table border="0" class="missao">
                                                                    <tr>
                                                                        <td width="200">
                                                                            <b><fmt:message key="missionpage.text.missao"/></b>
                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <fmt:message key="${sessionScope.usuario.personagem.missao.nome}"/>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <b><fmt:message key="missionpage.text.descricao"/></b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <fmt:message key="${sessionScope.usuario.personagem.missao.descricao}"/>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <b><fmt:message key="missionpage.text.temporestante"/></b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            ${sessionScope.usuario.personagem.tempoRestanteMissaoString}
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <b><fmt:message key="missionpage.text.cancel"/></b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <form action="mission.jsp" method="post">
                                                                                <input type="submit" name="cancelar" value='<fmt:message key="missionpage.button.cancel"/>'/>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>

                                                        </c:otherwise>
                                                    </c:choose>
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
