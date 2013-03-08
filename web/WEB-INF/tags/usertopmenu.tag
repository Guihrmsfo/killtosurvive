<%-- 
    Document   : usertopmenu
    Created on : 06/10/2012, 20:22:36
    Author     : Guilherme
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@attribute name="usuario" required="true"%>
<%@attribute name="language" required="true"%>
<%@attribute name="subpasta" required="true"%>
<%@attribute name="message" required="true"%>

<c:choose>
    <c:when test="${subpasta == true}">
        <c:set var="link" value="../"/>
    </c:when>

    <c:when test="${subpasta == false}">
        <c:set var="link" value=""/>
    </c:when>

</c:choose>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<%-- The list of normal or fragment attributes can be specified here: --%>


<%-- any content can be specified here e.g.: --%>

<font size="1">
<a href="${link}user/preferences.jsp"><fmt:message key="usertopmenu.menu.preferences"/></a>
<a href="${link}user/mail.jsp"><fmt:message key="usertopmenu.menu.messages"/></a>
<fmt:message key="logged.text.loggedas"/>:</font> 
<font color="red">${usuario}</font>
<font size="1"><a href="${link}logoff.jsp"><fmt:message key="main.text.logoff"/></a>
</font>

<c:if test="${message != ''}">
    <hr>
    <div sytle="background-color: red;">
        <a href="${link}user/mail.jsp"> 
            <c:choose>

                <c:when test="${message == 'Message'}">
                    <fmt:message key="usertopmenu.text.newmessage"/>
                </c:when>

                <c:when test="${message == 'System.attack'}">
                    <fmt:message key="usertopmenu.text.attacked"/>
                </c:when>

                <c:when test="${message == 'System.train'}">
                    <fmt:message key="usertopmenu.text.train"/>
                </c:when>

                <c:when test="${message == 'System.mission'}">
                    <fmt:message key="usertopmenu.text.mission"/>
                </c:when>

                <c:when test="${message == 'System.item'}">
                    <fmt:message key="usertopmenu.text.newitem"/>
                </c:when>

            </c:choose>
        </a>
    </div>
</c:if>