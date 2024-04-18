## cap java @odata.draft.enabled conflict with @Aggregation.CustomAggregate

> https://cap.cloud.sap/docs/advanced/fiori#draft-support

> https://cap.cloud.sap/docs/advanced/odata#custom-aggregates

### issue description

how to reproduce:

- 1. mvn spring-boot:run
- 2. open http://localhost:8080
- 3. click link `/books/webapp` below Web Applications session.
- 4. click `Go` button. then you can see the error.
- 5. open `cat-service.cds`, comment out `@odata.draft.enabled` on `Category` projection entity and re-run the application test it again, click on `Category Code` header column and select `Group By` `Category Code` everything works fine.

Even though not using `Associations & Compositions` between `Books` and `Category` entities, `@odata.draft.enabled` still conflict with @Aggregation.CustomAggregate. See the error output as below:

```
2024-04-18T18:11:23.506+08:00  INFO 27480 --- [nio-8080-exec-9] c.s.c.a.o.v4.processors.CdsProcessor     : Exception marked the ChangeSet 5 as cancelled: Cannot convert {"SELECT":{"from":{"ref":["CatalogService.Books"]},"columns":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"},{"func":"SUM","args":[{"ref":["stock"]}],"as":"stock"}],"groupBy":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"}]}} to StructuredTypeRef (service 'CatalogService', event 'READ', entity 'CatalogService.Books')
2024-04-18T18:11:23.508+08:00 ERROR 27480 --- [nio-8080-exec-9] c.s.c.a.o.v4.processors.CdsProcessor     : Cannot convert {"SELECT":{"from":{"ref":["CatalogService.Books"]},"columns":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"},{"func":"SUM","args":[{"ref":["stock"]}],"as":"stock"}],"groupBy":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"}]}} to StructuredTypeRef (service 'CatalogService', event 'READ', entity 'CatalogService.Books')

com.sap.cds.services.impl.ContextualizedServiceException: Cannot convert {"SELECT":{"from":{"ref":["CatalogService.Books"]},"columns":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"},{"func":"SUM","args":[{"ref":["stock"]}],"as":"stock"}],"groupBy":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"}]}} to StructuredTypeRef (service 'CatalogService', event 'READ', entity 'CatalogService.Books')
        at com.sap.cds.services.impl.ServiceImpl.dispatch(ServiceImpl.java:256) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.ServiceImpl.emit(ServiceImpl.java:177) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.ServiceDelegator.emit(ServiceDelegator.java:33) ~[cds-services-api-2.9.0-m2416.jar:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77) ~[na:na]
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:na]
        at java.base/java.lang.reflect.Method.invoke(Method.java:568) ~[na:na]
        at com.sap.cds.services.impl.cds.TypedCqnServiceInvocationHandler.invoke(TypedCqnServiceInvocationHandler.java:70) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at jdk.proxy3/jdk.proxy3.$Proxy34.emit(Unknown Source) ~[na:na]
        at com.sap.cds.adapter.odata.v4.processors.CdsProcessor.query(CdsProcessor.java:398) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.CdsProcessor.get(CdsProcessor.java:354) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.CdsProcessor.delegateRequest(CdsProcessor.java:227) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.CdsProcessor.lambda$processRequest$1(CdsProcessor.java:153) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.RequestContextRunnerImpl.lambda$run$3(RequestContextRunnerImpl.java:213) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.RequestContextRunnerImpl.run(RequestContextRunnerImpl.java:272) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.RequestContextRunnerImpl.run(RequestContextRunnerImpl.java:212) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.CdsProcessor.processRequest(CdsProcessor.java:150) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.CdsProcessor.lambda$processRequest$0(CdsProcessor.java:141) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.ChangeSetContextRunnerImpl.open(ChangeSetContextRunnerImpl.java:62) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.ChangeSetContextRunnerImpl.run(ChangeSetContextRunnerImpl.java:41) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.CdsProcessor.processRequest(CdsProcessor.java:140) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.AbstractODataProcessor.processRequest(AbstractODataProcessor.java:155) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.FastODataProcessor.processEntities(FastODataProcessor.java:161) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.OlingoProcessor.readEntityCollection(OlingoProcessor.java:117) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataDispatcher.handleEntityCollectionDispatching(ODataDispatcher.java:542) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataDispatcher.handleEntityDispatching(ODataDispatcher.java:524) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataDispatcher.handleResourceDispatching(ODataDispatcher.java:154) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataDispatcher.dispatch(ODataDispatcher.java:120) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataHandlerImpl.processInternal(ODataHandlerImpl.java:170) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataHandlerImpl.process(ODataHandlerImpl.java:86) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.batchhandler.BatchPartHandler.handle(BatchPartHandler.java:74) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.batchhandler.BatchPartHandler.handleBatchRequest(BatchPartHandler.java:57) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.batchhandler.BatchFacadeImpl.handleBatchRequest(BatchFacadeImpl.java:56) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.processors.OlingoProcessor.processBatch(OlingoProcessor.java:320) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.batchhandler.BatchHandler.process(BatchHandler.java:56) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataDispatcher.dispatch(ODataDispatcher.java:126) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataHandlerImpl.processInternal(ODataHandlerImpl.java:170) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataHandlerImpl.process(ODataHandlerImpl.java:86) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataHttpHandlerImpl.process(ODataHttpHandlerImpl.java:75) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at org.apache.olingo.server.core.ODataHttpHandlerImpl.process(ODataHttpHandlerImpl.java:89) ~[odata-v4-lib-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.CdsODataV4Servlet.lambda$service$0(CdsODataV4Servlet.java:130) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.RequestContextRunnerImpl.lambda$run$3(RequestContextRunnerImpl.java:213) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.RequestContextRunnerImpl.run(RequestContextRunnerImpl.java:272) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.runtime.RequestContextRunnerImpl.run(RequestContextRunnerImpl.java:212) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.adapter.odata.v4.CdsODataV4Servlet.service(CdsODataV4Servlet.java:89) ~[cds-adapter-odata-v4-2.9.0-m2416.jar:na]
        at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:658) ~[tomcat-embed-core-10.1.19.jar:6.0]
        at com.sap.cds.framework.spring.config.adapter.ServletAdapterRestController.handleRequest(ServletAdapterRestController.java:30) ~[cds-framework-spring-boot-2.9.0-m2416.jar:na]
        at org.springframework.web.servlet.mvc.SimpleControllerHandlerAdapter.handle(SimpleControllerHandlerAdapter.java:51) ~[spring-webmvc-6.1.5.jar:6.1.5]
        at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1089) ~[spring-webmvc-6.1.5.jar:6.1.5]
        at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:979) ~[spring-webmvc-6.1.5.jar:6.1.5]
        at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1014) ~[spring-webmvc-6.1.5.jar:6.1.5]
        at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:914) ~[spring-webmvc-6.1.5.jar:6.1.5]
        at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:590) ~[tomcat-embed-core-10.1.19.jar:6.0]
        at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:885) ~[spring-webmvc-6.1.5.jar:6.1.5]
        at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:658) ~[tomcat-embed-core-10.1.19.jar:6.0]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:205) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:149) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:51) ~[tomcat-embed-websocket-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:174) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:149) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100) ~[spring-web-6.1.5.jar:6.1.5]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116) ~[spring-web-6.1.5.jar:6.1.5]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:174) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:149) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93) ~[spring-web-6.1.5.jar:6.1.5]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116) ~[spring-web-6.1.5.jar:6.1.5]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:174) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:149) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201) ~[spring-web-6.1.5.jar:6.1.5]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116) ~[spring-web-6.1.5.jar:6.1.5]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:174) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:149) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:167) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:90) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:482) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:115) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:93) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:344) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:391) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:63) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:896) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1744) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:52) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.tomcat.util.threads.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1191) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:63) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
        at java.base/java.lang.Thread.run(Thread.java:840) ~[na:na]
Caused by: com.sap.cds.CdsException: Cannot convert {"SELECT":{"from":{"ref":["CatalogService.Books"]},"columns":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"},{"func":"SUM","args":[{"ref":["stock"]}],"as":"stock"}],"groupBy":[{"ref":["ID"],"as":"ID"},{"ref":["category_code"],"as":"category_code"},{"ref":["title"],"as":"title"}]}} to StructuredTypeRef
        at com.sap.cds.impl.builder.model.StructuredTypeRefImpl.typeRef(StructuredTypeRefImpl.java:64) ~[cds4j-core-2.9.0-m20240403-143806.jar:na]
        at com.sap.cds.ql.impl.SelectBuilder.ref(SelectBuilder.java:237) ~[cds4j-core-2.9.0-m20240403-143806.jar:na]
        at com.sap.cds.services.impl.draft.DraftActionsHandler.avoidScenarioAnalysis(DraftActionsHandler.java:135) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.draft.DraftActionsHandler.readInternal(DraftActionsHandler.java:99) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.draft.DraftActionsHandler.defaultRead(DraftActionsHandler.java:93) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.handlerregistry.HandlerRegistryTools$DescribedHandler.process(HandlerRegistryTools.java:165) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.ServiceImpl.lambda$createOnHandlerChain$4(ServiceImpl.java:269) ~[cds-services-impl-2.9.0-m2416.jar:na]
        at com.sap.cds.services.impl.ServiceImpl.dispatch(ServiceImpl.java:236) ~[cds-services-impl-2.9.0-m2416.jar:na]
        ... 87 common frames omitted

2024-04-18T18:11:23.541+08:00  INFO 27480 --- [nio-8080-exec-9] c.sap.cds.adapter.odata.v4.BatchAccess   : $batch GET /Books?$apply=concat(aggregate(stock),groupby((ID,category_code,title),aggregate(stock))/concat(aggregate($count%20as%20UI5__count),top(79))) 500
2024-04-18T18:11:23.672+08:00  INFO 27480 --- [io-8080-exec-10] c.sap.cds.adapter.odata.v4.BatchAccess   : $batch GET /Books?$apply=groupby((ID,category_code,title),aggregate(stock))/top(58) 200
```