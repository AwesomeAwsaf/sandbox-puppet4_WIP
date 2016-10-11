class flush_dns {

  exec { 'flush_dns':
    command     => 'powershell.exe -executionpolicy unrestricted -Command "C:\windows\system32\ipconfig.exe /flushdns"',
    path        => $::path,
    refreshonly => true,
  }
}