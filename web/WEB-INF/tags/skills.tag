<%-- 
    Document   : skills
    Created on : 29/10/2012, 01:40:49
    Author     : Guilherme
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>


<%@attribute name="language" required="true"%>
<%@attribute name="name" required="true"%>
<%@attribute name="description" required="true"%>
<%@attribute name="value" required="true"%>
<%@attribute name="effect" required="true"%>

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
        <b><fmt:message key="skillspage.text.skillname"/>:</b>
        <fmt:message key="${name}"/>
        <br>
        <b><fmt:message key="description"/>:</b>
        <fmt:message key="${description}"/>
        <br>
        <b><fmt:message key="skillspage.text.effect"/>:</b>
        ${value} <fmt:message key="${effect}"/>.
    </div>
</div>

