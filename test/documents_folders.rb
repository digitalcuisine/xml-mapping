require 'xml/mapping'

class Entry
  include XML::Mapping

  text_node :name, "name"
end


class Document <Entry
  include XML::Mapping

  text_node :contents, "contents"

  def ==(other)
    Document===other and
      other.name==self.name and
      other.contents==self.contents
  end
end


class Folder <Entry
  include XML::Mapping

  array_node :entries, "document|folder", :default_value=>[]

  def [](name)
    entries.select{|e|e.name==name}[0]
  end

  def append(name,entry)
    entries << entry
    entry.name = name
    entry
  end

  def ==(other)
    Folder===other and
      other.name==self.name and
      other.entries==self.entries
  end
end
