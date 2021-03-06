
<%@ page import="com.lightlooks.reviews.Review" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'review.label', default: 'Review')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'review.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="artefactName" title="${message(code: 'review.artefactName.label', default: 'Artefact Name')}" />
                        
                            <g:sortableColumn property="contact" title="${message(code: 'review.contact.label', default: 'Contact')}" />
                        
                            <g:sortableColumn property="dateRaised" title="${message(code: 'review.dateRaised.label', default: 'Date Raised')}" />
                        
<%--                            <g:sortableColumn property="signOffDate" title="${message(code: 'review.signOffDate.label', default: 'Sign Off Date')}" />--%>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${reviewInstanceList}" status="i" var="reviewInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${reviewInstance.id}">${fieldValue(bean: reviewInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: reviewInstance, field: "artefactName")}</td>
                        
                            <td>${fieldValue(bean: reviewInstance, field: "contact")}</td>
                        
                            <td><g:formatDate date="${reviewInstance.dateRaised}" /></td>
                        
<%--                            <td><g:formatDate date="${reviewInstance.signOffDate}" /></td>--%>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${reviewInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
