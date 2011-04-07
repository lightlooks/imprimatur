
<%@ page import="com.lightlooks.reviews.Review" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'review.label', default: 'Review')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
       
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="review.artefactName.label" default="Review of..." /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: reviewInstance, field: "artefactName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="review.contact.label" default="Contact" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: reviewInstance, field: "contact")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="review.dateRaised.label" default="Date Raised" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${reviewInstance?.dateRaised}" /></td>
                            
                        </tr>
                    
                       <tr class="prop">
                       	<td colspan="2">
                       	<em>Errors</em>
                       	<table>
                       		<thead>
                       			<tr><td>Line number</td><td>Code</td><td>Error text</td></tr>
                       		</thead>
                       		<tbody>
                       			<g:each in="${reviewInstance.reviewErrors}" var="r">
                       				<tr><td>${fieldValue(bean: r, field: "lineNumber") }</td>
                       				<td><stdslink:link type="xsd" code="${r.code}" /></td>
                       				<td>${fieldValue(bean: r, field: "description") }</td>
                       				</tr>
                       			</g:each>
                       		</tbody>
                       	</table>
                       	</td>
                       </tr>
                       
                       <tr class="prop">
                       	<td colspan="2">
                       	<em>Warnings</em>
                       	<table>
                       		<thead>
                       			<tr><td>Line number</td><td>Code</td><td>Error text</td></tr>
                       		</thead>
                       		<tbody>
                       			<g:each in="${reviewInstance.reviewWarnings}" var="r">
                       				<tr><td>${fieldValue(bean: r, field: "lineNumber") }</td>
                       				<td><stdslink:link type="xsd" code="${r.code}" /></td> 
                       				<td>${fieldValue(bean: r, field: "description") }</td>
                       				</tr>
                       			</g:each>
                       		</tbody>
                       	</table>
                       	</td>
                       </tr>


				<g:each in="${reviewInstance?.signoffs}" var="s">
				 <tr class="prop">
                            <td valign="top" class="name"><g:message code="review.signOffDate.label" default="Sign Off Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${s?.dateTimeSignedOff}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="review.signOffPerson.label" default="Sign Off Person" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: s, field: "username")}</td>
                            
                        </tr>
                        
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="review.signOffPerson.label" default="Sign Off Comment" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: s, field: "comment")}</td>
                            
                        </tr>
                        
				
				</g:each>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${reviewInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                	<span class="button"><g:actionSubmit class="edit" action="signoff" value="${message(code: 'signoff.button.label', default: 'Sign off')}" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
