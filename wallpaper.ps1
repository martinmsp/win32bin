param ($path)

function usage
{
	$name = $(split-path $MyInvocation.ScriptName -leaf) -replace "\.ps1$"
	E "USAGE: $name <.jpg|.jpeg|.png|.webp>"
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
"\.webp$"
	{ break }
default
	{ usage }
}

Add-Type -TypeDefinition @'

using System.Runtime.InteropServices;

public class Wallpaper {
	private const uint SPI_SETDESKWALLPAPER = 0x0014;
	private const uint SPIF_UPDATEINIFILE = 0x0001;
	private const uint SPIF_SENDCHANGE = 0x0002;

	[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Unicode)]

	private static extern int SystemParametersInfo
		(uint action, uint uParam, string s, uint update);

	public static void SetWallpaper(string path)
	{
		SystemParametersInfo
			(SPI_SETDESKWALLPAPER, 0, path, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
	}
}

'@

[Wallpaper]::SetWallpaper($(resolve-path $path))
