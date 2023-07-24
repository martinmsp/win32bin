param ($path)

function usage
{
	$name = $(split-path $MyInvocation.ScriptName -leaf) -replace "\.ps1$"
	E "USAGE: $name <.jpg|.jpeg|.png>"
	exit 1
}

if (!(test-path "$path") -or $args.count -gt 0) {
	usage
}

switch -regex ($path) {
"\.jpg$"
	{ break }
"\.jpeg$"
	{ break }
"\.png$"
	{ break }
default
	{ usage }
}

add-type -assemblyname "System.Windows.Forms"

$img = [System.Drawing.Image]::Fromfile((get-item $path))

[System.Windows.Forms.Application]::EnableVisualStyles();

$form = new-object Windows.Forms.Form
$form.text = $path
$form.height = $img.size.height
$form.width = $img.size.width

$picturebox = new-object Windows.Forms.PictureBox
$picturebox.height = $img.size.height
$picturebox.width = $img.size.width

$picturebox.image = $img
$form.controls.add($picturebox)
$form.add_shown({ $form.activate() })
$form.showdialog()
