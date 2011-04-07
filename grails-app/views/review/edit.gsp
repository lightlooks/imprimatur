

<%@ page import="com.lightlooks.reviews.Review" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'review.label', default: 'Review')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${reviewInstance}">
            <div class="errors">
                <g:renderErrors bean="${reviewInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${reviewInstance?.id}" />
                <g:hiddenField name="version" value="${reviewInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
<%--                            <tr class="prop">--%>
<%--                                <td valign="top" class="name">--%>
<%--                                  <label for="artefactHash"><g:message code="review.artefactHash.label" default="Artefact Hash" /></label>--%>
<%--                                </td>--%>
<%--                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'artefactHash', 'errors')}">--%>
<%--                                    <g:textField name="artefactHash" value="${reviewInstance?.artefactHash}" />--%>
<%--                                </td>--%>
<%--                            </tr>--%>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="artefactName"><g:message code="review.artefactName.label" default="Artefact Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'artefactName', 'errors')}">
                                    <g:textField name="artefactName" value="${reviewInstance?.artefactName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contact"><g:message code="review.contact.label" default="Contact" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'contact', 'errors')}">
                                    <g:textField name="contact" value="${reviewInstance?.contact}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateRaised"><g:message code="review.dateRaised.label" default="Date Raised" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'dateRaised', 'errors')}">
                                    <g:datePicker name="dateRaised" precision="day" value="${reviewInstance?.dateRaised}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reviewErrors"><g:message code="review.reviewErrors.label" default="Review Errors" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'reviewErrors', 'errors')}">
                                    <g:select name="reviewErrors" from="${com.lightlooks.reviews.ReviewError.list()}" multiple="yes" optionKey="id" size="5" value="${reviewInstance?.reviewErrors*.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reviewWarnings"><g:message code="review.reviewWarnings.label" default="Review Warnings" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'reviewWarnings', 'errors')}">
                                    <g:select name="reviewWarnings" from="${com.lightlooks.reviews.Warning.list()}" multiple="yes" optionKey="id" size="5" value="${reviewInstance?.reviewWarnings*.id}" />
                                </td>
                            </tr>
                        
<%--                            <tr class="prop">--%>
<%--                                <td valign="top" class="name">--%>
<%--                                  <label for="signOffDate"><g:message code="review.signOffDate.label" default="Sign Off Date" /></label>--%>
<%--                                </td>--%>
<%--                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'signOffDate', 'errors')}">--%>
<%--                                    <g:datePicker name="signOffDate" precision="day" value="${reviewInstance?.signOffDate}"  />--%>
<%--                                </td>--%>
<%--                            </tr>--%>
                        
<%--                            <tr class="prop">--%>
<%--                                <td valign="top" class="name">--%>
<%--                                  <label for="signOffPerson"><g:message code="review.signOffPerson.label" default="Sign Off Person" /></label>--%>
<%--                                </td>--%>
<%--                                <td valign="top" class="value ${hasErrors(bean: reviewInstance, field: 'signOffPerson', 'errors')}">--%>
<%--                                    <g:textField name="signOffPerson" value="${reviewInstance?.signOffPerson}" />--%>
<%--                                </td>--%>
<%--                            </tr>--%>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
