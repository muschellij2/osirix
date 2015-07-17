Ming was compiled using MacPorts 1.9.1

1) Install MacPorts
2) Add the following line to /opt/local/etc/macports/macports.conf
	macosx_deployment_target	10.5
3) Execute
	sudo port install ming +universal

The updated libs will be locaed at:
	/opt/local/lib/libfreetype.a
	/opt/local/lib/libgif.a
	/opt/local/lib/libming.a
	/opt/local/lib/libpng12.a
	
Be sure that the libs are Mach-O
	file /opt/local/lib/libming.a
		../libming.a: Mach-O universal binary with 2 architectures

Move them to this dir, append OsiriX to their names:
	libfreetypeOsiriX.a
	libgifOsiriX.a
	libmingOsiriX.a
	libpng12OsiriX.a

Zip the dir and commit.