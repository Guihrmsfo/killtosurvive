<%-- 
    Document   : validar_conta
    Created on : 30/08/2012, 21:20:31
    Author     : Guilherme
--%>

<%@page import="dao.UsuarioDAO"%>
<%@page import="objetos.Usuario"%>
<%@page import="objetos.CodigoValidacao"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kill To Survive</title>
        <link rel="icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="shortcut icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="stylesheet" type="text/css" href="tables.css">
    </head>
    <body>

        <form>
            <select id="language" name="language" onchange="submit()">
                <option value="en" ${language == 'en' ? 'selected' : ''}>English</option>
                <option value="pt_BR" ${language == 'pt_BR' ? 'selected' : ''}>Português (BR)</option>
            </select>

        </form>
    <center>
        <table border=0>
            <tr>
                <td>
                    <img src="imagens/killtosurvive.gif" Width=653 Height=120 alt="Kill To Survive">
                </td>
            </tr>
            <tr><td height=40 valign=top>
            <center>
                <a href="main.jsp"><fmt:message key="menu.text.welcome"/></a>
                - <a href="register.jsp"><fmt:message key="register.text.topic"/></a>
                - <a href="about.jsp"><fmt:message key="menu.text.about"/></a>
            </center>
            </td>
            </tr>
            <tr><td>
            <center>

                <%

                    if (request.getParameter("usuario") == null
                            || request.getParameter("codigo") == null) {

                %>

                <table>
                    <FORM METHOD=POST ACTION="validar_conta.jsp">
                        <tr><td colspan="2" align="center"><b><fmt:message key="validarcontat.text.validar"/></b></td></tr>
                        <tr>
                            <td align="right"><fmt:message key="validarcontat.text.usuario"/></td>
                            <td align="left"><input type="text" name="usuario" size="25"/></td>
                        </tr>
                        <tr>
                            <td align="right"><fmt:message key="validarcontat.text.codigo"/></td>
                            <td align="left"><input type="text" name="codigo" size="25"/></td>
                        </tr>
                        <tr><td colspan="2" align="right"><input type="submit" value="Confirmar" /></td></tr>
                    </form>
                </table>

                <%                } else {
                    CodigoValidacao codigo = new CodigoValidacao();
                    codigo.setCodigo(request.getParameter("codigo"));
                    codigo.setUsuario(request.getParameter("usuario"));
                    codigo.corrigirUrlParaUsuario();

                    if (codigo.getUsuarioFromDAO().isValido()) {
                %>
                <fmt:message key="validarcontat.text.jafoivalidado"/>
                <%                        } else {

                    if (codigo.verificarCodigoValidacao()) {
                        Usuario user = codigo.getUsuarioFromDAO();
                        user.validarUsuario();
                        UsuarioDAO dao = new UsuarioDAO();
                        dao.save(user);

                %>
                <fmt:message key="validarcontat.text.validada"/>        
                <%                } else {
                %>
                <fmt:message key="validarcontat.error.invalido"/>   
                <%                        }

                        }
                    }
                %>

            </center>

            </td>
            </tr>
        </table>
    </body>
</html>
