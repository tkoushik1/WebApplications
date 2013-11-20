<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
    <head>
        <title>Login</title>
        <link  href='<s:url value="styles.css"/>' rel="stylesheet" />
    </head>

    <body>
        <div class="header">Budgeting.Com</div>
        <h2>Login </h2>    
        <s:form action="login" >
            <s:textfield name="username" label="Username" />
            <s:password  name="password" label="Password" />
            <s:submit value="Login" />
        </s:form>
        <p/>
        <a href="all/register.jsp">New User? Regiser! </a>
        <br/>
        <a href="all/recoverpassword.jsp">Forgot Password?</a>
        <p/>
        <div class="error"><s:actionerror   /> </div>
        
    </body>
</html>
