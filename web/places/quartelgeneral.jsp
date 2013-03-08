
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

<c:if test="${param.fazermissao != null}">
<% 
    String x = ManipularDados.iniciarMissao((Usuario) session.getAttribute("usuario"),
            request.getParameter("nome"));
    pageContext.setAttribute("result",x);
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
    <body style="background-image: url(../imagens/bg1.png);">

    <center>
        <div class="usertopmenu" align="right"><h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true"
                       message="${sessionScope.usuario.personagem.statusMensagemNova}"/> </div>
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
            <!-- aqui começa a tabela com conteúdo da página -->
            <tr>
                <td>
                    <center>
                        <table border="0">

                    <tr>
                        
                        <td rowspan=3 width=200 valign="top" align="center">
                            <div align="center" class="toppadding">
                                <img src="../imagens/outras/armamento.png" width=150 height=150>
                            </div>
                        </td>
                        
                        
                        <td width="600"align="center">
                            <p class="title">
                                <fmt:message key="quartelgeneral.text.title"/>
                            </p>
                            <c:if test="${pageScope.result != null}">
                                <p class="text">
                                    ${pageScope.result}
                                </p>
                            </c:if>
                        </td>
                        
                    </tr>

                    
                    <tr align="center">
                        
                        <td height="60" width="120" align="center">

                            <form method="post "ACTION="quartelgeneral.jsp">
                                <fmt:message key="quartelgeneral.text.missao"/>
                                <BR>
                                <select id="missao" name="missao" onchange="submit()">
                                    <option value="invasao" ${param.missao == 'invasao' ? 'selected' : ''}>
                                        <fmt:message key="missao.invasao.nome"/>
                                    </option>
                                    <option value="defender_posto" ${param.missao == 'defender_posto' ? 'selected' : ''}>
                                        <fmt:message key="missao.defender_posto.nome"/>
                                    </option>

                                </select>
                            </form>

                        </td>
                        
                    </tr>

                    
                    <tr>
                        <td height="250" align="center" valign="top">
                            <form method="post "ACTION="quartelgeneral.jsp">
                                <b>
                                    <fmt:message key="quartelgeneral.text.missao"/>
                                </b>
                                <c:choose>
                                    <c:when test="${param.missao == null}">
                                        <input type="hidden" name="missao" value="invasao"/>
                                        <br>
                                        <fmt:message key="missao.invasao.nome"/>
                                        <br>
                                        <b><fmt:message key="quartelgeneral.text.duracao"/></b>
                                        <br>
                                        <fmt:message key="missao.invasao.duracao"/> <fmt:message key="floresta.text.tempo"/>
                                        <br>
                                        <b><fmt:message key="quartelgeneral.text.dificuldade"/></b>
                                        <br>
                                        <fmt:message key="missao.invasao.dificuldade"/>
                                        <br>
                                        <b><fmt:message key="quartelgeneral.text.recompensa"/></b>
                                        <br>
                                        <fmt:message key="missao.invasao.moedas"/> <fmt:message key="moedas"/>
                                        <br>
                                        <fmt:message key="missao.invasao.xp"/> <fmt:message key="pts_exp"/>
                                        <br>
                                        <b>
                                            <fmt:message key="quartelgeneral.text.descricaomissao"/>
                                        </b>
                                        <br>
                                        <fmt:message key="missao.invasao.descricao"/>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="hidden" name="missao" value="${param.missao}"/>
                                        <br>
                                        <fmt:message key="missao.${param.missao}.nome"/>
                                        <br>
                                        <b><fmt:message key="quartelgeneral.text.duracao"/></b>
                                        <br>
                                        <fmt:message key="missao.${param.missao}.duracao"/> <fmt:message key="floresta.text.tempo"/>
                                        <br>
                                        <b><fmt:message key="quartelgeneral.text.dificuldade"/></b>
                                        <br>
                                        <fmt:message key="missao.${param.missao}.dificuldade"/>
                                        <br>
                                        <b><fmt:message key="quartelgeneral.text.recompensa"/></b>
                                        <br>
                                        <fmt:message key="missao.${param.missao}.moedas"/> <fmt:message key="moedas"/>
                                        <br>
                                        <fmt:message key="missao.${param.missao}.xp"/> <fmt:message key="pts_exp"/>
                                        <br>
                                        <b>
                                            <fmt:message key="quartelgeneral.text.descricaomissao"/>
                                        </b>
                                        <br>
                                        <fmt:message key="missao.${param.missao}.descricao"/>
                                        <br>

                                    </c:otherwise>
                                </c:choose>
                                <div class="toppadding">
                                    <c:choose>
                                        <c:when test="${param.missao != null}">
                                            <input type="hidden" name="nome" value="${param.missao}"/>
                                            <input type="hidden" name="dificuldade" value="missao.${param.missao}.dificuldade"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="nome" value="invasao"/>
                                            <input type="hidden" name="dificuldade" value="missao.invasao.dificuldade"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <input type="submit" name="fazermissao" value='<fmt:message key="quartelgeneral.text.iniciarmissao"/>'/>
                                </div>
                            </form>
                        </td>
                    </tr>

                    
                    <tr>
                        
                        <td width="120">
                            <center>
                                <img src="../imagens/classes/especie_humana/1/classe_civil.png" width=100 height=150/>
                            </center>
                        </td>
                        
                        
                        <td  valign="middle" height="130" align="center">
                            
                            <div class="box1" width="80%">
                                <div class="boxcontent1">
                                    <fmt:message key="quartelgeneral.text.description"/>
                                </div>
                            </div>
                                
                                
                            <div valign="bottom" style="padding-top: 10px;">
                                <form method="post" ACTION="map.jsp" style="padding-bottom: 10px;" align="center">
                                    <input type="submit" value='<fmt:message key="back2"/>'>
                                </form>
                            </div>
                                
                        </td>

                    </tr>
                    <!-- acaba aqui a tabela com conteúdo da página -->
            
                </table>
            </center>
            </td>
            </tr>
        </table>
    </center>
</body>
</html>

