<%-- 
    Document   : validar_todas_contas
    Created on : 22/11/2012, 12:08:13
    Author     : Camila
--%>

<%@page import="objetos.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Validar Conta</title>
    </head>
    <body>
        <%

            UsuarioDAO usuarioDAO = new UsuarioDAO();

            List<Usuario> lista = usuarioDAO.findUsuarioEntities();

            for (int x = 0; x < lista.size(); x++) {

                if (lista.get(x).isValido() == false) {
                    Usuario u = lista.get(x);
                    u.setValido(true);

                    try {
                        usuarioDAO.save(u);
                    } catch (Exception ex) {
                    }
                }
            }

        %>
    </body>
</html>
