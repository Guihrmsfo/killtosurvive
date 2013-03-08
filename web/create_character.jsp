
<%-- Verificação das preferências do usuário--%>

<%@page import="bdd.ManipularDados"%>
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

<c:if test="${sessionScope.usuario == null}">
    <%response.sendRedirect("main.jsp");%>
</c:if>

<c:if test="${sessionScope.usuario.personagem != null}">
    <%response.sendRedirect("character/character.jsp");%>
</c:if>

<%
    pageContext.setAttribute("classes", ManipularDados.getListaDeClassesDoJogo());
%>

<html lang="${language}">
    <head>
        
        <%-- Importação das imagens de ícone e logotipo--%>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
        <link rel="icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="shortcut icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="stylesheet" type="text/css" href="tables.css">
    </head>
    <body>
        <center>     
            <div class="usertopmenu" align="right">
                <h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" message="" subpasta="false"/> 
            </div>
        <br>
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
                        <table>
                    
                    <%-- Ínicio da tabela com conteúdo da página--%>
                    
                    <tr>
                        <td align="center" colspan="3">
                            <b><fmt:message key="create_character.text.charactername"/></b>
                            <br>
                            <form method="post" action="confirm_character.jsp">
                                <INPUT TYPE=text NAME="charactername" SIZE=30 value="${param.charactername}">
                        </td>
                    </tr>

                                <c:if test="${param.error!=null}">

                                    <tr>
                                        <td align="center" colspan="3">
                                            <font size="2" color="red">
                                            <b>
                                                
                                                <%-- Verificação de possíveis erros no cadastro--%>
                                                
                                                <c:choose>
                                                    <c:when test="${param.error=='0'}">
                                                        <fmt:message key="create_character.error.class"/>  
                                                    </c:when>
                                                    <c:when test="${param.error=='1'}">
                                                        <fmt:message key="create_character.error.nameempty"/>  
                                                    </c:when>
                                                    <c:when test="${param.error=='2'}">
                                                        <fmt:message key="create_character.error.gender"/>  
                                                    </c:when>
                                                    <c:when test="${param.error=='3'}">
                                                        <fmt:message key="create_character.error.name"/>  
                                                    </c:when>
                                                    <c:when test="${param.error=='4'}">
                                                        <fmt:message key="create_character.error.nameinvalid"/>  
                                                    </c:when>
                                                    <c:when test="${param.error=='5'}">
                                                        <fmt:message key="create_character.error.error"/>  
                                                    </c:when>
                                                </c:choose>

                                            </b>
                                            </font>
                                        </td>
                                    </tr>
                                </c:if>  
                                <tr>
                                    <td colspan="3">
                                        <hr>
                                    </td>
                                </tr>   
                                
                                
                                <tr>
                                    
                                    <%-- Escolha do sexo do personagem--%>
                                    
                                    <td align="center" colspan="3">
                                        <b>
                                            <fmt:message key="create_character.text.gender"/>
                                        </b>
                                        <c:choose>
                                            <c:when test="${param.sexo=='0'}">
                                                <input type="radio" name="sexo" value="0" checked/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="radio" name="sexo" value="0"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <fmt:message key="create_character.text.gender.0"/>
                                        <c:choose>
                                            <c:when test="${param.sexo=='1'}">
                                                <input type="radio" name="sexo" value="1" checked/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="radio" name="sexo" value="1"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <fmt:message key="create_character.text.gender.1"/>
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td colspan="3">
                                        <hr>
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td align="center" colspan="3"><b>
                                            <fmt:message key="create_character.text.choosecharacter"/></b>
                                    </td>
                                </tr>

                                <%-- Escolha da classe do personagem--%>
                                
                                <c:forEach items="${pageScope.classes}" begin="0"  step="1" var="classe" varStatus ="row">
                                    <c:set var="y" value="${row.count % 3}" scope="page"/>

                                    <c:if test="${y == 1}">
                                        <tr>
                                        </c:if>

                                        <td class="characterchoose">
                                            <center>
                                        <table class="characterchoose">

                                            <tr>
                                                <td colspan="2" class="character">
                                                    <b><fmt:message key="${classe.classe}"/></b>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2" width="200">
                                                    <button type="submit" name="classe" value="${row.count - 1}">
                                                        <img src="imagens/classes/${classe.especie}/0/${classe.classe}.png" Width=180 Height=180 class="character" alt='<fmt:message key="${classe.classe}"/>'/>
                                                    </button>
                                                </td>
                                            </tr>
                                            
                                            
                                            <tr>
                                                 <%-- Escolha da raça do personagem--%>
                                                
                                                <td class="topic">
                                                    <fmt:message key="raca"/>:
                                                </td>
                                                
                                                
                                                <td class="text1">
                                                    <b><fmt:message key="${classe.especie}"/></b>
                                                </td>
                                            </tr>
                                            
                                            
                                            <tr>
                                                <td class="topic">
                                                    <fmt:message key="classe"/>:
                                                </td>
                                                
                                                
                                                <td class="text1">
                                                    <b><fmt:message key="${classe.classe}"/></b>
                                                </td>
                                            </tr>
                                            
                                            
                                            <tr>
                                                <td colspan="2" valign="top" width="150" height="80" align="right" class="text2">
                                                    <fmt:message key="${classe.classe}.descricao"/>.
                                                </td>
                                            </tr>
                                        </table>
                                    
                                    </center>
                            </td>

                            <c:choose>
                                <c:when test="${y == 3}">
                                </tr>
                            </c:when>
                            <c:when test="${fn:length(classes)==row.count}">
                                </tr>
                            </c:when>
                        </c:choose>

                    </c:forEach>
                    </form>
                </table>
                                
                  <%-- Fim da tabela com conteúdo da página--%>
                                
            </center>
            </td>
            </tr>
        </table>
    </center>
</body>
</html>
