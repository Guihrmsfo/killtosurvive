<%-- 
    Document   : gamemenu
    Created on : 07/10/2012, 02:38:16
    Author     : Guilherme
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@attribute name="language" required="true"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<center>
    <b>
        <a href="../character/character.jsp" class="gamemenu"><fmt:message key="gamemenu.text.characterpage"/></a>
        <a href="../places/map.jsp" class="gamemenu"><fmt:message key="gamemenu.text.placespage"/></a>
        <a href="../status/ranking.jsp" class="gamemenu"><fmt:message key="gamemenu.text.rankingpage"/></a>
    </b>
</center>
