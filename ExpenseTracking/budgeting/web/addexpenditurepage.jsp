<%@ taglib prefix="s" uri="/struts-tags" %>
<h2>Add Expenditure</h2>    
<s:form action="addexpenditure">
    <s:select  name="category" list="categories" listKey="catcode" listValue="catname"  label="Select Category" />
    <s:textarea  name="description"  label="Description" cssStyle="width:200px" rows="2" />
    <s:textfield name="date"  label="Date"   cssStyle="width:100px"/>
    <s:textfield name="amount"  label="Amount "   cssStyle="width:100px"/>
    <s:submit value="Add Expenditure" />
</s:form>
<p/>
<h4><s:property  value="message"/></h4>