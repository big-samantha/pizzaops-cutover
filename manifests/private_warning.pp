define cutover::private_warning ( $class_name = $title ) {
  if $caller_module_name != $module_name {
    notify { "${class_name} is private and should not be called directly.": }
    notify { 'foo::bar baz': }
  }
}
