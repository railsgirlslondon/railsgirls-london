# So we don't autoload the entire lib folder, and don't have to worry about path
# traversal to manually require a class. Follows the 'module/class' pattern.
def require_lib(lib_name)
  require Rails.root.join('lib', lib_name)
end
