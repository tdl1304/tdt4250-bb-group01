package htmlDSL.generator.objects

import htmlDSL.xtml.Function
import java.util.HashMap
import java.util.List
import htmlDSL.xtml.Definition
import htmlDSL.xtml.GridRow

class ContainerObj extends DefinitionObj {
	/**
	 * List of objects contained by this container
	 */
	var List<DefinitionObj> contents = newArrayList
	var String gridCss;
	var String flexCss;
	
	/**
	 * What type of div this is. By default a regular div, but with the 'type' function it can change to header, footer, main, aside...
	 */
	var String containerType = "div";

	new(String name, String type) {
		super(name, type)
	}

	new(String name, String type, List<DefinitionObj> contents) {
		this(name, type)
		this.contents = contents
	}

	/**
	 * Add an object to the list of contained objects
	 */
	def add(DefinitionObj obj) {
		contents.add(obj)
	}

	/**
	 * Add objects to this container if they exist (it should) in the definitionMap
	 */
	def private add(List<Definition> definitions, HashMap<String, DefinitionObj> definitionMap) {
		for (Definition definition : definitions) {
			var obj = definitionMap.get(definition.name)
			if (obj !== null) {
				obj.contained = true
				add(obj)
			}
		}
	}

	def private void selectGridFlex(boolean isGrid, String css) {
		if (isGrid) {
			gridCss = css
			flexCss = null
		} else {
			flexCss = css
			gridCss = null
		}
	}

	def void formatGrid(List<GridRow> rows, HashMap<String, DefinitionObj> definitionMap) {
		var boolean doneColumns = false;
		var String previousContent = style;
		
		var String tempStr = "display: grid;\n";
		var String gridRows = "grid-template-rows:";
		var String gridColumns = "grid-template-columns:"
		tempStr += "grid-template-areas:\n";
		for(GridRow row : rows){
			if(!doneColumns){
				doneColumns = true;
				for(var int i=0; i<row.elements.length; i++)
					gridColumns += " 1fr";
			}
			
			gridRows += " auto";
			tempStr += "'";
			for(Definition elem : row.elements){				
				tempStr += elem.name + " ";
			}
			tempStr += "' ";
		}
		gridRows += ";\n";
		gridColumns += ";\n";
		var String gaps = "grid-row-gap: 0.5rem; \n grid-column-gap: 0.5rem; \n ";
		tempStr += ";\n";
		
		previousContent += tempStr;
		style = previousContent + gridRows + gridColumns + gaps;
		selectGridFlex(true, style);
		
		//in order for grid to work, all immediate children must have a styletag of grid-area set
		for(DefinitionObj obj : contents){
			var child = definitionMap.get(obj.name)
			var childStyle = child.getStyle()
			child.setStyle(childStyle + "grid-area: " + child.name + ";\n");
		}
	}

	def private void setFlex(List<String> parameters) {
		var css = '''
			display: flex;
			«IF parameters.size > 0»justify-content: «parameters.get(0)»;«ENDIF»
			«IF parameters.size > 1»align-items: «parameters.get(1)»;«ENDIF»
		'''
		selectGridFlex(false, css)
	}

	/**
	 * Function to be defined by the children to allow them to call a function of their own
	 */
	override callChildFunction(Function function, HashMap<String, DefinitionObj> definitionMap) {
		switch function.fname {
			case "add": add(function.objects, definitionMap)
			case "grid": formatGrid(function.rows, definitionMap)
			case "flex": setFlex(function.strings)
			case "type": containerType = function.strings.get(0)
		}
	}

	override createCSS() {
		var css = '''
			«IF style !== ""»«style»«ENDIF»
			«IF gridCss !== null && gridCss != ""»«gridCss»«ENDIF»
			«IF flexCss !== null && flexCss != ""»«flexCss»«ENDIF»
		'''
		println(css=="")
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
		var attributes = newArrayList
		var otherClasses = '''«FOR classe : classes BEFORE ' ' SEPARATOR ' '»«classe»«ENDFOR»'''
		if (title !== null && title != "") {
			attributes.add('title="' + title + '"')
		}
		return '''
			<«containerType» class="«name»«otherClasses»"«FOR attribute : attributes BEFORE ' ' SEPARATOR ' '»«attribute»«ENDFOR»>
				«FOR e : contents»
					«e.createTag»
				«ENDFOR»
			</div>
		'''
	}

}
