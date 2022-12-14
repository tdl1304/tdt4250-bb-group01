/*
 * generated by Xtext 2.27.0
 */
package htmlDSL.validation;

import org.eclipse.xtext.validation.Check;

import htmlDSL.xtml.FunctionCall;
import htmlDSL.xtml.XtmlPackage;

/**
 * This class contains custom validation rules.
 *
 * See
 * https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
public class XtmlValidator extends AbstractXtmlValidator {
	public static final String[] VALID_ALL_FUNCS = { "style", "classes", "title" };
	public static final String[] VALID_CONTAINER_FUNCS = { "add" , "grid", "flex", "type"};
	public static final String[] VALID_TEXT_FUNCS = { "color", "href", "font", "size", "text" };
	public static final String[] VALID_IMAGE_FUNCS = { "src", "alt" };
	

	private boolean in(String s, String[] arr) {
		for (String s_arr : arr) {
			if (s.equals(s_arr)) {
				return true;
			}
		}
		return false;
	}

	@Check
	public void checkValidFunction(FunctionCall func) {
		String objType = func.getRef().getType();
		String funName = func.getFunc().getFname();
		
		if (in(funName, VALID_ALL_FUNCS)) return;
		
		switch (objType) {
		case "Container":
			if (!in(funName, VALID_CONTAINER_FUNCS)) {
				error("Function call is not valid for Container", XtmlPackage.Literals.FUNCTION_CALL__FUNC);
			}
			break;
		case "Text":
			if (!in(funName, VALID_TEXT_FUNCS)) {
				error("Function call is not valid for Text", XtmlPackage.Literals.FUNCTION_CALL__FUNC);
			}
			break;
		case "Image":
			if (!in(funName, VALID_IMAGE_FUNCS)) {
				error("Function call is not valid for Image", XtmlPackage.Literals.FUNCTION_CALL__FUNC);
			}
			break;
		}
	}
}
