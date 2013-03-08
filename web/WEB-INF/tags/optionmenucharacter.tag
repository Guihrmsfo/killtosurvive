<%-- 
    Document   : optionmenucharacter
    Created on : 30/09/2012, 20:26:23
    Author     : Guilherme
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@attribute name="imagem" required="true"%>
<%@attribute name="searchCharacter" required="false"%>
<%@attribute name="myCharacter" required="false"%>
<%@attribute name="race" required="false"%>
<%@attribute name="myrace" required="false"%>
<%@attribute name="language" required="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<%-- The list of normal or fragment attributes can be specified here: --%>


<%-- any content can be specified here e.g.: --%>
<table>
    <tr>
        <td>
            <div class="toppadding">
                <div class="image">
                    <center>
                        <img src="${imagem}" width="170" height="170" class="character" alt="${sessionScope.Usuario.personagem.nome}"/>
                    </center>
                </div>
            </div>
        </td>

    </tr>
    <tr>
        <td valign="top">
            <br>
            <c:choose>
                <c:when test="${searchCharacter == null or searchCharacter == '' or searchCharacter == myCharacter}">
                    <table class="characteroptionmenu" width="180">
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="character.jsp"><fmt:message key="characterpage.menu.character"/> </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="attributes.jsp"><fmt:message key="characterpage.menu.attributes"/></a>        
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="behavior.jsp"><fmt:message key="characterpage.menu.behavior"/> </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="equipments.jsp"><fmt:message key="characterpage.menu.equipments"/> </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="weapons.jsp"><fmt:message key="characterpage.menu.weapons"/>  </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="skills.jsp"><fmt:message key="characterpage.menu.skills"/> </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="mission.jsp"><fmt:message key="characterpage.menu.mission"/> </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="picture.jsp"><fmt:message key="characterpage.menu.changepicture"/></a>        
                            </td>
                        </tr>
                    </table>
                </c:when>
                <c:when test="${searchCharacter != null}">
                    <table class="characteroptionmenu" width="180">
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="character.jsp?character=${searchCharacter}"><fmt:message key="characterpage.menu.character"/> </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="characteroptionmenu">
                                <a href="mail.jsp?character=${searchCharacter}"><fmt:message key="characterpage.menu.mail"/> </a>
                            </td>
                        </tr>
                        <c:choose>
                            <c:when test="${race == myrace}">
                                <tr>
                                    <td class="characteroptionmenu">
                                        <a href="items.jsp?character=${searchCharacter}"><fmt:message key="characterpage.menu.items"/></a>
                                    </td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td class="characteroptionmenu">
                                        <a href="attack.jsp?character=${searchCharacter}"><fmt:message key="characterpage.menu.attack"/></a>
                                    </td>
                                </tr>
                            </c:otherwise>

                        </c:choose>

                    </table>
                </c:when>
            </c:choose>
        </td>
    </tr>
</table> 