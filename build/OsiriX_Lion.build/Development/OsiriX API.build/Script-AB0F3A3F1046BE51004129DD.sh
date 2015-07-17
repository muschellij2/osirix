#!/usr/bin/perl
#!/usr/bin/perl

use strict;
use File::Copy;
use File::Basename;
my $destination = "$ENV{TARGET_BUILD_DIR}/$ENV{PUBLIC_HEADERS_FOLDER_PATH}";

mkdir $destination unless -d $destination;
open OsiriX_h, ">", "$destination/OsiriX.h" or die $!;

print OsiriX_h "#ifndef __OsiriX_API\n#define __OsiriX_API\n\n";

my @fromdirs = ("$ENV{PROJECT_DIR}/OsiriXClasses/2D","$ENV{PROJECT_DIR}/OsiriXClasses/3D","$ENV{PROJECT_DIR}/OsiriXClasses/CPR","$ENV{PROJECT_DIR}/OsiriXClasses/DICOMFiles","$ENV{PROJECT_DIR}/OsiriXClasses/DICOMNetwork","$ENV{PROJECT_DIR}/OsiriXClasses/GUI","$ENV{PROJECT_DIR}/OsiriXClasses/OSI","$ENV{PROJECT_DIR}/OsiriXClasses/ROI","$ENV{PROJECT_DIR}/OsiriXClasses/Web","$ENV{PROJECT_DIR}/cocoahttpserver", "$ENV{PROJECT_DIR}/Binaries/dcmtk-source/config", "$ENV{PROJECT_DIR}/Binaries/dcmtk-source/dcmsr", "$ENV{PROJECT_DIR}/Binaries/dcmtk-source/dcmdata", "$ENV{PROJECT_DIR}/Binaries/dcmtk-source/ofstd", "$ENV{PROJECT_DIR}/Binaries/dcmtk-source/dcmnet", "$ENV{PROJECT_DIR}/VTKHeaders", "$ENV{PROJECT_DIR}/Nitrogen/Sources", "$ENV{PROJECT_DIR}/Nitrogen/Sources/JSON", $ENV{PROJECT_DIR});

foreach my $root (@fromdirs) {
	opendir(DIR, $root);
	
	my @files = readdir(DIR);
	foreach (@files) {
		my $filename = $_;
		next unless -f "$root/$filename" && $filename =~ /\.h$/s;
		my @args = ( "cp", "-fp", "$root/$filename", "$destination/".(basename $filename) );
		system(@args) == 0 or die "Copy failed: $?";
		print OsiriX_h "#include <OsiriXAPI/$filename>\n";
	}
	
	closedir(DIR);
}

print OsiriX_h "\n#endif\n";
close OsiriX_h;

chdir "$ENV{TARGET_BUILD_DIR}/$ENV{FULL_PRODUCT_NAME}";
symlink "Versions/Current/Headers", "Headers";

exit 0;
