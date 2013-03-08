
<%@page import="objetos.*"%>
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



<c:choose>

    <c:when test="${param.changeItem == null}">
        <%
            pageContext.setAttribute("number", 0);
            pageContext.setAttribute("kind", "weapon");
            pageContext.setAttribute("item", ManipularDados.getArmaDaListaDeArmas(0));
        %>
    </c:when>

    <c:when test="${param.changeItem == '+'}">
        <%
            if (request.getParameter("kind").equals("weapon")) {
                int x = Integer.parseInt(request.getParameter("number")) + 1;
                if (ManipularDados.getListaArmas().size() <= x) {
                    x = 0;
                }

                pageContext.setAttribute("number", x);
                pageContext.setAttribute("kind", "weapon");
                pageContext.setAttribute("item", ManipularDados.getArmaDaListaDeArmas(x));
            } else {

                int x = Integer.parseInt(request.getParameter("number")) + 1;
                if (ManipularDados.getListaEquipamentos().size() <= x) {
                    x = 0;
                }

                pageContext.setAttribute("number", x);
                pageContext.setAttribute("kind", "equipment");
                pageContext.setAttribute("item", ManipularDados.getEquipamentoDaListaDeEquipamentos(x));

            }
        %>
    </c:when>

    <c:when test="${param.changeItem == '-'}">
        <%
            if (request.getParameter("kind").equals("weapon")) {
                int x = Integer.parseInt(request.getParameter("number")) - 1;
                if (x < 0) {
                    x = ManipularDados.getListaArmas().size() - 1;
                }

                pageContext.setAttribute("number", x);
                pageContext.setAttribute("kind", "weapon");
                pageContext.setAttribute("item", ManipularDados.getArmaDaListaDeArmas(x));
            } else {

                int x = Integer.parseInt(request.getParameter("number")) - 1;
                if (x < 0) {
                    x = ManipularDados.getListaEquipamentos().size() - 1;
                }

                pageContext.setAttribute("number", x);
                pageContext.setAttribute("kind", "equipment");
                pageContext.setAttribute("item", ManipularDados.getEquipamentoDaListaDeEquipamentos(x));

            }
        %>
    </c:when>

    <c:when test="${param.changeItem == '0'}">
        <%
            if (request.getParameter("kind").equals("weapon")) {
                int x = Integer.parseInt(request.getParameter("number"));

                pageContext.setAttribute("number", x);
                pageContext.setAttribute("kind", "weapon");
                pageContext.setAttribute("item", ManipularDados.getArmaDaListaDeArmas(x));
            } else {

                int x = Integer.parseInt(request.getParameter("number"));

                pageContext.setAttribute("number", x);
                pageContext.setAttribute("kind", "equipment");
                pageContext.setAttribute("item", ManipularDados.getEquipamentoDaListaDeEquipamentos(x));

            }
        %>
    </c:when>
</c:choose>

<c:choose>
    <c:when test="${param.buy == 'confirm'}">

        <div class="box2" style=" right: 35%;top: 30%;">
            <div class="boxname2">
                <p class="boxname2">
                    <b>
                        <fmt:message key="buy"/> <fmt:message key="${pageScope.kind}"/>
                    </b>
                </p>
            </div>
            <div class="boxcontent2" align="center">
                <fmt:message key="armament.result.areyousure"/><br>
                <img width="100" height="100" src="../${pageScope.item.imagem}"/><br>
                <fmt:message key="${pageScope.item.nome}"/><BR>
                <c:choose>
                    <c:when test="${pageScope.kind == 'weapon'}">
                        <fmt:message key="weaponattack"/> ${pageScope.item.ataque}
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="equipmentdefense"/> ${pageScope.item.defesa}
                    </c:otherwise>
                </c:choose>
                <BR>
                <font color = yellow>
                ${pageScope.item.preco} <fmt:message key="coins"/>
                </font>
                <hr>
                <div align="right">
                    <table>
                        <tr>
                            <td>
                                <form action="armamento.jsp" method="post">
                                    <input type="hidden" name="changeItem" value="0"/>
                                    <input type="hidden" name="kind" value="${pageScope.kind}"/>
                                    <input type="hidden" name="number" value="${pageScope.number}"/>
                                    <input type="hidden" name="buy" value="buy"/>
                                    <input type="hidden" name="name" value="${pageScope.item.nome}"/>
                                    <input type="submit" value='<fmt:message key="yes"/>'/>
                                </form>
                            </td>
                            
                            
                            <td>
                                <form action="armamento.jsp" method="post">
                                    <input type="hidden" name="changeItem" value="0"/>
                                    <input type="hidden" name="kind" value="${pageScope.kind}"/>
                                    <input type="hidden" name="number" value="${pageScope.number}"/>
                                    <input type="hidden" name="buy" value=""/>
                                    <input type="hidden" name="name" value="${pageScope.item.nome}"/>
                                    <input type="submit" value='<fmt:message key="no"/>'/>
                                </form>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${param.buy == 'buy'}">
        <%
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            if (request.getParameter("kind").equals("weapon")) {
                Arma arma = (Arma) pageContext.getAttribute("item");
                pageContext.setAttribute("result", ManipularDados.comprarArma(usuario, arma.getNome()));
            } else {
                Equipamento equipamento = (Equipamento) pageContext.getAttribute("item");
                pageContext.setAttribute("result", ManipularDados.comprarEquipamento(usuario, equipamento.getNome()));
            }
        %>
    </c:when>
</c:choose>

<%session.setAttribute("usuario", ManipularDados.atualizarUsuario(session.getAttribute("usuario")));%>

<!DOCTYPE html>
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

    <body style="background-image: url(../imagens/bg.png);">

    <center>
        <div class="usertopmenu" align="right">
            <h:usertopmenu language="${language}" usuario="${sessionScope.usuario.usuario}" subpasta="true" 
                       message="${sessionScope.usuario.personagem.statusMensagemNova}"/> 
        </div>
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

            <!-- aqui começa a tabela com conteúdo da página -->

                <tr>
                    <td>
                        <center>
                            <table border="0">

                        <tr>

                            <td rowspan=5 width=200 valign="top">
                                <div class="toppadding">
                                    <center>
                                        <img src="../imagens/outras/alvo.png" width=150 height=150>
                                    </center>
                                </div> 
                            </td>

                            
                            <td colspan="4" width="600">
                                <p class="title" align="center">
                                    <fmt:message key="armament.text.title"/>
                                </p>
                            </td>

                        </tr>

                        <td colspan="4" align="center" valign="top">
                            
                            <p class="text">
                                <c:if test="${pageScope.result != null}">
                                    <b>${pageScope.result}</b>
                                    <br>
                                </c:if>
                                    <fmt:message key="youhave"/> ${sessionScope.usuario.personagem.moedas} 
                                    <img src="../imagens/outras/moeda.png" width="15" height="15" title="<fmt:message key="coins"/>"/>
                            </p>
                            
                        </td>

                        </tr>

                        
                        <tr>
                            
                            <td width="200"></td>
                            
                            <td align="center" colspan="2" width="200">
                                <b><fmt:message key="buy"/></b>
                            </td>
                            <td width="200"></td>
                            
                        </tr>

                        
                        <tr>
                        
                            <td align="center" width="100">
                                
                                <form action="armamento.jsp" method="post">
                                    <input type="hidden" name="kind" value="weapon"/>
                                    <input type="hidden" name="changeItem" value="0"/>
                                    <input type="hidden" name="number" value="0"/>
                                    <input type="submit" value='<fmt:message key="weapon"/>' style="width: 90px;"/>
                                </form>

                            </td>

                            <td align="center" width="100">
                                <form action="armamento.jsp" method="post">
                                    <input type="hidden" name="kind" value="equipment"/>
                                    <input type="hidden" name="changeItem" value="0"/>
                                    <input type="hidden" name="number" value="0"/>
                                    <input type="submit" value='<fmt:message key="equipment"/>' style="width: 90px;"/>
                                </form>
                                
                            </td>
                        
                        </tr>

                    
                        <tr align="center">

                            <td align="right"> 
                                <form ACTION="armamento.jsp" method="post">
                                    <input type="hidden" name="changeItem" value="-"/>
                                    <input type="hidden" name="kind" value="${pageScope.kind}"/>
                                    <input type="hidden" name="number" value="${pageScope.number}"/>
                                    <button type="submit">
                                        <img src="../imagens/outras/setaesquerda.png" width="50" height="50"/>
                                    </button>
                                </form>
                            </td>

                        <td colspan="2">
                            <div clas="toppadding">
                                <form ACTION="armamento.jsp" method="post">
                                    <input type="hidden" name="changeItem" value="0"/>
                                    <input type="hidden" name="kind" value="${pageScope.kind}"/>
                                    <input type="hidden" name="number" value="${pageScope.number}"/>
                                    <input type="hidden" name="buy" value="confirm"/>
                                    <input type="hidden" name="name" value="${pageScope.item.nome}"/>
                                    <button type="submit">
                                        <img width="100" height="100" src="../${pageScope.item.imagem}"/>
                                    </button>
                                </form>

                                <fmt:message key="${pageScope.item.nome}"/><BR>
                                <c:choose>
                                    <c:when test="${pageScope.kind == 'weapon'}">
                                        <fmt:message key="weaponattack"/> ${pageScope.item.ataque}
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="equipmentdefense"/> ${pageScope.item.defesa}
                                    </c:otherwise>
                                </c:choose>
                                <BR>
                                <font color="red"><fmt:message key="premium"/></font> 
                                <c:choose>
                                    <c:when test="${pageScope.item.premium == true}">
                                        <fmt:message key="yes"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="no"/>
                                    </c:otherwise>
                                </c:choose>
                                <BR>
                                <font color = yellow>${pageScope.item.preco} <fmt:message key="coins"/> </font>
                            </div>
                        </td>

                        <td align="left"> 
                            <form ACTION="armamento.jsp" method="post">
                                <input type="hidden" name="changeItem" value="+"/>
                                <input type="hidden" name="kind" value="${pageScope.kind}"/>
                                <input type="hidden" name="number" value="${pageScope.number}"/>
                                <button type="submit">
                                    <img src="../imagens/outras/setadireita.png" width="50" height="50"/>
                                </button>
                            </form>
                        </td>

                    </tr>

                    <tr>
                        <td>
                    <center>
                        <img src="../imagens/classes/especie_ashen/0/classe_soldado.png" width=100 height=150/>
                    </center>
                    </td>

                    <td colspan=4 valign="middle" align="center"> 
                        <div class="box1" width="80%"> 
                            <div class="boxcontent1">
                                <fmt:message key="armament.text.description"/>
                            </div>
                        </div>

                        <div valign="bottom" style="padding-top: 10px;">
                            <form method="post" ACTION="map.jsp" style="padding-bottom: 10px;">
                                <center>
                                    <input type="submit" value='<fmt:message key="back2"/>'>
                                </center>                             
                            </form>      
                        </div>
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


