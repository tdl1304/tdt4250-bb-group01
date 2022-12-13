package htmlDSL.generator.objects

import htmlDSL.xtml.Function
import java.util.HashMap

class ImageObj extends DefinitionObj{
	
	var String source;
	var String alt;
	
	new(String name, String type) {
		super(name, type)
	}
	
	new(String name, String type, String source) {
		this(name, type)
		this.source = source
	}
	
	new(String name, String type, String source, String alt) {
		this(name, type, source)
		this.alt = alt
	}
	
	def String getSource() { return source }

	def void setSource(String source) { this.source = source }
	
	def String getAlt() { return alt }

	def void setAlt(String alt) { this.alt = alt }
	
	override callChildFunction(Function function, HashMap<String, DefinitionObj> definitionMap) {
		switch function.fname {
			case "src": source = function.strings.get(0)
			case "alt": alt = function.strings.get(0)
		}
	}
	
	override createTag() {
		var attributes = newArrayList
		var otherClasses = '''«FOR classe : classes BEFORE ' ' SEPARATOR ' '»«classe»«ENDFOR»'''
		
		if (source !== null && source != "") {
			attributes.add('src="' + source + '"')
		}
		
		if (alt !== null && alt != "") {
			attributes.add('alt="' + alt+ '"')
		}
		
		return '''
			<img class="«name»«otherClasses»"«FOR attribute : attributes BEFORE ' ' SEPARATOR ' '»«attribute»«ENDFOR»/>
		'''
	}
	
}