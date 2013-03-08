
<%@page import="bdd.ManipularDados"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@page language="java" contentType="text/html; charset=UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />

<%--Verifica se o usuário e a página estão nos padrões--%>

<c:choose>
    <c:when test="${sessionScope.usuario == null}">
        <%response.sendRedirect("../main.jsp");%>
    </c:when>

    <c:when test="${sessionScope.usuario.personagem == null}">
        <%response.sendRedirect("../create_character.jsp");%>
    </c:when>
    <c:when test="${sessionScope.usuario.personagem.missao != null}">
        <%response.sendRedirect("../character/mission.jsp");%>
    </c:when>
</c:choose>

<c:if test="${param.vida != null && param.moedas != null}">
    <%
        pageContext.setAttribute("result", ManipularDados.curarPersonagem(session.getAttribute("usuario"), Integer.parseInt(request.getParameter("vida")), Integer.parseInt(request.getParameter("moedas"))));
    %>
</c:if> 

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>


<!DOCTYPE html>
<html>
    <head>

        <style type="text/css">
            
            button{
                cursor:pointer;
                border: 0px none;
                background-color: transparent;
                padding: 0px 0px 0px 0px;
            }
            
            button.img{
                border: 0px none;
            }
            
        </style>

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
                
                <td colspan="4">
                    <center>
                        <img src="../imagens/killtosurvive.gif" Width=400 Height=73 alt="Kill To Survive">
                    </center>
                </td>
                
            </tr>
                    <tr>

                        <td colspan="4">
                            <h:gamemenu language="${language}"/>
                        </td>
                        
                    </tr>
      <!-- aqui começa a tabela com o conteúdo da página -->
            <tr>
                <td>
                    <center>
                        <table border="0">
                            

                <tr>
                    
                    <td rowspan=3 width=200 valign="top"> 
                        <div class="toppadding" align="center">
                            <img src="../imagens/outras/cruz.png" width=150 height=150/>
                        </div>
                    </td>
                    

                     <td colspan="4" width="600">
                        <p class="title" align="center">
                            <fmt:message key="hospital.text.title"/>
                        </p>
                     </td>
                      
                 </tr>
                 

                 <tr>
                     
                    <td colspan="3" align="center" valign="top">
                        <p class="text">
                            <c:if test="${pageScope.result != null}">
                            <b>${pageScope.result}</b>
                            </c:if>
                            <BR>
                            <fmt:message key="youhave"/> ${sessionScope.usuario.personagem.moedas} 
                            <img src="../imagens/outras/moeda.png" width="15" height="15" title="<fmt:message key="coins"/>"/>
                         </p>
                     </td>
                     
                  </tr>

                  
                <tr align="center">

                    <td>
                        <h:heal language="${language}" moedas="5" vida="10" imagem="../imagens/outras/remedio1.png"/>
                    </td>

                    
                    <td>
                        <h:heal language="${language}" moedas="7" vida="20" imagem="../imagens/outras/remedio2.png"/>
                    </td>
                    

                    <td>
                        <h:heal language="${language}" moedas="10" vida="30" imagem="../imagens/outras/remedio3.png"/>
                    </td>

                </tr>
                

                <tr align="center">

                        <td rowspan="4" align="center" valign="bottom">
                            <img src="../${sessionScope.usuario.personagem.linkImagemDePersonagemAleatorio}" width="190" height="250"/></center></TD>
                        </td>

                        <td>
                            <h:heal language="${language}" moedas="15" vida="50" imagem="../imagens/outras/remedio3.png"/>
                        </td>

                        <td>
                            <h:heal language="${language}" moedas="20" vida="75" imagem="../imagens/outras/remedio1.png"/>
                        </td>

                        <td>
                            <h:heal language="${language}" moedas="25" vida="100" imagem="../imagens/outras/remedio2.png"/>
                        </td>

                </tr>

                
                <tr>    
                    
                        <td colspan="3" align="center">
                            <div class="toppadding">
                                
                                <p class="text">
                                    <fmt:message key="hospital.text.yourhealth"/>
                                </p>
                                <div class="barradesaude">
                                    <img src="../${sessionScope.usuario.personagem.imagemSaude}" class="barradesaude" title="${sessionScope.usuario.personagem.saude}%"/>
                                </div> 
                                
                            </div>
                        </td>
                        
                </tr>


                <tr>

                        <td colspan=3 height="100" valign="bottom" align="center">
                            <div class="box1" width="80%" height="150px">
                                <div class="boxcontent1">
                                    <fmt:message key="hospital.text.description"/>
                                </div>
                            </div>
                        </td>
                        
                </tr>

                
                <tr>
                    
                        <td align="center" valign="bottom" colspan=3>
                            <form method="post" ACTION="map.jsp">
                                <center>
                                    <input type="submit" value='<fmt:message key="back2"/>'>
                                </center>                             
                            </form>
                        </td>
                        
                </tr>
                
                                        
                        </table>
                    </center>
                </td>
            </tr>
       <!-- acaba aqui a tabela com conteúdo da página --> 
            
            </table>
        </center>
    </body>
</html> 