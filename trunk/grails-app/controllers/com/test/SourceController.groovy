package com.test

import grails.plugins.springsecurity.Secured

class SourceController {
	@Secured(['ROLE_ADMIN'])
    def index = { render 'Yep, I can be reached'}
}
