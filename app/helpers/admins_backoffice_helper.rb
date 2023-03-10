module AdminsBackofficeHelper 

  def traslate_field(object = nil, method = nil)
    (object && method) ? object.model.human_attribute_name(method) : "traslation not found"
  end

end