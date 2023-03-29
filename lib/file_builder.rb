class FileBuilder
  attr_reader :full_path
 
  def initialize(file_path, file_name, file_content)
    require "fileutils"
    FileUtils.mkdir_p file_path
    @full_path = "#{file_path}#{file_path.last != '/' ? '/' :             
                  ''}#{file_name}"
    @file_content = file_content
  end
 
 
  def from_base_64
    content = Base64.decode64(@file_content.match(/,(.*)/)[1])
    generate_file content
    @full_path
  end
 
 
  private
 
 
  def generate_file(decoded_content)
    File.open(@full_path, "w:binary") do |f|
      f.write decoded_content
    end
  end
end