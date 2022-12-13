package htmlDSL.generator.objects

import htmlDSL.xtml.Function
import java.util.ArrayList
import java.util.HashMap

abstract class DefinitionObj {
	/**
	 * Name of the object 
	 * In <code>Container c</code> c is the name
	 */
	var String name

	/**
	 * Type of the object 
	 * In <code>Container c</code> Container is the type
	 */
	var String type

	/**
	 * CSS code to apply to this element
	 */
	var String style = "";

	/**
	 * CSS classes to apply to this element
	 */
	var ArrayList<String> classes = newArrayList

	/**
	 * Title for an element
	 * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/title
	 */
	var String title

	/**
	 * The element is contained or not
	 */
	var boolean contained

	new(String name, String type) {
		this.name = name
		this.type = type
	}

	def String getName() { return name }

	def void setName(String name) { this.name = name }

	def String getType() { return type }

	def void setType(String type) { this.type = type }

	def String getStyle() { return style }

	def void setStyle(String style) { this.style = style }

	def ArrayList<String> getClasses() { return classes }

	def void setClasses(ArrayList<String> classes) { this.classes = classes }

	def String getTitle() { return title }

	def void setTitle(String title) { this.title = title }

	def boolean isContained() { return contained }

	def void setContained(boolean contained) { this.contained = contained }

	/**
	 * Allows a function to be called on this element 
	 * Template method design pattern is used to allow the 
	 * management of general functions here and the management
	 * of specific functions in callChildFunction implemented
	 * by each child
	 */
	def final void callFunction(Function function, HashMap<String, DefinitionObj> definitionMap) {
		switch function.fname {
			case "style": style += function.strings.get(0)
			case "classes": classes.addAll(function.strings)
			case "title": title = function.strings.get(0)
			default: callChildFunction(function, definitionMap)
		}
	}

	/**
	 * Function to be defined by the children to allow them to call a function of their own
	 */
	def package void callChildFunction(Function function, HashMap<String, DefinitionObj> definitionMap)

	def String createCSS() {
		if (style === null || style == "") return ""
		return '''
			.«name» {
				«style»
			}
		'''
	}

	/**
	 * Return the template for this element
	 */
	def String createTag()
}
