//
//  XMLBearsParser.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 25/02/2022.
//

import Foundation

class XMLBearsParser : NSObject, XMLParserDelegate {
    var fileName : String
    
    init(fileName:String) {
        self.fileName = fileName
    }
    
    // vars to hold tag data
    var pCommonName, pScientificName, pDiet, pHabitat, pFunFact, pImage, pUrl, pGenusName :String!
    var pHabitats = [String]()
    
    // vars to spy during parsing
    var elementID = -1 // shows which tag is being parsed
    var passData = false // will be true if a tag has finished parsing
    
    // vars to manage whole data (package tags inside of Species class)
    var species = Species()
    var bears = [String : [Species]]()
    
    var parser = XMLParser()
    
    var tags = ["commonName", "scientificName", "habitat", "diet", "funFact", "image", "genusName", "url"]
    
    
    // parser will try to find start element, addressed with elementName, i.e. beginning species tag
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // if elementName is in tags then spy (didStartElement)
        if (tags.contains(elementName)) {
            passData = true
            switch elementName {
                case "commonName"       : elementID = 0
                case "scientificName"   : elementID = 1
                case "habitat"          : elementID = 2
                case "diet"             : elementID = 3
                case "funFact"          : elementID = 4
                case "image"            : elementID = 5
                case "url"              : elementID = 6
                case "genusName"        : elementID = 7
                default                 : break
            }
        }
    }
    
    // parser finds element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // based on spies grab some data into pVars
        if passData {
            switch elementID {
                case 0 : pCommonName        = string
                case 1 : pScientificName    = string
                case 2 : pHabitat           = string
                case 3 : pDiet              = string
                case 4 : pFunFact           = string
                case 5 : pImage             = string
                case 6 : pUrl               = string
                case 7 : pGenusName         = string
                default: break
            }
        }
    }
    
    // parser when individual item is finished, i.e. end of species tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
  
        
        if (elementName == "habitat") {
            pHabitats.append(pHabitat)
        }
        
        if (elementName == "genusName") {
            bears[pGenusName] = []
        }
            
        //reset the spys
        if (tags.contains(elementName)) {
            passData = false
            elementID = -1
        }
        
        //if element name is species, then make an object of Species class and append it to the exisiting bears array
        if (elementName == "species") {
            species = Species(commonName: pCommonName, scientificName: pScientificName, habitats: pHabitats, diet: pDiet, funFact: pFunFact, image: pImage, url: pUrl)
            bears[pGenusName]?.append(species)
            pHabitats.removeAll()
        }
        
      
    }
    
    func parsing() {
        // get path to xml file
        let bundleUrl = Bundle.main.bundleURL
        let fileUrl = URL(string: self.fileName, relativeTo: bundleUrl)
        
        // make the parser for this file
        parser = XMLParser(contentsOf: fileUrl!)!
        
        //give the delegate and parse
        parser.delegate = self
        parser.parse()
    }
    
}
