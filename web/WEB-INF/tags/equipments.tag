<%-- 
    Document   : equipments
    Created on : 28/10/2012, 22:16:12
    Author     : Guilherme
--%>


<%@tag description="put the tag description here" pageEncoding="UTF-8"%>


<%@attribute name="language" required="true"%>
<%@attribute name="name" required="true"%>
<%@attribute name="description" required="true"%>
<%@attribute name="defense" required="true"%>
<%@attribute name="actualEquipment" required="true"%>

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
        <b><fmt:message key="equipmentspage.text.equipmentname"/>:</b>
        <fmt:message key="${name}"/>
        <br>
        <b><fmt:message key="description"/>:</b>
        <fmt:message key="${description}"/>
        <br>
        <b><fmt:message key="equipmentspage.text.defense"/>:</b>
        ${defense} <fmt:message key="equipmentspage.text.defensepoints"/>
        <hr>
        <c:choose>

            <c:when test="${actualEquipment == name}">
                <form method="post" action="equipments.jsp">
                    <input type="hidden" name="equipmentName" value="null">
                    <input type="submit" value="<fmt:message key="equipmentspage.text.unequip"/>"/>
                </form>
            </c:when>

            <c:when test="${actualEquipment != name}">
                <form method="post" action="equipments.jsp">
                    <input type="hidden" name="equipmentName" value="${name}">
                    <input type="submit" value="<fmt:message key="equipmentspage.text.choose"/>"/>
                </form>
            </c:when>

        </c:choose>


    </div>
</div>

