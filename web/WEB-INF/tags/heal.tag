<%--
    Document   : heal
    Created on : 15/11/2012, 23:42:43
    Author     : Guilherme
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@attribute name="language" required="true"%>
<%@attribute name="vida" required="true"%>
<%@attribute name="moedas" required="true"%>
<%@attribute name="imagem" required="true"%>

<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<div class="toppadding">
    <form method="post" ACTION="hospital.jsp">
        <input type="hidden" name="vida" value="${vida}"/>
        <input type="hidden" name="moedas" value="${moedas}"/>
        <button type="submit">
            <img src="${imagem}"/>
        </button>

        <p class="text">
            ${vida}% <fmt:message key="hospital.text.health"/><BR>
            <font color = yellow>${moedas} <fmt:message key="hospital.text.price"/></>
        </p>
    </form>
</div>

