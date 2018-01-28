#!/usr/bin/perl
use Cwd;

#------------------------------------------------------------------------------------------
#
# PURPOSE
# -------
# Generate documentation for the Blackwater project
#
# AUTHOR
# ------
# Lumberjacks Incorperated (2018)
#
#------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------------------
    
    openDocumentationFile();
    writeDocumentationHeader(*OUTPUTFILE);
    writeDocumentationBody();
    

#------------------------------------------------------------------------------------------
# INTERNAL FUNCTIONS
#------------------------------------------------------------------------------------------
sub openDocumentationFile
{
    $fileprefix = $ARGV[0];
    open OUTPUTFILE, ">", "$fileprefix"."documentation.txt" or die $!;
    return *OUTPUTFILE;
}

sub writeDocumentationHeader
{
    *OUTPUTFILE = shift;
    print OUTPUTFILE "#########################################################################################################################\n";
    print OUTPUTFILE "#\n";
    print OUTPUTFILE "#                                                  "."Documentation\n";
    print OUTPUTFILE "#\n";
    print OUTPUTFILE "#########################################################################################################################\n\n";
}

sub writeDocumentationBody
{
    my @files = readDirectoryFiles();
    foreach my $file (@files) {
        writeDocumentationForFile($file);
    }
}

sub readDirectoryFiles
{
    my @directoryFiles = listDirectoryFiles();
    my @classfiles = filterClassFiles(@directoryFiles);
}

sub listDirectoryFiles
{
    opendir(DIR, "../Executable/") or die $!;
    @files = readdir(DIR);
    closedir(DIR);
    return  @files;
}

sub filterClassFiles
{
    my @files = @_;
    my @classFiles;
    foreach $file (@files) {
        if($file =~ /(.h$)/) {
            push @classFiles, $file;
        }
    }
    return @classFiles;
}

sub writeDocumentationForFile
{
    my $file = shift;
    writeFileHeader($file);
    pullDocumentationFromFile($file);
    writeFileFooter($file);
}

sub writeFileHeader
{
    my $file = shift;
    print OUTPUTFILE "\n";
    print OUTPUTFILE "File Name: $file\n";
}

sub writeFileFooter
{
    print OUTPUTFILE "\n";
}

sub pullDocumentationFromFile
{
    my $file = shift;
    open INPUTFILE, "<", "../Executable/$file" or die $!;
    
    my @pulledInformation = pullInformationFromFile(*INPUTFILE);
    printFileInformation(@pulledInformation);
}

sub pullInformationFromFile
{
    *INPUTFILE = shift;
    my @pulledInformation;
    
    while(<INPUTFILE>) {
        my $processedLine = processLine($_);
        push @pulledInformation, $processedLine if defined $processedLine;
    }
    return @pulledInformation;
}

sub processLine
{
    my $line = shift;
    if($line =~ (/\/\//)) {
        return sanitizeHfileLine($line);
    }
    return undef;
}

sub sanitizeHfileLine
{
    my $line = shift;
    my @lineSection = (split /\/\//, $line);
    return ("\t" . $lineSection[1]);
}

sub printFileInformation
{
    my @pulledInformation = @_;
    print OUTPUTFILE "\n";
    foreach $pulled (@pulledInformation) {
        print OUTPUTFILE "\t"."$pulled"."";
    }
}
