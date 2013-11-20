<%@ taglib prefix="s" uri="/struts-tags" %>
<h2>Change Password</h2>    
<s:form action="changepassword" namespace="/">
    <s:password  name="password" label="Old Password"  cssStyle="width:150px"/>
    <s:password  name="newpassword" label="New Password"  cssStyle="width:150px"/>
    <s:password  name="confirmPassword" label="Confirm Password"  cssStyle="width:150px"/>
    <s:submit value="Change Password" />
</s:form>
<p/>
<h4><s:property  value="message"/></h4>