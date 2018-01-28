//-----------------------------------------------------------------------------------------
//
// PROJECT
// -------
// The 'Blackwater' Project
//
// DESCRIPTION
// -----------
// OSX wifi jamming test implementation
//
// AUTHOR
// ------
// Lumberjacks Incorperated (2018)
//
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
//  INCLUDES
//-----------------------------------------------------------------------------------------
#import <stdio.h>

// Interface file
#import "blackwater.h"

// SR Library
#import "srLibrary.h"

//-----------------------------------------------------------------------------------------
//  FORWARD DECLARATIONS
//-----------------------------------------------------------------------------------------
void userListInterfaces(void);
void listClientsForJam(void);
void jamClient(void);
void runBlackwaterManager(void);
void printOptions(void);
void obtainUserChoice(int * userChoice);
void executeUserChoice(int userChoice);

//-----------------------------------------------------------------------------------------
//  DRIVER
//-----------------------------------------------------------------------------------------
int
    main(
        int argc,
        const char * argv[]
    )
PRE(
    TRUE)
    
    runBlackwaterManager();
    
POST(
    0,
    TRUE)

//-----------------------------------------------------------------------------------------
//  PRIVATE FUNCTIONS
//-----------------------------------------------------------------------------------------
void
    runBlackwaterManager(
        void
    )
PRE(
    TRUE)
    
    int userChoice = 0;
    
    while(userChoice != 4) {
        printOptions();
        obtainUserChoice(&userChoice);
        executeUserChoice(userChoice);
    }
    
POST(
    ,TRUE)

void
    printOptions(
        void
    )
PRE(
    TRUE)
    
    printf("Options: \n");
    printf("1 - List Interfaces\n");
    printf("2 - List potential wifi jam clients\n");
    printf("3 - Jam wifi client\n");
    printf("4 - END.\n");
    
POST(
    ,TRUE)

void
    obtainUserChoice(
        int * userChoice
    )
PRE(
    TRUE)
    
    scanf("%d", userChoice);
    
POST(
    ,TRUE)

void
    executeUserChoice(
        int userChoice
    )
PRE(
    TRUE)
    
    switch (userChoice) {
        case 1:
            userListInterfaces();
            break;
            
        case 2:
            listClientsForJam();
            break;
            
        case 3:
            jamClient();
            break;
            
        case 4:
            return;
            
        default:
            printf("Invalid Option.\n");
            break;
    }
    
POST(
    ,TRUE)

void
    userListInterfaces(
        void
    )
PRE(
    TRUE)
    
    blackwater * bw = [[blackwater alloc] init];
    [bw listInterfaces];
    
POST(
    ,TRUE)

void
    listClientsForJam(
        void
    )
PRE(
    TRUE)
    
    blackwater * bw = [[blackwater alloc] init];
    [bw printClientList];
    
POST(
    ,TRUE)

void
    jamClient(
        void
    )
PRE(
    TRUE)
    
    blackwater * bw = [[blackwater alloc] init];
    [bw jamWifiNetwork];
    
POST(
    ,TRUE)
