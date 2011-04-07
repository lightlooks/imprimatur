package com.lightlooks.reviews

class ReviewErrorController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [reviewErrorInstanceList: ReviewError.list(params), reviewErrorInstanceTotal: ReviewError.count()]
    }

    def create = {
        def reviewErrorInstance = new ReviewError()
        reviewErrorInstance.properties = params
        return [reviewErrorInstance: reviewErrorInstance]
    }

    def save = {
        def reviewErrorInstance = new ReviewError(params)
        if (reviewErrorInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), reviewErrorInstance.id])}"
            redirect(action: "show", id: reviewErrorInstance.id)
        }
        else {
            render(view: "create", model: [reviewErrorInstance: reviewErrorInstance])
        }
    }

    def show = {
        def reviewErrorInstance = ReviewError.get(params.id)
        if (!reviewErrorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), params.id])}"
            redirect(action: "list")
        }
        else {
            [reviewErrorInstance: reviewErrorInstance]
        }
    }

    def edit = {
        def reviewErrorInstance = ReviewError.get(params.id)
        if (!reviewErrorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [reviewErrorInstance: reviewErrorInstance]
        }
    }

    def update = {
        def reviewErrorInstance = ReviewError.get(params.id)
        if (reviewErrorInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (reviewErrorInstance.version > version) {
                    
                    reviewErrorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'reviewError.label', default: 'ReviewError')] as Object[], "Another user has updated this ReviewError while you were editing")
                    render(view: "edit", model: [reviewErrorInstance: reviewErrorInstance])
                    return
                }
            }
            reviewErrorInstance.properties = params
            if (!reviewErrorInstance.hasErrors() && reviewErrorInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), reviewErrorInstance.id])}"
                redirect(action: "show", id: reviewErrorInstance.id)
            }
            else {
                render(view: "edit", model: [reviewErrorInstance: reviewErrorInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def reviewErrorInstance = ReviewError.get(params.id)
        if (reviewErrorInstance) {
            try {
                reviewErrorInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reviewError.label', default: 'ReviewError'), params.id])}"
            redirect(action: "list")
        }
    }
}
