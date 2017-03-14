/**
 * 사이트 스트립트
 * 
 * namespace: site
 * 
 * @author magoon
 * 
 * @version 0.0.1-SNAPSHOT
 * 
 */

var site = site || {};

site.helloWorld = "Hello, World!";

site.printHelloWorld = function() {

	console.error(site.helloWorld);
	console.warn(site.helloWorld);
	console.log(site.helloWorld);

	return site.helloWorld;
};
