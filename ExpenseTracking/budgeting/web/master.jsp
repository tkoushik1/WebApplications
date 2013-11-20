<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><tiles:insertAttribute name="title" ignore="true" /></title>
        <link  href="styles.css" rel="stylesheet" />
    </head>
    <body>
    <div class="header">Budgeting.Com</div>
    <tiles:insertAttribute name="menu" />
    <tiles:insertAttribute name="body" />
</body>
</html>