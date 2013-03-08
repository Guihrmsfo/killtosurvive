/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package email;

import java.util.Date;
import java.util.Locale;
import java.util.Properties;
import java.util.ResourceBundle;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import objetos.CodigoValidacao;
import objetos.Usuario;

/**
 *
 * @author Guilherme
 */
@Stateless
@LocalBean
public class EmailSessionBean {

    private int port = 465;
    private String host = "smtp.gmail.com";
    private String from = "killtosurvive.no.reply@gmail.com";
    private boolean auth = true;
    private String username = "killtosurvive.no.reply@gmail.com";
    private String password = "!ktsgame";
    private Protocol protocol = Protocol.SMTPS;
    private boolean debug = true;
    public static final int EMAILNORMAL = 0;
    public static final int EMAILVALIDAR = 1;
    private static ResourceBundle i18n;

    public boolean enviarEmail(String to, String subject, String body, int type, Usuario user) {

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        switch (protocol) {
            case SMTPS:
                props.put("mail.smtp.ssl.enable", true);
                break;
            case TLS:
                props.put("mail.smtp.starttls.enable", true);
                break;
        }

        Authenticator authenticator = null;
        if (auth) {
            props.put("mail.smtp.auth", true);
            authenticator = new Authenticator() {

                private PasswordAuthentication pa = new PasswordAuthentication(username, password);

                @Override
                public PasswordAuthentication getPasswordAuthentication() {
                    return pa;
                }
            };
        }

        Session session = Session.getInstance(props, authenticator);
        session.setDebug(debug);

        MimeMessage message = new MimeMessage(session);
        try {

            Locale local = new Locale(user.getIdioma());
            i18n = ResourceBundle.getBundle("i18n.text", local);

            message.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            message.setRecipients(Message.RecipientType.TO, address);
            message.setSubject(subject);
            message.setSentDate(new Date());

            if (type == EMAILNORMAL) {
                message.setText(body);
            } else {
                if (type == EMAILVALIDAR) {
                    message.setSubject(i18n.getString("email.text.title"));

                    CodigoValidacao codigo = new CodigoValidacao();
                    codigo.setUsuario(user.getUsuario());
                    String cod = codigo.gerarCodigoValidacao();
                    Multipart multipart = new MimeMultipart("alternative");
                    
                    final String SERVER = "killtosurvive.no-ip.org/killtosurviveweb/";
                    //final String SERVER = "localhost:8080/killtosurviveweb/";

                    MimeBodyPart htmlPart = new MimeBodyPart();
                    String htmlContent = "<BR>"
                            + i18n.getString("email.text.text1")
                            + "<br>"
                            + i18n.getString("email.text.text2")
                            + "<br>"
                            + i18n.getString("email.text.text3")
                            + "<br><br><p align=”Right”><a href=http://" + SERVER + "validar_conta.jsp?"
                            + "usuario=" + user.getUsuario()
                            + "&codigo=" + cod + "/>"
                            + i18n.getString("email.text.text4")
                            + "</a>";

                    htmlPart.setContent(htmlContent, "text/html");
                    multipart.addBodyPart(htmlPart);
                    message.setContent(multipart);
                }
            }

            Transport.send(message);
        } catch (MessagingException ex) {
            ex.printStackTrace();
            return false;
        }

        return true;
    }
}
