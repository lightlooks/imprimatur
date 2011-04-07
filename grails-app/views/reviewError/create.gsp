

<%@ page import="com.lightlooks.reviews.ReviewError" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'reviewError.label', default: 'ReviewError')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${reviewErrorInstance}">
            <div class="errors">
                <g:renderErrors bean="${reviewErrorInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="code"><g:message code="reviewError.code.label" default="Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewErrorInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${reviewErrorInstance?.code}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="reviewError.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewErrorInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${reviewErrorInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lineNumber"><g:message code="reviewError.lineNumber.label" default="Line Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewErrorInstance, field: 'lineNumber', 'errors')}">
                                    <g:textField name="lineNumber" value="${fieldValue(bean: reviewErrorInstance, field: 'lineNumber')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
