<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
    <head>
        <title>Password Recovery</title>
        <link  href='../styles.css' rel="stylesheet" />
    </head>
    <body>
        <div class="header">Budgeting.Com</div>
        <h2>Password Recovery</h2>    
        <s:form action="recoverpassword" >
            <s:textfield name="username" label="Username"  cssStyle="width:150px" />
            <s:submit value="Submit" />
        </s:form>
        <p/>
        <a href="../login.jsp">Login Page</a>
        <p/>
        <h4><s:property  value="message" /> </h4>
    </body>
</html>
