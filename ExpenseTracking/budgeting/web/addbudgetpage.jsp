<%@ taglib prefix="s" uri="/struts-tags" %>
<h2>Add Budget</h2>    
<s:form action="addbudget">
    <s:select  name="category" list="categories" listKey="catcode" listValue="catname"  label="Select Category" />
    <s:textfield name="month"  label="Month " cssStyle="width:100px" />
    <s:textfield name="year"  label="Year"   cssStyle="width:100px"/>
    <s:textfield name="amount"  label="Amount "   cssStyle="width:100px"/>
    <s:submit value="Add Budget" />
</s:form>
<p/>
<h4><s:property  value="message"/></h4>