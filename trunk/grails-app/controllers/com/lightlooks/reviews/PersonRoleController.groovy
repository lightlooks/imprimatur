package com.lightlooks.reviews

class PersonRoleController {

	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [personRoleInstanceList: PersonRole.list(params), personRoleInstanceTotal: PersonRole.count()]
    }

    def create = {
        def personRoleInstance = new PersonRole()
        personRoleInstance.properties = params
        return [personRoleInstance: personRoleInstance]
    }

    def save = {
        def personRoleInstance = new PersonRole(params)
        if (personRoleInstance.save(flush: true)) {
			if(springSecurityService.loggedIn && springSecurityService.principal.id == personRoleInstance.person.id){
				springSecurityService.reauthenticate springSecurityService.principal.username
			}
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'personRole.label', default: 'PersonRole'), personRoleInstance.id])}"
            redirect(action: "show", id: personRoleInstance.id)
        }
        else {
            render(view: "create", model: [personRoleInstance: personRoleInstance])
        }
    }

    def show = {
        def personRoleInstance = PersonRole.get(params.id)
        if (!personRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'personRole.label', default: 'PersonRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            [personRoleInstance: personRoleInstance]
        }
    }

    def edit = {
        def personRoleInstance = PersonRole.get(params.id)
        if (!personRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'personRole.label', default: 'PersonRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [personRoleInstance: personRoleInstance]
        }
    }

    def update = {
        def personRoleInstance = PersonRole.get(params.id)
        if (personRoleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (personRoleInstance.version > version) {
                    
                    personRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'personRole.label', default: 'PersonRole')] as Object[], "Another user has updated this PersonRole while you were editing")
                    render(view: "edit", model: [personRoleInstance: personRoleInstance])
                    return
                }
            }
            personRoleInstance.properties = params
            if (!personRoleInstance.hasErrors() && personRoleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'personRole.label', default: 'PersonRole'), personRoleInstance.id])}"
                redirect(action: "show", id: personRoleInstance.id)
            }
            else {
                render(view: "edit", model: [personRoleInstance: personRoleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'personRole.label', default: 'PersonRole'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def personRoleInstance = PersonRole.get(params.id)
        if (personRoleInstance) {
            try {
                personRoleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'personRole.label', default: 'PersonRole'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'personRole.label', default: 'PersonRole'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'personRole.label', default: 'PersonRole'), params.id])}"
            redirect(action: "list")
        }
    }
}
