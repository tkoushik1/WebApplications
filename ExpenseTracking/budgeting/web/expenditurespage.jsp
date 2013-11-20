<%@ taglib prefix="s" uri="/struts-tags" %>
<h2>Expenditures </h2>

<table border="1" width="100%">
    <tr class="bluewhite">
        <th>Date </th>
        <th>Description </th>
        <th>Category </th>
        <th>Amount </th>
        <th>&nbsp;</th>
    </tr>
    
<s:iterator value="expenditures" status="exp">
    <tr>
         <td><s:property value="date" /></td>
         <td><s:property value="category" /></td>
         <td><s:property value="description" /></td>
         <td style="text-align:right"><s:property value="amount" /></td>
         <td>
             <s:a action="deleteexpenditure?expid=%{expid}">Delete</s:a>
         </td>
    </tr>
 </s:iterator>

</table>


