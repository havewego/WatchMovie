package util;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MySendMail {
	 /** ������ */  
    public static String Sendfrom="18379522370@163.com";  
    /** ������ */  
    //private String to;  
    /** ���� */  
    public static String subject="ZMovie-��֤��";  
    /** ���� */  
    private String body;
    //�û������˻�-����������˻�
    public static final String userCount = "18379522370@163.com";
    //��½����
    public static final String password = "ll19970102";  
      /**  
         * �����ʼ�. 
         * @return boolean - ���ͽ��  true���ͳɹ� false����ʧ��
         */  
        public static boolean sendMail(String reciver,String checkId) {  
            
            try {  
                Properties props = new Properties();  
                props.put("username", userCount);   
                props.put("password", password);   
                //ָ���˿ڼ�Э��
                props.put("mail.transport.protocol", "smtp" );
                //ָ�����������õ���qq��
                props.put("mail.smtp.host", "smtp.163.com");  
                //props.put("mail.smtp.port", "25" );
                props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                props.setProperty("mail.smtp.port", "465");
                props.setProperty("mail.smtp.socketFactory.port", "465");
                Session mailSession = Session.getDefaultInstance(props);  
                Message msg = new MimeMessage(mailSession);
                msg.setFrom(new InternetAddress(Sendfrom));  
                msg.addRecipients(Message.RecipientType.TO, InternetAddress  
                        .parse(reciver));//����������
                msg.setSentDate(new Date());  
                msg.setSubject(subject);   
      
                msg.setText("ZMovie��֤��:"+checkId+"\n"+"��Ǳ��˲���������Դ���Ϣ"+"����֤����Чʱ��Ϊ3����"+"\n"+"-------����ZMovie"+"\n"+"���ʼ�Ϊϵͳ�ʼ�����ظ�");  
                msg.saveChanges();  
                System.out.println("�������ӷ�������������");  
                Transport transport = mailSession.getTransport("smtp");  
                transport.connect(props.getProperty("mail.smtp.host"), props  
                        .getProperty("username"), props.getProperty("password"));   
                  
                System.out.println("���ڷ����ʼ���������");  
                transport.sendMessage(msg, msg.getAllRecipients());  
                transport.close();
                System.out.println("������ϡ�������");  
            } catch (Exception e) {  
                e.printStackTrace();  
                System.out.println(e);  
                return false;  
            }  
            return true;  
        }
}

