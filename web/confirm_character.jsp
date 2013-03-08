
<%-- Verificação das preferências do usuário--%>

<%@page import="bdd.CriarObjeto"%>
<%@page import="dao.PersonagemDAO"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page import="objetos.PersonagemPadrao"%>
<%@page import="java.util.List"%>
<%@page import="dao.PersonagemPadraoDAO"%>
<%@page import="objetos.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />
<!DOCTYPE html>

<%-- Verificação se está dentro dos padrões para entrar na página--%>

<c:choose>

    <c:when test="${sessionScope.usuario == null}">
        <jsp:forward page="main.jsp"/>
    </c:when>

    <c:when test="${sessionScope.usuario.personagem != null}">
        <jsp:forward page="character.jsp"/>
    </c:when>

    <c:when test="${param.classe == null}">
        <jsp:forward page="create_character.jsp">
            <jsp:param name="error" value="0"/>
        </jsp:forward>

        <%--Escolha do nome do personagem--%>
        
    </c:when>

    <c:when test="${param.charactername == null || param.charactername == ''}">
        <jsp:forward page="create_character.jsp">
            <jsp:param name="error" value="1"/>
        </jsp:forward>
    </c:when>

        <%--Escolha do sexo do personagem--%>
    
    <c:when test="${param.sexo == null}">
        <jsp:forward page="create_character.jsp">
            <jsp:param name="error" value="2"/>
        </jsp:forward>
    </c:when>

        <%--Criação do personagem--%>
        
    <c:when test="${fn:contains(param.charactername, ' ') || fn:startsWith(param.charactername, 'System')}">
        <jsp:forward page="create_character.jsp">
            <jsp:param name="error" value="4"/>
        </jsp:forward>
    </c:when>

    <c:when test="${param.create == true}">
        <% if (CriarObjeto.criarPersonagem(request.getParameter("charactername"),
                    request.getParameter("usuario"),
                    Integer.parseInt(request.getParameter("classe")),
                    Integer.parseInt(request.getParameter("sexo")),
                    request.getParameter("imagem"))) {
                response.sendRedirect("intro.jsp");
                return;
            } else {
                response.sendRedirect("create_character.jsp");
            }
        %> 
    </c:when>
</c:choose>

<%
    PersonagemDAO dao = new PersonagemDAO();
    if (dao.consultarPorNome(request.getParameter("charactername")) != null) {
%>
<jsp:forward page="create_character.jsp">
    <jsp:param name="error" value="3"/>
</jsp:forward>
<%}%>

<% PersonagemPadraoDAO personagemPadrao = new PersonagemPadraoDAO();
    List<PersonagemPadrao> classes = personagemPadrao.findPersonagemPadraoEntities();
    PersonagemPadrao pp = new PersonagemPadrao();
    pp = classes.get(Integer.parseInt(request.getParameter("classe")));
    pageContext.setAttribute("classe", pp);
%>

<html lang="${language}">
    
    <%-- Importação das imagens de ícone e logotipo--%>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
        <link rel="icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="shortcut icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="stylesheet" type="text/css" href="tables.css">
    </head>
    <body>
        <div class="usertopmenu" align="right">
            <h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" message="" subpasta="false"/> 
        </div>
        <br>
    
    <center>
        <table border="1" width="800">
            <tr>
                <td colspan="2" align="center">
                    <img src="imagens/killtosurvive.gif" Width=400 Height=73 alt="Kill To Survive">
                </td>
            </tr>
            
            
            <tr>
                <td colspan="2" align="center">
                    <b><fmt:message key="create_character.text.topic"/></b>
                </td>
            </tr>
            
            
            <tr>
                <td>
                    <center> 
                    <br>
                
                <%-- Ínicio da tabela com conteúdo da página--%>
                
                <table class="characterchoose">
                    <tr>
                        <td colspan="2" class="character">${param.charactername}</td>
                    </tr>
                    
                    
                    <tr>

                        
                    <tr>
                        <td colspan="2" width="200">
                            <center>
                            <img src="imagens/classes/${pageScope.classe.especie}/${param.sexo}/${pageScope.classe.classe}.png" Width=180 Height=180 class="character" alt='<fmt:message key="${pageScope.classe.classe}"/>'>
                            </center>
                        </td>
                    </tr>
                            
                    
                    <tr>
                        <td class="topic">
                            <fmt:message key="raca"/>:
                        </td>
                        
                        
                        <td class="text1">
                            <b><fmt:message key="${pageScope.classe.especie}"/></b>
                        </td>
                    </tr>
                    
                    
                    <tr>
                                <td class="topic">
                                    <fmt:message key="classe"/>:
                                </td>
                                
                                
                                <td class="text1">
                                    <b><fmt:message key="${pageScope.classe.classe}"/></b>
                                </td>
                    </tr>
                            <tr>
                                <td class="topic">
                                    <fmt:message key="gender"/>:
                                </td>
                                
                                
                                <td class="text1">
                                    <b><fmt:message key="create_character.text.gender.${param.sexo}"/></b>
                                </td>
                            </tr>
                            
                            
                            <tr>
                                <td colspan="2" valign="top" width="150" height="80" class="text2" align="right">
                                    <fmt:message key="${pageScope.classe.classe}.descricao"/>.
                                </td>
                            </tr>
                            
                            
                            </tr>
                            
                            
                            <tr>
                                <td align="center" colspan="2" height="30" class="text3">
                                    <fmt:message key="confirm_character.text.confirm"/>
                                </td>
                            </tr>
                            
                            
                            <tr>
                                <td align="center" height="30">
                                    <FORM METHOD=POST ACTION="create_character.jsp">
                                        <input type="hidden" name="usuario" value="${sessioScope.usuario.usuario}">
                                        <input type="hidden" name="classe" value="${pageScope.classe.id}">
                                        <input type="hidden" name="charactername" value="${param.charactername}">
                                        <input type="hidden" name="sexo" value="${param.sexo}">
                                        <input type="submit" value="<fmt:message key="confirm_character.button.cancel"/>">
                                    </FORM>
                                </td>
                                
                                
                                <td align="center">
                                    <FORM METHOD=POST ACTION="confirm_character.jsp">
                                        <input type="hidden" name="create" value="true"/>
                                        <input type="hidden" name="usuario" value="${sessionScope.usuario.usuario}">
                                        <input type="hidden" name="classe" value="${pageScope.classe.id}">
                                        <input type="hidden" name="charactername" value="${param.charactername}">
                                        <input type="hidden" name="sexo" value="${param.sexo}">
                                        <input type="hidden" name="imagem" value="imagens/classes/${pageScope.classe.especie}/${param.sexo}/${pageScope.classe.classe}.png"/>
                                        <input type="submit" value="<fmt:message key="confirm_character.button.submit"/>">
                                    </FORM>
                                </td>
                            </tr>
                        </table>
                                    <%-- Fim da tabela com conteúdo da página--%>
                        <br>
                    </td>
                </tr>
            </center>
        </body>
</html>