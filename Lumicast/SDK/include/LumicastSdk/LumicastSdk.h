//
//  LumicastSdk.h
//  Lumicast
//
//  Created by Ken Vavreck on 9/3/14.
//  Copyright (c) 2015 Qualcomm Technologies, Inc.  All Rights Reserved.
//  Qualcomm Technologies Proprietary and Confidential.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

#import "LumicastSdk/Position.h"
#import "LumicastSdk/Angle.h"

@protocol LumicastEventListener;

/*!
 * @class LumicastSdk
 * @brief This class provides access to the Qualcomm Lumicast indoor positioning system.
 * @discussion This class communicates with the application by way of the callbacks defined in the 
 * {@link LumicastEventListener} protocol. 
 * @version 2.1.0
 */
// TBD
//* The recommended usage is as follows:
//* <ul>
//* <li>test 1</li>
//* <li>test 2 </li>
//* </ul>
@interface LumicastSdk: NSObject
{
    
}


/*!
 * @brief The {@link LumicastEventListener} delegate
 */
@property (weak, nonatomic)id<LumicastEventListener> delegate;


/*!
 * @brief Initializer
 * @return the object
 * <br><br>Example:<br>
 * <pre><code>
 * mLumicastSdk = [[LumicastSdk alloc] init];
 * mLumicastSdk.delegate = self;
 * </code></pre>
 */
-(id)init;

/*!
 * @brief Initialize the Lumicast SDK. You must eait for the onLumicastInitialized callback before calling additional Lumicast SDK methods.
 * @param CID the CID assigned by Lumicast
 * @param EID the EID assigned by Lumicast
 * @param configTag an optional tag, used to select a different configuration. Specify as nil for default.
 * @param lights (x,y,z) coordinates of light fixtures in the venue, relative to the venue’s coordinate system. (JSON)
 * @param error Output parameter. Populated on error.
 * @return none
 * <br><br>Example:<br>
 * <pre><code>
 * NSError* error = nil;
 * if (![mLumicastSdk initialize:CID configTag:nil lights:jsonLights error:&error]) {
 *     // handle error in error - see error.localizedDescription and error.code (defined in LumicastErrors.h)
 * }
 * </code></pre>
 */
-(bool)initialize:(NSString*)CID EID:(NSString*)EID configTag:(NSString*)configTag lights:(NSString*)lights  error:(NSError**)error;

/*!
 * @brief Initialize the Lumicast SDK for simulation mode.
 * @discussion This mode feeds positions from the specified simulationData rather than determining the
 * location using VLC. A documented sample file is provided in the SDK package.
 * @param simulationData a string containing the simulation data
 * @param error Output parameter. Populated on error.
 * @return none
 * <br><br>Example:<br>
 * <pre><code>
 * NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 * NSString* documentsPath = [paths objectAtIndex:0];
 * NSString *fileName = [documentsPath stringByAppendingPathComponent:@"testPositions.json"];
 * BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:(fileName)];
 * if (exist == NO) {
 *     NSLog(@"Can't find testPositions.json: %@", fileName);
 *     return;
 * }
 * NSString* data = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
 * NSError* error = nil;
 * if (![mLumicastSdk initializeSimulationMode:data error:&error]) {
 *     // handle error in error - see error.localizedDescription and error.code (defined in LumicastErrors.h)
 * }
 * </code></pre>
 */
-(bool)initializeSimulationMode:(NSString*) simulationData  error:(NSError**)error;

/*!
 * @brief Terminate the Lumicast SDK. * @param error Output parameter. Populated on error.
 * @return none
 * <br><br>Example:<br>
 * <pre><code>
 * [mLumicastSdk terminate];
 * </code></pre>
 */
-(void)terminate;

/*!
 * @brief Enable foreground positioning. This should be called when your app goes into the foreground.
 * @param error Output parameter. Populated on error.
 * @return none
 * <br><br>Example:<br>
 * <pre><code>
 * NSError* error = nil;
 * if (![mLumicastSdk enableForegroundPositioning error:&error]) {
 *     // handle error in error - see error.localizedDescription and error.code (defined in LumicastErrors.h)
 * }
 * </code></pre>
 */
-(bool)enableForegroundPositioning:(NSError**)error;

/*!
 * @brief Disable foreground positioning. This should be called when your app leaves the foreground.
 * @param error Output parameter. Populated on error.
 * @return none
 * <br><br>Example:<br>
 * <pre><code>
 * NSError* error = nil;
 * if (![mLumicastSdk disableForegroundPositioning error:&error]) {
 *     // handle error in error - see error.localizedDescription and error.code (defined in LumicastErrors.h)
 * }
 * </code></pre>
 */
-(bool)disableForegroundPositioning:(NSError**)error;


/*!
 * @brief Enable background positioning. This should be called when your app goes into the background.
 * @param error Output parameter. Populated on error.
 * @return none
 * <br><br>Example:<br>
 * <pre><code>
 * NSError* error = nil;
 * if (![mLumicastSdk enableBackgroundPositioning error:&error]) {
 *     // handle error in error - see error.localizedDescription and error.code (defined in LumicastErrors.h)
 * }
 * </code></pre>
 */
-(bool)enableBackgroundPositioning:(NSError**)error;

/*!
 * @brief Disable background positioning. This should be called when your app leaves the background.
 * @param error Output parameter. Populated on error.
 * @return none
 * <br><br>Example:<br>
 * <pre><code>
 * NSError* error = nil;
 * if (![mLumicastSdk disableBackgroundPositioning error:&error]) {
 *     // handle error in error - see error.localizedDescription and error.code (defined in LumicastErrors.h)
 * }
 * </code></pre>
 */

-(bool)disableBackgroundPositioning:(NSError**)error;

/*!
 * @brief Return the SDK build info.
 * @return The build info as a JSON object. Contains the tags rev, date, and version.
 * <br><br>Example:<br>
 * 
 * <tt>
 * const NSDictionary* buildInfo = [mLumicastSdk buildInfo];
 * </tt>
 * 
 */
-(const NSDictionary*) buildInfo;

/*!
 * @brief Return the codeword of the fixture closest to the center of the screen.
 * @return The codeword of the fixture closest to the center of the screen. Note that codewords <= 0 may be returned
 * occasionally and indicates a decoding failure.
 * <br><br>Example:<br>
 * 
 * <tt>
 * int cw = [mLumicastSdk getCentralFixtureCodeword];
 * </tt>
 * 
 */
#if LUMICAST_DEMO_MODE != 1
-(int)getCentralFixtureCodeword;
#endif

/*!
 * @brief Set the fixture codeword.
 * @discussion Use of this feature requires that each fixture has a unique "tag" specified in the lights configuration passed to enableVlc.
 * @param tag the fixture tag
 * @param id the codeword id
 * @return none
 * <br><br>Example:<br>
 * 
 * <tt>
 * [mLumicastSdk setFixtureCodeword:tag id:id];
 * </tt>
 * 
 */
#if LUMICAST_DEMO_MODE != 1
-(void)setFixtureCodeword:(NSString*)tag id:(int)id;
#endif

/*!
 * @brief Set the fixture position.
 * @discussion Use of this feature requires that each fixture has a unique "tag" specified in the lights configuration passed to enableVlc.
 * @param tag the fixture tag
 * @param x1 the x position of corner 1
 * @param y1 the y position of corner 1
 * @param x2 the x position of corner 2
 * @param y2 the y position of corner 2
 * @param x3 the x position of corner 3
 * @param y3 the y position of corner 3
 * @param z the z position
 * @return none
 * <br><br>Example:<br>
 * 
 * <tt>
 * [mLumicastSdk setFixturePosition x1:x1 y1:y1 x2:x2 y2:y2 x3:x3 y3:y3 z:z];
 * </tt>
 * 
 */
#if LUMICAST_DEMO_MODE != 1
-(void)setFixturePosition:(NSString*)tag x1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 x3:(float)x3 y3:(float)y3 z:(float)z;
#endif


@end

/*!
 * @protocol LumicastEventListener
 * @brief The protocol for receiving Lumicast events
 */
@protocol LumicastEventListener<NSObject>

/*!
 * @brief Called when Lumicast has been initialized or initialization fails.
 * @param success True on success, false on failure.
 * @param resultString On failure, this is a text string that describes the reason.
 */
-(void)onLumicastInitialized:(bool)success resultString:(NSString*)resultString;

/*!
 * @brief Called for each Lumicast position fix.
 * @param position The position. Will be null in VLC outage.
 * @param angle The orientation of the mobile. May be null.
 */
-(void)onLumicastPositionUpdate:(Position*)position angle:(Angle*)angle;

/*!
 * @brief Called on a Lumicast error.
 * @param error A human-readable error.
 */
-(void)onLumicastError:(NSString*)error;


@end
