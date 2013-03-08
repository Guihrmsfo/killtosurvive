
<%-- Verificação das preferências do usuário--%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.text" />
<!DOCTYPE html>
<html lang="${language}">
    
    <%-- Importação das imagens de ícone e logotipo--%>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Kill To Survive</title>
        <link rel="icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="shortcut icon" href="imagens/icon.ico" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="index.css">
    </head>
    
    <%-- Importação das imagens de fundo--%>
    
    <body style="background-image: url(imagens/index_background.gif);"> 
        
        <form>
            <%-- Verificação das linguagem escolhida pelo usuário--%>
            
            <select id="language" name="language" onchange="submit()">
                <option value="en" ${language == 'en' ? 'selected' : ''}>English</option>
                <option value="pt_BR" ${language == 'pt_BR' ? 'selected' : ''}>Português (BR)</option>
            </select>
        </form>
            
    <center>
                    <%-- Ínicio da tabela com informação da página--%>
        <table>
            <tr>
                <td colspan=2 align="center">
                    <img src="imagens/killtosurvive.gif" Width=653 Height=120 alt="Kill To Survive">
                </td>
            </tr>
            
            
            <tr>
                <td colspan=2 Width=653 height=40 valign=top>
                    <center>
                        <a href="main.jsp"><fmt:message key="menu.text.welcome"/></a>
                        - <a href="register.jsp"><fmt:message key="register.text.topic"/></a>
                        - <a href="about.jsp"><fmt:message key="menu.text.about"/></a>
                    </center>
                </td>
            </tr>
            
            
            <tr>
                <td align="left">
                    <p align="center" class="maintext"> <b><fmt:message key="menu.text.about"/></b> <br><br>
                        <fmt:message key= "about.text.text1"/><br>
                        <fmt:message key= "about.text.text2"/><br>
                        <fmt:message key= "about.text.text3"/><br>
                        <fmt:message key= "about.text.text4"/><br><br>

                        <fmt:message key= "about.text.text5"/><br>
                        <fmt:message key= "about.text.text6"/><br>
                        <fmt:message key= "about.text.text7"/><br><br>

                        <fmt:message key= "about.text.text8"/><br>
                        <fmt:message key= "about.text.text9"/><br>
                        <fmt:message key= "about.text.text10"/><br>
                        <fmt:message key= "about.text.text11"/><br>
                    </p>
                </td>
            </tr>
        </table>
                    <%-- Fim da tabela com informação da página--%>
    </center>
</body>
</html>
