package poc.handlers;

import java.util.stream.Stream;

import org.springframework.stereotype.Component;

import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.catalogservicero.Books;
import cds.gen.catalogservicero.CatalogServiceRo_;

@Component
@ServiceName(CatalogServiceRo_.CDS_NAME)
public class CatalogServiceHandler implements EventHandler {

	@After(event = CqnService.EVENT_READ)
	public void discountBooks(Stream<Books> books) {
		// books.filter(b -> b.getTitle() != null && b.getStock() != null)
		// .filter(b -> b.getStock() > 200)
		// .forEach(b -> b.setTitle(b.getTitle() + " (discounted)"));
	}

}