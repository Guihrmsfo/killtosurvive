
<%-- Verificação das preferências do usuário--%>

<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page language="java" contentType="text/html; charset=UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<%-- Verificação se está dentro dos padrões para entrar na página--%>

<c:choose>
    <c:when test="${sessionScope.usuario == null}">
        <%response.sendRedirect("../main.jsp");%>
    </c:when>

    <c:when test="${sessionScope.usuario.personagem == null}">
        <%response.sendRedirect("../create_character.jsp");%>
    </c:when>
</c:choose>

<%
    pageContext.setAttribute("ranking", ManipularDados.getRanking());
%>

<!DOCTYPE html>
<html>
    
    <%-- Importação das imagens de ícone e logotipo--%>
    
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
        <div class="usertopmenu" align="right">
            <h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true" message="${sessionScope.usuario.personagem.statusMensagemNova}"/> 
        </div>
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
                <td align="center" height="500" valign="top">
                    
                    <%-- Ínicio da tabela com conteúdo da página--%>
                    
                    <table class="ranking">
                        <tr>
                            <td colspan="5" align="center">
                                <div class="toppadding">
                                    <p class="title">
                                        <fmt:message key="rankingpage.text.title"/>
                                    </p>
                                </div>
                            </td>
                        </tr>

                            <%-- Mostra o nome, raça, classe e nível do personagem dentro do ranking--%>
                            
                        <tr>
                            <td class="rankingindex">#</td>
                            <td class="rankingindex"><fmt:message key="rankingpage.text.nome"/></td>
                            <td class="rankingindex"><fmt:message key="rankingpage.text.raca"/></td>
                            <td class="rankingindex"><fmt:message key="rankingpage.text.classe"/></td>
                            <td class="rankingindex"><fmt:message key="rankingpage.text.nivel"/></td>
                        </tr>

                        <c:forEach items="${pageScope.ranking}" begin="0" end="50" step="1" var="personagem" varStatus="row">
                            <c:choose>
                                <c:when test="${row.count % 2 == 0}">
                                    <c:set var="estiloLinha" value="altranking2"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="estiloLinha" value="altranking1"/>
                                </c:otherwise>
                            </c:choose>

                            <tr>
                                <td width="20" class="${estiloLinha}">${row.count}</td>
                                <td width="150" class="${estiloLinha}"><a href="../character/character.jsp?character=${personagem.nome}">${personagem.nome}</a></td>
                                <td width="100" class="${estiloLinha}"><fmt:message key="${personagem.especie}"/></td>
                                <td width="100" class="${estiloLinha}"><fmt:message key="${personagem.classe}"/></td>
                                <td width="50" class="${estiloLinha}">${personagem.nivel}</td>
                            </tr>
                        </c:forEach>

                    </table>

                        <%-- Fim da tabela com conteúdo da página--%>
                        
                </td>
            </tr>
        </table>
    </center>
</body>
</html>

