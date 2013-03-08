
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
</c:choose>

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
            
                   <!-- imagens com suas linkagem devidamente posicionada --> 
            
            <tr>
                
                <td>
                    <img id="maps" src="../imagens/outras/mapa.png" usemap="#maps" border="0" width="816" height="368" alt="" />
                    
                    <map id="maps" name="maps">
                        <area shape="poly" coords="692,48,540,48,512,92,508,224,816,208,816,96,688,92," href="hospital.jsp" alt="<fmt:message key="map.text.hospital"/>" title="<fmt:message key="map.text.hospital"/>"/>
                        <area shape="poly" coords="408,32,456,32,468,100,432,148,424,60," href="armamento.jsp" alt="<fmt:message key="map.text.store"/>" title="<fmt:message key="map.text.store"/>"/>
                        <area shape="poly" coords="432,148,424,64,408,32,388,32,364,16,280,8,212,60,196,80,172,100,152,136,152,240,368,236," href="quartelgeneral.jsp" alt="<fmt:message key="map.text.headquarters"/>" title="<fmt:message key="map.text.headquarters"/>"/>                        <area shape="rect" coords="760,4,812,32" href="floresta.jsp" alt="<fmt:message key="map.text.forest"/>" title="<fmt:message key="map.text.forest"/>"/>
                        <area shape="poly" coords="360,332,348,336,364,356,392,340,376,340,388,324,368,324," href="../character/character.jsp" alt="<fmt:message key="back2"/>" title="<fmt:message key="back2"/>"/>
                    </map>
                </td>
                
            </tr>
            
        </table>
    </center>
</body>
</html>
