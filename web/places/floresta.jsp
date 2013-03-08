
<%@page import="objetos.Usuario"%>
<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page language="java" contentType="text/html; charset=UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<%--Verifica se o usuário e a página estão nos padrões--%>

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

<c:if test="${param.treinar != null}">
    <%
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        pageContext.setAttribute("result",
                ManipularDados.treinarPersonagem(usuario,
                usuario.getPersonagem().getDuracaoAtributo(request.getParameter("treinar")),
                request.getParameter("treinar")));
    %>
</c:if>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<!DOCTYPE html>
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
        <div class="usertopmenu" align="right">
            <h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true" 
                           message="${sessionScope.usuario.personagem.statusMensagemNova}"/> 
        </div>
        <br>
        <table border="1" width="800" class="main" >
            <tr>
                
                <td colspan="4">
                    <center>
                    <img src="../imagens/killtosurvive.gif" Width=400 Height=73 alt="Kill To Survive">
                    </center>
                </td>
                
            </tr>
            
            
            <tr>

                <td colspan="4">
                    <h:gamemenu language="${language}"/>
                </td>
                
            </tr>
            
            <!-- aqui começa a tabela com o conteúdo da página -->
            <tr>
                <td>
                    <center>
                        <table border="0">

                    <tr>
                        
                        <td rowspan=3 width=200 valign="top">
                            <div align="center" class="toppadding">
                                <img src="../imagens/outras/floresta.png" width=150 height=150>
                            </div>
                        </td>
                        
                        
                        <td width="600" colspan="2" align="center">
                            <p class="title">
                                <fmt:message key="floresta.text.title"/>
                            </p>
                            <c:if test="${pageScope.result != null}">
                                <p class="text">
                                    ${pageScope.result}
                                </p>
                            </c:if>
                        </td>
                        
                    </tr>
                    
                    
                    <tr align="center">
                        <td height="60" width="120" align="center" colspan="2" valign="top">

                            <form method="post "ACTION="floresta.jsp">
                                <fmt:message key="floresta.text.treinar"/>
                                <BR>
                                <select id="atributo" name="atributo" onchange="submit()">
                                    <option value="agilidade" ${param.atributo == 'agilidade' ? 'selected' : ''}>
                                        <fmt:message key="agilidade"/>
                                    </option>
                                    <option value="constituicao" ${param.atributo == 'constituicao' ? 'selected' : ''}>
                                        <fmt:message key="constituicao"/>
                                    </option>
                                    <option value="destreza" ${param.atributo == 'destreza' ? 'selected' : ''}>
                                        <fmt:message key="destreza"/>
                                    </option>
                                    <option value="inteligencia" ${param.atributo == 'inteligencia' ? 'selected' : ''}>
                                        <fmt:message key="inteligencia"/>
                                    </option>
                                    <option value="forca" ${param.atributo == 'forca' ? 'selected' : ''}>
                                        <fmt:message key="forca"/>
                                    </option>
                                    <option value="resistencia" ${param.atributo == 'resistencia' ? 'selected' : ''}>
                                        <fmt:message key="resistencia"/>
                                    </option>
                                </select>
                            </form>

                        </td>			
                    </TR>

                    <TR align="center">
                        <td colspan="2" height="250" valign="top">
                            <form method="post "ACTION="floresta.jsp">
                                <b><fmt:message key="floresta.text.treinarskill"/>:</b>
                                <c:choose>
                                    <c:when test="${param.atributo == null}">
                                        <br><fmt:message key="agilidade"/>
                                    </c:when>
                                    <c:otherwise>
                                        <br><fmt:message key="${param.atributo}"/>
                                    </c:otherwise>
                                </c:choose>

                                <br><b><fmt:message key="floresta.text.duracao"/></b>
                                <br>
                                <c:choose>
                                    <c:when test="${param.atributo == 'agilidade'}">
                                        ${sessionScope.usuario.personagem.duracaoAgilidadeString}
                                        <br><b><fmt:message key="floresta.text.nivelatual"/></b>
                                        <br>
                                        ${sessionScope.usuario.personagem.agilidade}
                                    </c:when>
                                    <c:when test="${param.atributo == 'constituicao'}">
                                        ${sessionScope.usuario.personagem.duracaoConstituicaoString}
                                        <br><b><fmt:message key="floresta.text.nivelatual"/></b>
                                        <br>
                                        ${sessionScope.usuario.personagem.constituicao}
                                    </c:when>
                                    <c:when test="${param.atributo == 'destreza'}">
                                        ${sessionScope.usuario.personagem.duracaoDestrezaString}
                                        <br><b><fmt:message key="floresta.text.nivelatual"/></b>
                                        <br>
                                        ${sessionScope.usuario.personagem.destreza}
                                    </c:when>
                                    <c:when test="${param.atributo == 'inteligencia'}">
                                        ${sessionScope.usuario.personagem.duracaoInteligenciaString}
                                        <br><b><fmt:message key="floresta.text.nivelatual"/></b>
                                        <br>
                                        ${sessionScope.usuario.personagem.inteligencia}
                                    </c:when>
                                    <c:when test="${param.atributo == 'forca'}">
                                        ${sessionScope.usuario.personagem.duracaoForcaString}
                                        <br><b><fmt:message key="floresta.text.nivelatual"/></b>
                                        <br>
                                        ${sessionScope.usuario.personagem.forca}
                                    </c:when>
                                    <c:when test="${param.atributo == 'resistencia'}">
                                        ${sessionScope.usuario.personagem.duracaoResistenciaString}
                                        <br><b><fmt:message key="floresta.text.nivelatual"/></b>
                                        <br>
                                        ${sessionScope.usuario.personagem.resistencia}
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.usuario.personagem.duracaoAgilidadeString}
                                        <br><b><fmt:message key="floresta.text.nivelatual"/></b>
                                        <br>
                                        ${sessionScope.usuario.personagem.agilidade}
                                    </c:otherwise>
                                </c:choose>

                                <br><b><fmt:message key="floresta.text.info"/></b>
                                <c:choose>
                                    <c:when test="${param.atributo == null}">
                                        <br><fmt:message key="agilidade.info"/>
                                    </c:when>
                                    <c:otherwise>
                                        <br><fmt:message key="${param.atributo}.info"/>
                                    </c:otherwise>
                                </c:choose>
                                <br><br>
                            </form>
                            <form method="post" action="floresta.jsp">
                                <c:choose>
                                    <c:when test="${param.atributo != null}">
                                        <input type="hidden" name="treinar" value="${param.atributo}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="hidden" name="treinar" value="agilidade"/>
                                    </c:otherwise>
                                </c:choose>
                                <input type="submit" value='<fmt:message key="floresta.text.treinar"/>'>
                            </form>
                        </td>	
                    </tr>
                    
                    
                    <tr>
                        
                        <td width="120" align="center" valign="top">
                            <img src="../imagens/classes/especie_humana/1/classe_civil.png" width=100 height=150/>
                        </td>
                        
                        
                        <td valign="middle" height="130" align="center"> 
                            <div class="box1" width="80%"> 
                                <div class="boxcontent1">
                                    <fmt:message key="floresta.text.description"/>
                                </div>
                            </div> 

                            <div valign="bottom" style="padding-top: 10px;">
                                <form method="post" ACTION="map.jsp" style="padding-bottom: 10px;" align="center">
                                    <input type="submit" value='<fmt:message key="back2"/>'>
                                </form>      
                            </div>
                        </td> 

                    </tr>

                    <!-- aqui termina a tabela com conteúdo da página -->
                    </td>
                    </tr>
                </table>
            </center>
            </td>
            </tr>
        </table>
    </center>
</body>
</html>


