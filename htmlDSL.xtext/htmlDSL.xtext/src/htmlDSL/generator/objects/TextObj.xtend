package htmlDSL.generator.objects

import htmlDSL.generator.objects.DefinitionObj
import htmlDSL.xtml.Function
import java.util.HashMap

class TextObj extends DefinitionObj {
	/**
	 * The text to display
	 */
	var String text

	/**
	 * The href attribute 
	 * If this attribute is set, the element will be an 'a' HTML Element
	 */
	var String href

	/**
	 * The font to use on this element
	 */
	var String font

	/**
	 * The color to use on this element
	 */
	var String color

	/**
	 * The size of the font to use on this element
	 */
	var String size

	new(String name, String type) {
		super(name, type)
	}

	new(String name, String type, String text) {
		this(name, type)
		this.text = text
	}

	def String getText() { return text }

	def void setText(String text) { this.text = text }

	def String getHref() { return href }

	def void setHref(String href) { this.href = href }

	def String getFont() { return font }

	def void setFont(String font) { this.font = font }

	def String getColor() { return color }

	def void setColor(String color) { this.color = color }

	def String getSize() { return size }

	def void setSize(String size) { this.size = size }

	/**
	 * Function to be defined by the children to allow them to call a function of their own
	 */
	override callChildFunction(Function function, HashMap<String, DefinitionObj> definitionMap) {
		switch function.fname {
			case "href": href = function.strings.get(0)
			case "font": font = function.strings.get(0)
			case "size": size = function.strings.get(0)
			case "text": text = function.strings.get(0)
			case "color": color = function.strings.get(0)
		}
	}

	override createCSS() {
		var css = '''
			«IF style !== ""»«style»«ENDIF»
			«IF font !== null && font != ""»font: «font»;«ENDIF»
			«IF size !== null && size != ""»font-size: «size»;«ENDIF»
			«IF color !== null && color != ""»color: «color»;«ENDIF»
		'''
		println(css)
		if(css == "") return css
		return '''
			.«name» {
				«css»
			}
		'''
	}

	/**
	 * Return the template for this element
	 */
	override createTag() {
		if(text === null) return ""
		var attributes = newArrayList
		var element = "p"
		var otherClasses = '''«FOR classe : classes BEFORE ' ' SEPARATOR ' '»«classe»«ENDFOR»'''

		if (title !== null && title != "") {
			attributes.add('title="' + title + '"')
		}

		if (href !== null && href != "") {
			element = "a"
			attributes.add('href="' + href + '"')
		}

		return '''
			<«element» class="«name»«otherClasses»"«FOR attribute : attributes BEFORE ' ' SEPARATOR ' '»«attribute»«ENDFOR»>
				«text»
			</«element»>
		'''
	}
}
