
<%-- Verificação das preferências do usuário--%>

<%@page import="objetos.Usuario"%>
<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<c:choose>
    <c:when test="${param.del == 'toconfirm'}">
        <div class="box2" style="height: 160px; right: 35%;top: 30%;">
            <div class="boxname2">
                <p class="boxname2">
                    <b>
                        <fmt:message key="preferences.text.deletechar"/> 
                    </b>
                </p>
            </div>
            <div class="boxcontent2" align="center">
                <fmt:message key="preferences.text.areyousureyouwanttodel"/> 
                <hr>
                <div align="right">
                    <table>
                        <tr>
                            <td>
                                <form action="preferences.jsp" method="post">
                                    <input type="hidden" name="del" value="del"/>
                                    <input type="submit" value='<fmt:message key="yes"/>'/>
                                </form>
                            </td>
                            <td>
                                <form action="preferences.jsp" method="post">
                                    <input type="hidden" name="del" value=""/>
                                    <input type="submit" value='<fmt:message key="no"/>'/>
                                </form>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </c:when>

    <c:when test="${param.del == 'del'}">
        <%
            pageContext.setAttribute("result", ManipularDados.deletarPersonagem((Usuario) session.getAttribute("usuario")));
        %>
    </c:when>

    <c:when test="${param.senha != null || param.newsenha !=null || param.newsenha2 != null}">
        <%
            pageContext.setAttribute("result", ManipularDados.mudarSenha((Usuario) session.getAttribute("usuario"),
                    request.getParameter("senha"),
                    request.getParameter("newsenha"),
                    request.getParameter("newsenha2")));
        %>
    </c:when>

    <c:when test="${param.language != null}">
        <%
            pageContext.setAttribute("result",
                    ManipularDados.trocarIdioma((Usuario) session.getAttribute("usuario"),
                    request.getParameter("language")));
        %>
    </c:when>

</c:choose>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<!DOCTYPE html>
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
    <body style="background-image: url(../imagens/bg4.png);">

    <center>
        <div class="usertopmenu" align="right">
            <h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true" message="${sessionScope.usuario.personagem.statusMensagemNova}"/> 
        </div>
        <br>
        
        <table border="1" width="800" class="main" >
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
                <td height="500" valign="top">
                    <center>
                
                <%-- Ínicio da tabela com conteúdo da página--%>
                
                <table>
                    <tr>
                        <td colspan="2" align="center">
                            <p class="title">
                                <fmt:message key="preferences.text.title"/>
                            </p>
                            <c:if test="${pageScope.result != null}">
                                ${pageScope.result}
                            </c:if>
                        </td>
                    </tr>
                    
                    
                    <tr>
                        <td align="center">
                            <br>
                            <br>
                            <fmt:message key="preferences.text.lang"/>
                        </td>
                        
                        
                        <td>
                            <br>
                            <br>
                            
                            <%-- Verificação do idioma que o usuário deseja--%>
                            
                            <form method="post" action="preferences.jsp">
                                <select name="language">
                                    <option value="en" ${sessionScope.usuario.idioma == 'en' ? 'selected' : ''}>English</option>
                                    <option value="pt_BR" ${sessionScope.usuario.idioma == 'pt_BR' ? 'selected' : ''}>Português</option>
                                </select>
                                <input type="submit" value="OK"/>
                            </form>
                        </td>
                    </tr>
                    <form action="preferences.jsp" method="post">
                        <tr>
                            <td align="center">
                                <BR>
                                <BR>
                                <fmt:message key="preferences.text.pass"/>
                            </td>
                            
                            
                            <td>
                                <BR>
                                <BR>
                                <input type="password" name="senha">
                            </td>
                        </tr>
                        
                        
                        <tr> 
                            
                            <%-- Mudança de senha do usuário--%>
                            
                            <td align="center">
                                <fmt:message key="preferences.text.newpass"/>
                            </td>
                            
                            
                            <td>
                                <input type="password" name="newsenha">
                            </td>
                        </tr>
                        
                        
                        <tr> 
                            <td align="center">
                                <fmt:message key="preferences.text.confirmpass"/>
                            </td>
                            
                            
                            <td>
                                <input type="password" name="newsenha2">
                            </td>
                        </tr>
                        
                        
                        <tr>
                            <td colspan="2" align="right">
                                <input type="submit" value='<fmt:message key="preferences.text.confirmchangepassword"/>'/>
                            </td>
                        <tr>
                    </form>
                    <tr>
                        <td align="center">
                            <BR>
                            <BR>
                            <fmt:message key="preferences.text.erase"/>
                        </td>
                        
                        
                        <td>
                            <BR>
                            <BR>
                            <form action="preferences.jsp" method="post">
                                <input type="hidden" name="del" value="toconfirm"/>
                                <input name="Erase" type="submit" value='<fmt:message key="preferences.text.erase"/>'/>
                            </form>
                        </td>
                    </tr>
                </table>
                            
             <%-- Fim da tabela com conteúdo da página--%>
                            
            </center>
            </td>
            </tr>
        </table>
    </center>
</body>
</html>