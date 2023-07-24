$fonts = (new-object -comobject shell.application).namespace(0x14)

foreach ($file in get-childitem *.otf) {
	$name = $file.name
	if (test-path "C:\windows\fonts\$name) {
		write-host "Already installed: $name"
	} else {
		write-host "--- Installing: $name ---"
		$fonts.copyhere($file.fullname)
		cp $name "C:\windows\fonts"
	}
}
