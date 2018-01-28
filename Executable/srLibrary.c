//-----------------------------------------------------------------------------------------
//
// PROJECT
// -------
// The SR Library Project
//
// DESCRIPTION
// -----------
// The library implementation source file
//
// AUTHOR
// ------
// Lumberjacks Incorperated (2018)
//
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
// INCLUDES
//-----------------------------------------------------------------------------------------
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

// Interface File
#include "srLibrary.h"

//-----------------------------------------------------------------------------------------
// PRIVATE FUNCTION FORWARD DEFINITIONS
//-----------------------------------------------------------------------------------------
int successfullyAllocated(char* buffer);

//-----------------------------------------------------------------------------------------
// EXPORTED FUNCTIONS
//-----------------------------------------------------------------------------------------
int
    sr_strlen (
        char* inputBuffer
    )
PRE(
    inputBuffer != NULL )
    
    int bufferLength = 0;
    
    bufferLength = strlen( inputBuffer );
    
POST(
    bufferLength
    ,TRUE)

char*
    sr_allocate (
        int sizeRequired
    )
PRE(
    sizeRequired > 0 )
    
    char* newBuffer = malloc( sizeRequired );
    
    if( !successfullyAllocated( newBuffer ) ) {
        newBuffer = INVALID_BUFFER;
    }
    
POST(
    newBuffer,
    newBuffer != NULL)

int
    sr_getchar (
        void
    )
PRE(
    TRUE)
    
    int inputCharacter = 0;
    
    inputCharacter = getchar();
    
POST(
    inputCharacter
    ,TRUE)

//-----------------------------------------------------------------------------------------
// PRIVATE FUNCTIONS
//-----------------------------------------------------------------------------------------
int
    successfullyAllocated(
        char* buffer
    )
PRE(
    TRUE)

    int allocationSuccessful = INVALID;

    if( buffer != NULL ) {
        allocationSuccessful = VALID;
    } else {
        allocationSuccessful = INVALID;
    }

POST(
    allocationSuccessful
    ,TRUE)




