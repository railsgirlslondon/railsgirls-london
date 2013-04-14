module HomeHelper

  def load_readme_file
    File.read(File.join(File.dirname(__FILE__),"..","..", "README.md"))
  end
end
