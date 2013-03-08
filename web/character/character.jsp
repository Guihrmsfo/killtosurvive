<%-- 
    Document   : character
    Created on : 30/09/2012, 10:58:57
    Author     : Guilherme
--%>

<%@page import="objetos.Personagem"%>
<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page import="objetos.PersonagemPadrao"%>
<%@page import="java.util.List"%>
<%@page import="dao.PersonagemPadraoDAO"%>
<%@page import="objetos.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<c:choose>
    <c:when test="${sessionScope.usuario == null}">
        <%response.sendRedirect("../main.jsp");%>
    </c:when>

    <c:when test="${sessionScope.usuario.personagem == null}">
        <%response.sendRedirect("../create_character.jsp");%>
    </c:when>
</c:choose>

<% if (session.getAttribute("usuario") != null) {
        session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));
    }
%>

<c:choose>
    <c:when test="${param.character == null or param.character == '' or param.character == sessionScope.usuario.personagem.nome}">
        <% session.setAttribute("personagem", ((Usuario) session.getAttribute("usuario")).getPersonagem());%>
    </c:when>

    <c:when test="${param.character != null}">
        <% Personagem p = ManipularDados.getPersonagem(request.getParameter("character"));
            if (p != null) {
                session.setAttribute("personagem", p);
            } else {
                response.sendRedirect("character.jsp");
            }
        %>
    </c:when>
</c:choose>

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
    <body style="background-image: url(../imagens/bg4.png);">
    <center>
        <div class="usertopmenu" align="right"><h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true" message="${sessionScope.usuario.personagem.statusMensagemNova}"/> </div>
        <br>
        <table border="1" width="800" class="main" >
            <tr>
                <td>
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
                <td>
                    <table height="500">
                        <tr>
                            <td valign="top" align="right" width="200" height="170">
                                <h:optionmenucharacter imagem="${sessionScope.personagem.imagemurl}" myCharacter="${sessionScope.usuario.personagem.nome}" searchCharacter="${param.character}" race="${sessionScope.personagem.especie}" myrace="${sessionScope.usuario.personagem.especie}" language="${language}"/>
                            </td>
                            <td valign="top">          
                                <table>
                                    <td>
                                        <div class="padding">
                                            <div class="character">
                                                <div class="charactertitle">
                                                    <div class="charactername">${sessionScope.personagem.nome}</div>
                                                </div>

                                                <div class="characterdata">
                                                    <fmt:message key="${sessionScope.personagem.classe}.${sessionScope.personagem.sexo}"/>
                                                    <br>
                                                    <fmt:message key="${sessionScope.personagem.especie}.${sessionScope.personagem.sexo}"/>
                                                    <br>
                                                    <fmt:message key="characterpage.text.level"/>: ${sessionScope.personagem.nivel}  
                                                </div>
                                                <hr>
                                                <table>
                                                    <tr>
                                                        <td width="20">
                                                            <img src="../imagens/barra_saude/coracao.png" width="15" height="15" title="<fmt:message key="image.title.health"/>"/>
                                                        </td>
                                                        <td>
                                                            <div class="barradesaude"> <img src="../${sessionScope.personagem.imagemSaude}" class="barradesaude" title="${sessionScope.personagem.saude}%"/></div> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20">
                                                            <img src="../imagens/outras/moeda.png" width="15" height="15" title="<fmt:message key="image.title.money"/>"/>
                                                        </td>
                                                        <td>
                                                            <div class="characterdata">
                                                                ${sessionScope.personagem.moedas} <fmt:message key="characterpage.text.coins"/>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </div>
                                        </div>           

                                        <div class="padding">
                                            <div class="box1">
                                                <div class="boxname1">
                                                    <p class="boxname1">
                                                        <b><fmt:message key="characterpage.text.itens"/></b>
                                                    </p>
                                                </div>
                                                <div class="boxcontent1">
                                                    <c:choose>
                                                        <c:when test="${sessionScope.personagem.armaAtual != null}">
                                                            ${sessionScope.personagem.nome} <fmt:message key="characterpage.itens.weapon.${sessionScope.personagem.sexo}"/> <fmt:message key="${sessionScope.personagem.armaAtual.nome}"/>.
                                                        </c:when>

                                                        <c:when test="${sessionScope.personagem.armaAtual == null}">
                                                            <fmt:message key="characterpage.itens.noweapon1"/> ${sessionScope.personagem.nome} <fmt:message key="characterpage.itens.noweapon2.${sessionScope.personagem.sexo}"/>
                                                        </c:when>

                                                    </c:choose>
                                                    <br>
                                                    <c:choose>

                                                        <c:when test="${sessionScope.personagem.equipamentoAtual != null}">
                                                            <fmt:message key="characterpage.itens.equipment.${sessionScope.personagem.sexo}"/> <fmt:message key="${sessionScope.personagem.equipamentoAtual.nome}"/>.
                                                        </c:when>

                                                        <c:when test="${sessionScope.personagem.equipamentoAtual == null}">
                                                            <fmt:message key="characterpage.itens.noequipment.${sessionScope.personagem.sexo}"/>
                                                        </c:when>

                                                    </c:choose>

                                                </div>
                                            </div>
                                        </div>

                                    </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" align="center" width="180">
                    <div class="toppadding">
                        <img src="../imagens/simbolos/${sessionScope.personagem.especie}.png" width="180" height="180" title='<fmt:message key="${sessionScope.personagem.especie}.especie"/>'/>
                        <br>
                        <b>
                            <fmt:message key="${sessionScope.personagem.especie}.especie"/>
                        </b>
                    </div>
                    <div class="toppadding">
                        <img src="../${sessionScope.personagem.linkImagemDePersonagemAleatorio}" width="160" height="225" title='<fmt:message key="${sessionScope.personagem.especie}.especie"/>'/>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
</center>        
</body>
</html>
