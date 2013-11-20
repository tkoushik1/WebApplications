<%@ taglib prefix="s" uri="/struts-tags" %>

<h2>Actuals Vs. Budget </h2>

<table border="1">
    <tr class="bluewhite">
        <th>Category </th>
        <th>Budget Amount </th>
        <th>Actual Amount </th>
    </tr>
    
<s:iterator value="expenditures">
    <tr>
         <td><s:property value="catname" /></td>
         <td style="text-align:right"><s:property value="budget" /></td>
         <td style="text-align:right">
             <s:if test="%{expenditure > budget}">
                <span style="color:red">
                    <s:property value="expenditure" />
                </span>
             </s:if>
             <s:else>
                 <s:property value="expenditure" />
             </s:else>
         </td>
    </tr>
 </s:iterator>

</table>