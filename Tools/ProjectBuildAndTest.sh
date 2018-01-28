#!/bin/sh

#------------------------------------------------------------------------------------------
#
# PURPOSE
# -------
# Build and Generate Documentation for the 'Blackwater' Project
#
# AUTHOR
# ------
# Lumberjacks Incorperated (2018)
#
#------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------------------
main()
{
    echo "\n>> Building..."
    buildBlackwater
    echo ">> done\n"
    
    echo "\n>> Exporting..."
    exportBlackwater
    echo ">> done\n"
    
    echo ">> Generating Documentation..."
    generateDocumentation
    echo ">> done\n"
}

#------------------------------------------------------------------------------------------
# INTERNAL FUNCTIONS
#------------------------------------------------------------------------------------------
function buildBlackwater()
{
    cd ../Executable/
    gcc -framework Foundation -framework CoreWLAN blackwater.m blackwaterTest.m srLibrary.c -lpcap -o blackwater
}

function exportBlackwater()
{
    mv ./blackwater ../Export/
    cp ./printFile.sh ../Export/
}

function generateDocumentation()
{
    ../Tools/generatePackageDocumentation.plx
    mv ./documentation.txt ../Documentation/
}

#------------------------------------------------------------------------------------------
# SCRIPT
#------------------------------------------------------------------------------------------
    main

