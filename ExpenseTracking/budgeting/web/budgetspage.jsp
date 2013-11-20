<%@ taglib prefix="s" uri="/struts-tags" %>
<h2>Budgets </h2>

<table border="1">
    <tr class="bluewhite">
        <th>Category </th>
        <th>Amount </th>
    </tr>
    
<s:iterator value="budgets" status="budget">
    <tr>
         <td><s:property value="catname" /></td>
         <td style="text-align:right"><s:property value="amount" /></td>
    </tr>
 </s:iterator>

</table>


