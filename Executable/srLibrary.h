#ifndef SR_LIBRARY_H
#define SR_LIBRARY_H
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

//-----------------------------------------------------------------------------------------
// TYPE DEFINITIONS
//-----------------------------------------------------------------------------------------
typedef int SR_ERROR;

//-----------------------------------------------------------------------------------------
// VALUE DEFINITIONS DEFINITIONS
//-----------------------------------------------------------------------------------------
#define SR_OK                                   0
#define SR_FAIL                                 1
#define INVALID_BUFFER                          (char*) 1
#define VALID                                   1
#define INVALID                                 0

#define PRECONDITION(X)                         assert((X))
#define POSTCONDITION(X)                        assert((X))
#define POST(__return, __postcond)              POSTCONDITION( __postcond ); return __return; }
#define PRE(__precond)                          { PRECONDITION( __precond );
#define TRUE                                    1

//-----------------------------------------------------------------------------------------
// EXPORTED FUNCTIONS
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
//
// NAME:
//                  sr_strlen
//
// DESCRIPTION:
//                  The SR (safe) implementation of the standard 'strlen'
//
// PARAMETERS:
//                  char*               inputBuffer
//                                                      A buffer which contains the string
//                                                      to measure
//
// RETURNS:
//                  int                     The size of the string inputted
//
//
//-----------------------------------------------------------------------------------------
int
    sr_strlen (
        char* inputBuffer
    );

//-----------------------------------------------------------------------------------------
//
// NAME:
//                  sr_allocate
//
// DESCRIPTION:
//                  The SR (safe) implementation of the standard 'malloc'
//
// PARAMETERS:
//                  int                 sizeRequired
//                                                      The size to allocate
//
// RETURNS:
//                  SR_OK                   on success
//                  INVALID_BUFFER          if not enough memory was avaliable to allocate
//
//-----------------------------------------------------------------------------------------
char*
    sr_allocate (
        int sizeRequired
    );

//-----------------------------------------------------------------------------------------
//
// NAME:
//                  sr_getchar
//
// DESCRIPTION:
//                  The SR (safe) implementation of the standard 'getchar'
//
// PARAMETERS:
//                  void
//
// RETURNS:
//                  int                     ASCII for character, or EOF on file end or
//                                          error
//
//-----------------------------------------------------------------------------------------
int
    sr_getchar (
        void
    );

#endif
