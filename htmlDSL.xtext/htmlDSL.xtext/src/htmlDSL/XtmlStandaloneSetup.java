/*
 * generated by Xtext 2.27.0
 */
package htmlDSL;


/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
public class XtmlStandaloneSetup extends XtmlStandaloneSetupGenerated {

	public static void doSetup() {
		new XtmlStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}
