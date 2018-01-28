//-----------------------------------------------------------------------------------------
//
// PROJECT
// -------
// The 'Blackwater' Project
//
// DESCRIPTION
// -----------
// OSX wifi jamming
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

// CoreWlan FrameWork Needed
#import <Foundation/Foundation.h>

// srLibrary
#import "srLibrary.h"

//-----------------------------------------------------------------------------------------
//  INTERFACE DEFINITION
//-----------------------------------------------------------------------------------------
@interface blackwater : NSObject

//-----------------------------------------------------------------------------------------
//
// NAME:
//                  listInterfaces
//
// DESCRIPTION:
//                  List wireless interfaces that 'en0' can discover
//
// PARAMETERS:
//                  void
//
// RETURNS:
//                  SR_OK                       on success
//                  INVALID ARGUEMENT           on arguement passed that cannot be used
//
//-----------------------------------------------------------------------------------------
- (void)
    listInterfaces;

//-----------------------------------------------------------------------------------------
//
// NAME:
//                  jamWifiNetwork
//
// DESCRIPTION:
//                  Jam a wireless network of the users choice
//
// PARAMETERS:
//                  void
//
// RETURNS:
//                  void
//
//-----------------------------------------------------------------------------------------
- (void)
    jamWifiNetwork;

//-----------------------------------------------------------------------------------------
//
// NAME:
//                  printClientList
//
// DESCRIPTION:
//                  print a list of potential clients to jam
//
// PARAMETERS:
//                  void
//
// RETURNS:
//                  void
//
//-----------------------------------------------------------------------------------------
- (void)
    printClientList;

@end
