package com.lightlooks.reviews

class StandardsLinkTagLib {

	static namespace = "stdslink"
	
	def link = { attrs ->
		
		switch(attrs['type']){
			case 'xsd': xsdlink(attrs['code'])
						break;
			default: break;
		}
			
	}
	
	def xsdlink = { code ->
		out << "<a href=\""
		out << "http://cap-wiki/twiki/bin/view/Sandbox/XsdRules#XsdRule"
		out << code
		out << "\">" << code << "</a>" 	
	}		

}
