<%-- 
    Document   : weapons
    Created on : 28/10/2012, 03:34:11
    Author     : Guilherme
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>


<%@attribute name="language" required="true"%>
<%@attribute name="name" required="true"%>
<%@attribute name="description" required="true"%>
<%@attribute name="damage" required="true"%>
<%@attribute name="actualWeapon" required="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<div align="left" class="box1" style="width: 400px">
    <div class="boxname1">
        <p class="boxname1">
            <b><fmt:message key="${name}"/></b>
        </p>
    </div>
    <div class="boxcontent1">
        <b><fmt:message key="weaponspage.text.weaponname"/>:</b>
        <fmt:message key="${name}"/>
        <br>
        <b><fmt:message key="description"/>:</b>
        <fmt:message key="${description}"/>
        <br>
        <b><fmt:message key="damage"/>:</b>
        ${damage} <fmt:message key="weaponspage.text.damage"/>
        <hr>
        <c:choose>

            <c:when test="${actualWeapon == name}">
                <form method="post" action="weapons.jsp">
                    <input type="hidden" name="weaponName" value="null">
                    <input type="submit" value="<fmt:message key="weaponspage.text.disarm"/>"/>
                </form>
            </c:when>

            <c:when test="${actualWeapon != name}">
                <form method="post" action="weapons.jsp">
                    <input type="hidden" name="weaponName" value="${name}">
                    <input type="submit" value="<fmt:message key="weaponspage.text.choose"/>"/>
                </form>
            </c:when>
        </c:choose>


    </div>
</div>

