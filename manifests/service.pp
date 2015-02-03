class cutover::service {
  if ! defined(Service['pe-puppet']) {
    service { 'pe-puppet': }
  }
}
