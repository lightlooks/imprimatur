import com.lightlooks.schemassessor.core.XSOMAssessor
import com.sun.xml.xsom.parser.XSOMParser 
import org.springframework.web.multipart.commons.CommonsMultipartFile
import com.lightlooks.reviews.Review
import com.lightlooks.reviews.ReviewService

@GrabResolver(name="local", root="file:///Users/miked/.m2/repository/" )
@Grab(group="com.lightlooks.schemassessor", module="core", version="0.0.1-SNAPSHOT" )
dummyBecauseGrabSeemsToWipeTheNextAssignment = 0
name="SchemaAssessor Plugin 1.0"
key = "schemaAssessor"


doReview={ CommonsMultipartFile file,  metadata, Review reviewInstance ->
	
	System.out.println("revieweing file "+file.getName())	
	
		def xp = new XSOMParser()
		xp.parse file.getInputStream()
		def xs = xp.getResult();
		XSOMAssessor xa = new XSOMAssessor()
		xa.assess xs
//TODO uncomment
//		xa.getErrorHandler().getEvents().each{
//		reviewService.addError(it.getLocation().getLineNumber(),
//			it.eventCode().getCode(), it.getDescription(), reviewInstance)
//			
//		}
//		xa.getWarningHandler().getEvents().each{
//
//			reviewService.addWarning(it.getLocation().getLineNumber(),
//			it.eventCode().getCode(), it.getDescription(), reviewInstance)
//		}
}