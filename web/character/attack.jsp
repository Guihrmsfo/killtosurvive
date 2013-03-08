<%-- 
    Document   : attack
    Created on : 10/11/2012, 18:01:25
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

    <c:when test="${sessionScope.usuario.personagem.missao != null}">
        <%response.sendRedirect("../character/mission.jsp");%>
    </c:when>
    
</c:choose>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<c:choose>

    <c:when test="${param.character == null or param.character == '' or param.character == sessionScope.usuario.personagem.nome}">
        <%response.sendRedirect("character.jsp");%>
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

<c:if test="${sessionScope.personagem.especie == sessionScope.usuario.personagem.especie}">
    <%response.sendRedirect("character.jsp");%>
</c:if>

<c:if test="${param.action == 'attack'}">
    <%
        pageContext.setAttribute("resultado", ManipularDados.atacarPersonagem(((Usuario) session.getAttribute("usuario")).getPersonagem().getNome(), request.getParameter("character")));
    %>    
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
                                <h:optionmenucharacter imagem="${sessionScope.personagem.imagemurl}" myCharacter="${sessionScope.usuario.personagem.nome}" searchCharacter="${param.character}" race="${sessionScope.personagem.especie}" myrace="${sessionScope.usuario.personagem.especie}" language="${language}"/>
                            </td>
                            <td valign="top"> 
                                <div class="padding">
                                    <center>
                                        <table width="550">
                                            <tr>
                                                <td align="center">
                                                    <p class="title">
                                                        <fmt:message key="attackpage.text.attack"/>
                                                    </p>
                                                    <c:choose>
                                                        <c:when test="${pageScope.resultado != null}">

                                                            ${pageScope.resultado}

                                                        </c:when>

                                                        <c:when test="${pageScope.mensagemEnviada != null}">
                                                            <p class="text">
                                                                <fmt:message key="${pageScope.mensagemEnviada}"/>
                                                            </p>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <table class="attackCharacter">
                                                                <tr>
                                                                    <td class="attackCharacterTitleLeft">
                                                                        ${sessionScope.usuario.personagem.nome}
                                                                        <img src="${sessionScope.usuario.personagem.imagemurl}" width="25" height="25"/>
                                                                    </td>

                                                                    <td class="attackCharacterTitleCenter">
                                                                        <img src="../imagens/outras/versus.png" width="20" height="20" title="<fmt:message key="attackpage.text.versus"/>"/>
                                                                    </td>

                                                                    <td class="attackCharacterTitleRight">
                                                                        <img src="${sessionScope.personagem.imagemurl}" width="25" height="25"/>
                                                                        ${sessionScope.personagem.nome}
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="attackCharacterTextLeft">
                                                                        <fmt:message key="${sessionScope.usuario.personagem.classe}.${sessionScope.usuario.personagem.sexo}"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextCenter">
                                                                        <fmt:message key="attackpage.text.class"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextRight">
                                                                        <fmt:message key="${sessionScope.personagem.classe}.${sessionScope.personagem.sexo}"/>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="attackCharacterTextLeft">
                                                                        <fmt:message key="${sessionScope.usuario.personagem.especie}.${sessionScope.usuario.personagem.sexo}"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextCenter">
                                                                        <fmt:message key="attackpage.text.race"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextRight">
                                                                        <fmt:message key="${sessionScope.personagem.especie}.${sessionScope.personagem.sexo}"/>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="attackCharacterTextLeft">
                                                                        ${sessionScope.usuario.personagem.nivel}
                                                                    </td>

                                                                    <td class="attackCharacterTextCenter">
                                                                        <fmt:message key="attackpage.text.level"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextRight">
                                                                        ${sessionScope.personagem.nivel}
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="attackCharacterTextLeft">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.usuario.personagem.armaAtual.nome != null}">
                                                                                <fmt:message key="${sessionScope.usuario.personagem.armaAtual.nome}"/>
                                                                            </c:when>

                                                                            <c:otherwise>
                                                                                <fmt:message key="none1"/>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>

                                                                    <td class="attackCharacterTextCenter">
                                                                        <fmt:message key="attackpage.text.weapon"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextRight">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.personagem.armaAtual.nome != null}">
                                                                                <fmt:message key="${sessionScope.personagem.armaAtual.nome}"/>
                                                                            </c:when>

                                                                            <c:otherwise>
                                                                                <fmt:message key="none1"/>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="attackCharacterTextLeft">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.usuario.personagem.equipamentoAtual.nome != null}">
                                                                                <fmt:message key="${sessionScope.usuario.personagem.equipamentoAtual.nome}"/>
                                                                            </c:when>

                                                                            <c:otherwise>
                                                                                <fmt:message key="none2"/>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>

                                                                    <td class="attackCharacterTextCenter">
                                                                        <fmt:message key="attackpage.text.equipment"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextRight">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.personagem.equipamentoAtual.nome != null}">
                                                                                <fmt:message key="${sessionScope.personagem.equipamentoAtual.nome}"/>
                                                                            </c:when>

                                                                            <c:otherwise>
                                                                                <fmt:message key="none2"/>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td colspan="3"><hr></td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="attackCharacterTextLeft">
                                                                        <div class="barradesaude"> <img src="../${sessionScope.usuario.personagem.imagemSaude}" class="barradesaude" title="${sessionScope.usuario.personagem.saude}%"/></div>
                                                                    </td>

                                                                    <td class="attackCharacterTextCenter">
                                                                        <fmt:message key="attackpage.text.health"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextRight">
                                                                        <div class="barradesaude"> <img src="../${sessionScope.personagem.imagemSaude}" class="barradesaude" title="${sessionScope.personagem.saude}%"/></div>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="attackCharacterTextLeft">
                                                                        ${sessionScope.usuario.personagem.moedas}
                                                                    </td>

                                                                    <td class="attackCharacterTextCenter">
                                                                        <fmt:message key="attackpage.text.coins"/>
                                                                    </td>

                                                                    <td class="attackCharacterTextRight">
                                                                        ${sessionScope.personagem.moedas}
                                                                    </td>
                                                                </tr>

                                                            </table>
                                                            <br>
                                                            <form method="get" action="attack.jsp">
                                                                <input type="hidden" name="character" value="${sessionScope.personagem.nome}"/>
                                                                <input type="hidden" name="action" value="attack"/>
                                                                <input type="submit" value="<fmt:message key="attackpage.text.attack"/>"/>
                                                            </form
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
