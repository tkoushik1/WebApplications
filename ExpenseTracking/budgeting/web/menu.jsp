<%@taglib uri="/struts-tags" prefix="s"%>
<div class="menu">
User : [${sessionScope.username}]
&nbsp;
&nbsp;

<span style="float:right">
[<a href='home.action'>Home</a>]
&nbsp;
[<a href='changepassword.jsp'>Change Password</a>]
&nbsp;
[<a href='addbudgetform.action'>Add Budget</a>]
&nbsp;
[<a href='listbudgets.action'>List Budget</a>]
&nbsp;

&nbsp;
[<a href='addexpenditureform.action'>Add Expenditure</a>]
&nbsp;
[<a href='listexpenditures.action'>List Expenditures</a>]
&nbsp;
[<a href='logout.action'>Logout</a>]
</span>

</div>
