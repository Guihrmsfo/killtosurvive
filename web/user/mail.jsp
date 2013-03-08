
<%-- Verificação das preferências do usuário--%>

<%@page import="objetos.Mensagem"%>
<%@page import="objetos.Usuario"%>
<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<%-- Verificação se está dentro dos padrões para entrar na página--%>

<c:choose>
    <c:when test="${sessionScope.usuario == null}">
        <%response.sendRedirect("../main.jsp");%>
    </c:when>

    <c:when test="${sessionScope.usuario.personagem == null}">
        <%response.sendRedirect("../create_character.jsp");%>
    </c:when>

</c:choose>

<c:if test="${param.delete != null}">
    <%ManipularDados.excluirMensagem(session.getAttribute("usuario"), Integer.parseInt(request.getParameter("delete")));%>
</c:if>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<html>
    
    <%-- Importação das imagens de ícone e logotipo--%>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
        <link rel="icon" type="image/x-icon" href="../imagens/icon.ico" />
        <link rel="shortcut icon" type="image/x-icon" href="../imagens/icon.ico"/>
        <link rel="stylesheet" type="text/css" href="../index.css">
        <link rel="stylesheet" type="text/css" href="../tables.css">
        <link rel="stylesheet" type="text/css" href="../character.css">
    </head>
    <body style="background-image: url(../imagens/bg3.png);">

        <c:if test="${param.message != null}">
            <%
                Mensagem msg = ((Usuario) session.getAttribute("usuario")).getPersonagem().getMensagem(Integer.parseInt(request.getParameter("message")));

                if (msg == null) {
                    response.sendRedirect("mail.jsp.jsp");
                } else {
                    pageContext.setAttribute("data", msg);
                    ManipularDados.setMensagemLida(session.getAttribute("usuario"), msg.getMensagemId());
                    session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));
                }%>

            <div class="box2">
                <div class="boxname2">
                    <p class="boxname2">
                        <b>${data.titulo}</b>
                    </p>
                </div>
                    
                    
                <div class="boxcontent2">
                    <b><fmt:message key="user.mailpage.text.from"/></b> 
                    <c:choose>
                        <c:when test="${fn:startsWith(data.personagemRemetente,'System')==true}">
                            <fmt:message key="system"/>
                        </c:when>

                        <c:otherwise>
                            ${data.personagemRemetente}
                        </c:otherwise>

                    </c:choose>
                    <hr>
                    <div class="messagecontent2">
                        ${data.texto}
                    </div>
                    <hr>
                    <div align="right">
                        <table>
                            <tr>
                                <td>
                                    <form method="post" action="mail.jsp">
                                        <input type="hidden" name="delete" value="${data.mensagemId}"/>
                                        <input type="submit" value="<fmt:message key="user.mailpage.text.delete"/>"/>
                                    </form>
                                </td>

                                <c:if test="${fn:startsWith(data.personagemRemetente,'System')!=true}">
                                    <td>
                                        <form method="get" action="../character/mail.jsp">
                                            <input type="hidden" name="character" value="${data.personagemRemetente}"/>
                                            <input type="submit" value="<fmt:message key="user.mailpage.text.answer"/>"/>
                                        </form>
                                    </td>
                                </c:if>

                                <td>
                                    <form action="mail.jsp">
                                        <input type="submit" value="<fmt:message key="user.mailpage.text.close"/>"/>
                                    </form>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>

    <center>
        <div class="usertopmenu" align="right">
            <h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true" message="${sessionScope.usuario.personagem.statusMensagemNova}"/> 
        </div>
        <br>
            <table border="1" width="800" class="main">
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
            
            
            <tr>
                <td valign="top" align="center" height="500"> 
                    <center>
                        <p class="title">
                            <fmt:message key="user.mailpage.text.mail"/>
                        </p>
                <table class="messages" border="1">

                    <tr>
                        <td class="messageindex" width="100">
                            <fmt:message key="user.mailpage.text.from"/>
                        </td>
                        
                        
                        <td class="messageindex" width="300">
                            <fmt:message key="user.mailpage.text.subject"/>
                        </td>
                        
                        
                        <td class="messageindex" width="100">
                            <fmt:message key="user.mailpage.text.status"/>
                        </td>
                    </tr>

                    <c:if test="${fn:length(sessionScope.usuario.personagem.mensagens)==0}">
                        <tr>
                            <td align="center" class="content1" colspan="3">
                                <fmt:message key="user.mailpage.text.nomessages"/>
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach items="${sessionScope.usuario.personagem.mensagens}" begin="0" step="1" var="msg" varStatus ="row">

                        <c:choose>
                            <c:when test="${row.count % 2 == 0}">
                                <c:set var="estiloLinha" value="content1" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="estiloLinha" value="content2" />
                            </c:otherwise>
                        </c:choose>

                        <tr>
                            <td class="${estiloLinha}">
                                <c:choose>
                                    <c:when test="${fn:startsWith(msg.personagemRemetente,'System')==true}">
                                        <fmt:message key="system"/>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="../character/character.jsp?character=${msg.personagemRemetente}">${msg.personagemRemetente}</a>
                                    </c:otherwise>
                                </c:choose>

                            </td>
                            
                            
                            <td class="${estiloLinha}">
                                <a href="mail.jsp?message=${msg.mensagemId}">${msg.titulo}</a>
                            </td>
                            
                            
                            <td class="${estiloLinha}">
                                <c:choose>
                                    <c:when test="${msg.lida == true}">
                                        <fmt:message key="user.mailpage.text.read"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="user.mailpage.text.unread"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </center>
            </td>
            </tr>
        </table>
    </center>        
</body>
</html>
