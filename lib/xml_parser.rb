class XmlParser
  attr_reader :document

  def initialize(xml_string)
    @xml_string = xml_string
    @document = parse_xml
  end

  private

  def parse_xml
    stack = []
    current = nil
    @xml_string.scan(/<[^>]+>|[^<]+/) do |token|
      if token.start_with?('</')
        current = stack.pop
      elsif token.start_with?('<')
        element_name = token[1..-1].split.first
        element = {
          name: element_name,
          children: [],
          text: nil
        }
        if stack.empty?
          @document = element
        else
          stack.last[:children] << element
        end
        stack.push(element)
        current = element
      else
        current[:text] = token.strip unless token.strip.empty? || current.nil?
      end
    end
    @document
  end  
end
