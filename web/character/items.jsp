<%-- 
    Document   : items
    Created on : 04/11/2012, 20:06:47
    Author     : Guilherme
--%>

<%@page import="objetos.Personagem"%>
<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page import="objetos.Usuario"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%> 
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

    <c:when test="${sessionScope.usuario.personagem.missao != null}">
        <%response.sendRedirect("../character/mission.jsp");%>
    </c:when>

</c:choose>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<c:choose>

    <c:when test="${param.character == null or param.character == '' or param.character == sessionScope.usuario.personagem.nome}">
        <% session.setAttribute("personagem", ((Usuario) session.getAttribute("usuario")).getPersonagem());
            response.sendRedirect("character.jsp");%>
    </c:when>

    <c:when test="${param.character != null}">
        <% Personagem personagem = ManipularDados.getPersonagem(request.getParameter("character"));
            if (personagem != null) {
                session.setAttribute("personagem", personagem);
            } else {
                response.sendRedirect("character.jsp");
            }
        %>
    </c:when>

</c:choose>

<c:if test="${sessionScope.personagem.especie != sessionScope.usuario.personagem.especie}">
    <%response.sendRedirect("character.jsp");%>
</c:if>

<c:if test="${param.id != null}">


    <c:choose>

        <c:when test="${param.tipo == 'arma'}">
            <%
                Usuario user = (Usuario) session.getAttribute("usuario");
                int id = Integer.parseInt(request.getParameter("id"));
                Personagem p = ManipularDados.getPersonagem(request.getParameter("character"));


                String r = ManipularDados.darArma(user.getPersonagem(), p, id);
                pageContext.setAttribute("result", r);
                session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));

            %>
        </c:when>

        <c:otherwise>
            <%
                Usuario usuario = (Usuario) session.getAttribute("usuario");
                int equipamentoId = Integer.parseInt(request.getParameter("id"));
                Personagem caracter = ManipularDados.getPersonagem(request.getParameter("character"));

                String result = ManipularDados.darEquipamento(usuario.getPersonagem(), caracter, equipamentoId);
                pageContext.setAttribute("result", result);
                session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));

            %>
        </c:otherwise>

    </c:choose>

</c:if>

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
    <body style="background-image: url(../imagens/bg2.png);">
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
                                                        <fmt:message key="itemspage.text.items"/>
                                                    </p>
                                                    <c:if test="${pageScope.result != null}">
                                                        ${pageScope.result}
                                                    </c:if>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <br>
                                            <center>
                                                <table class="giveitems" border="1">
                                                    <tr>
                                                        <c:choose>
                                                            <c:when test="${fn:length(sessionScope.usuario.personagem.equipamentos)==0 && fn:length(sessionScope.usuario.personagem.armas)==0}">
                                                                <fmt:message key="itemspage.text.noitems"/>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <td class="giveitemsindex" style="border-top: 0px;border-left: 0px;">
                                                                    <fmt:message key="itemspage.text.name"/>
                                                                </td>
                                                                <td class="giveitemsindex" style="border-top: 0px;">
                                                                    <fmt:message key="itemspage.text.description"/>
                                                                </td>
                                                                <td class="giveitemsindex" style="border-top: 0px;border-right: 0px;">
                                                                </td>
                                                            </c:otherwise>

                                                        </c:choose>

                                                    </tr>

                                                    <c:forEach items="${sessionScope.usuario.personagem.armas}" begin="0"  step="1" var="arma">
                                                        <tr>
                                                            <td style="border-left: 0px;">
                                                                <fmt:message key="${arma.nome}"/>
                                                            </td>
                                                            <td>
                                                                <fmt:message key="itemspage.text.gun"/>
                                                            </td>
                                                            <td style="border-right: 0px;">
                                                                <form action="items.jsp" method="post">
                                                                    <input type="hidden" name="character" value="${param.character}"/>
                                                                    <input type="hidden" name="tipo" value="arma"/>
                                                                    <input type="hidden" name="id" value="${arma.armaId}"/>
                                                                    <input type="submit" value="<fmt:message key="itemspage.text.giveitem"/>"/>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                    <c:forEach items="${sessionScope.usuario.personagem.equipamentos}" begin="0"  step="1" var="equipamento" varStatus ="row">
                                                        <tr>

                                                            <c:choose>

                                                                <c:when test="${fn:length(sessionScope.usuario.personagem.equipamentos)==row.count}">
                                                                    <c:set var="estilo" value="border-bottom: 0px;"/>
                                                                </c:when>

                                                                <c:otherwise>
                                                                    <c:set var="estilo" value=""/>
                                                                </c:otherwise>

                                                            </c:choose>    


                                                            <td style="${estilo}border-left: 0px;">
                                                                <fmt:message key="${equipamento.nome}"/>
                                                            </td>
                                                            <td style="${estilo}">
                                                                <fmt:message key="itemspage.text.equipment"/>
                                                            </td>
                                                            <td style="${estilo}border-right: 0px;">
                                                                <form action="items.jsp" method="post">
                                                                    <input type="hidden" name="character" value="${param.character}"/>
                                                                    <input type="hidden" name="tipo" value="equipamento"/>
                                                                    <input type="hidden" name="id" value="${equipamento.equipamentoId}"/>
                                                                    <input type="submit" value="<fmt:message key="itemspage.text.giveitem"/>"/>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                </table>
                                            </center>
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

