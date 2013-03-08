<%--
    Document   : behavior
    Created on : 20/10/2012, 22:14:05
    Author     : Guilherme
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@attribute name="language" required="true"%>
<%@attribute name="title" required="true"%>
<%@attribute name="option" required="true"%>
<%@attribute name="current" required="true"%>

<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<table align="center">
    <td align="center">
        <p class="text">
            <fmt:message key="${title}"/>
            <br><br>
            <b><fmt:message key="behaviorpage.text.behavior"/>:</b>
        </p>
    </td>
</tr>
<tr>
    <td align="center">
        <form method="post" action="behavior.jsp">
            <select id="${option}" name="${option}" onchange="submit()">
                <option value="def" ${current == 'def' ? 'selected' : ''}><fmt:message key="behaviorpage.text.defensive"/></option>
                <option value="bal" ${current == 'bal' ? 'selected' : ''}><fmt:message key="behaviorpage.text.balanced"/></option>
                <option value="ofen" ${current == 'ofen' ? 'selected' : ''}><fmt:message key="behaviorpage.text.offensive"/></option>
            </select>
        </form>
    </td>
</tr>
</table>