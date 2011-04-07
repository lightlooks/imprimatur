package com.lightlooks.reviews

import com.lightlooks.schemassessor.core.XSOMAssessor
import com.sun.xml.xsom.parser.XSOMParser
import java.security.MessageDigest
import org.springframework.web.multipart.MultipartFile

import grails.plugins.springsecurity.Secured

class ReviewController {

	/* dependency injected from spring-security-core plugin */
	def springSecurityService

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[reviewInstanceList: Review.list(params), reviewInstanceTotal: Review.count()]
	}

	def create = {
		def reviewInstance = new Review()
		reviewInstance.properties = params
		return [reviewInstance: reviewInstance]
	}

	def forfile = {
		def reviewInstance = new Review()
		reviewInstance.properties = params
		return [reviewInstance: reviewInstance]
	}

	def fromfile = {
		def artefactHash = ''
		def artefactName = ''
		MultipartFile f = request.getFile('reviewSubject')
		if(!f.empty) {
			artefactHash=getHashForFile( f)
			artefactName=getFileName(f)
		}
		else {
			flash.message = 'Please provide the file whose credentials you want to check'
			redirect(action:'forfile')
		}
		def review = Review.findByArtefactHash(artefactHash)
		if (!review){
			flash.message = 'Could not find a file with that content in the review system'
			redirect(action: 'forfile')
		}
		else if(! (review.artefactName.equals(artefactName))){
			flash.message = 'Showing a review for' << artefactName << 'which appeared to be the same (potentially wrong)'
			redirect(action: 'show', id: review.id)
		}
		else{
			flash.message = 'Found perfect match, I think!'
			redirect(action: 'show', id: review.id)
		}
	}

	@Secured(['ROLE_SIGNOFF'])
	def signoff = {
		def reviewInstance = Review.get(params.id)
		
		def signoff = new SignOff(dateTimeSignedOff: Calendar.getInstance(),
			username: springSecurityService.principal.username,
			comment: params.comment
			)
		
		reviewInstance.addToSignoffs(signoff)

		if(reviewInstance.save(flush:true)){
			flash.message = 'Signed off'
		}
		else{
			reviewInstance.errors.each{
				System.out.println(it.toString())
			}
			flash.message = 'Could not save sign-off, sorry'
		}
		redirect(action: 'show', id: reviewInstance.id)
	}

	def save = {
		Review reviewInstance = new Review(params)		
		
		reviewInstance.dateRaised = Calendar.getInstance()
		
		MultipartFile f = request.getFile('reviewSubject')
		if(!f.empty) {
			reviewInstance.artefactHash=getHashForFile( f)
			reviewInstance.artefactName=getFileName (f)
		}
		else {
			flash.message = 'file cannot be empty'
			redirect(action:'create')
		}

		if(reviewInstance.artefactName.endsWith('.xsd')){
			reviewFile(f, reviewInstance)
			
		}
		if (reviewInstance.save(flush: true)) {

			flash.message = "${message(code: 'default.created.message', args: [message(code: 'review.label', default: 'Review'), reviewInstance.id])}"
			redirect(action: "show", id: reviewInstance.id)
		}
		else {

			render(view: "create", model: [reviewInstance: reviewInstance])
		}
	}


	def show = {
		def reviewInstance = Review.get(params.id)
		if (!reviewInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'review.label', default: 'Review'), params.id])}"
			redirect(action: "list")
		}
		else {
			[reviewInstance: reviewInstance]
		}
	}

	def edit = {
		def reviewInstance = Review.get(params.id)
		if (!reviewInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'review.label', default: 'Review'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [reviewInstance: reviewInstance]
		}
	}

	def update = {
		def reviewInstance = Review.get(params.id)
		if (reviewInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (reviewInstance.version > version) {

					reviewInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'review.label', default: 'Review')]
					as Object[], "Another user has updated this Review while you were editing")
					render(view: "edit", model: [reviewInstance: reviewInstance])
					return
				}
			}
			reviewInstance.properties = params
			if (!reviewInstance.hasErrors() && reviewInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'review.label', default: 'Review'), reviewInstance.id])}"
				redirect(action: "show", id: reviewInstance.id)
			}
			else {
				render(view: "edit", model: [reviewInstance: reviewInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'review.label', default: 'Review'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def reviewInstance = Review.get(params.id)
		if (reviewInstance) {
			try {
				reviewInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'review.label', default: 'Review'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'review.label', default: 'Review'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'review.label', default: 'Review'), params.id])}"
			redirect(action: "list")
		}
	}

	def o = { str ->
		System.out.println(str)
	}

	byte[] getHashForFile(f){
		MessageDigest md = MessageDigest.getInstance("SHA-256")
		md.update f.getBytes()
		md.digest()
	}

	String getFileName(f){
		f.getOriginalFilename()
	}
	
	def reviewFile (MultipartFile f, Review r){
		def xp = new XSOMParser()
		xp.parse f.getInputStream()
		def xs = xp.getResult();
		XSOMAssessor xa = new XSOMAssessor()
		xa.assess xs

		xa.getErrorHandler().getEvents().each{

			def re = new ReviewError(lineNumber: it.getLocation().getLineNumber(),
					code: it.eventCode().getCode(),
					description: it.getDescription())

			r.addToReviewErrors(re)
		}
		xa.getWarningHandler().getEvents().each{

			def wng = new Warning(lineNumber:it.getLocation().getLineNumber(),
					code:it.eventCode().getCode(),
					description:it.getDescription())

			r.addToReviewWarnings(wng)
		}
		
	}
}
