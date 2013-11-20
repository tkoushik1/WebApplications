<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
    <head>
        <title>Registration</title>
        <link  href='../styles.css' rel="stylesheet" />
    </head>

    <body>
        <div class="header">Budgeting.Com</div>
        <h2>Registration</h2>    
        <s:form action="register" >
            <s:textfield name="username" label="Username"  cssStyle="width:150px" />
            <s:password  name="password" label="Password"  cssStyle="width:150px"/>
            <s:password  name="confirmPassword" label="Confirm Password"  cssStyle="width:150px"/>
            <s:textfield  name="email" label="Email Address" cssStyle="width:150px" />
            <s:submit value="Register" />
        </s:form>
        <p/>
        <a href="../login.jsp">Login Page</a>
        <p/>
        <div class="error"><s:actionerror/> </div>
    </body>
</html>
