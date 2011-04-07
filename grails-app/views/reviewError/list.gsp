
<%@ page import="com.lightlooks.reviews.ReviewError" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'reviewError.label', default: 'ReviewError')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'reviewError.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'reviewError.code.label', default: 'Code')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'reviewError.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="lineNumber" title="${message(code: 'reviewError.lineNumber.label', default: 'Line Number')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${reviewErrorInstanceList}" status="i" var="reviewErrorInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${reviewErrorInstance.id}">${fieldValue(bean: reviewErrorInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: reviewErrorInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: reviewErrorInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: reviewErrorInstance, field: "lineNumber")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${reviewErrorInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
