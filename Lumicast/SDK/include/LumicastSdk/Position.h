//
//  Position.h
//  Lumicast
//  Based on Position.java from Android LumicastSdk Project
//
//  Created by Ken Vavreck on 9/3/14.
//  Copyright (c) 2015 Qualcomm Technologies, Inc.  All Rights Reserved.
//  Qualcomm Technologies Proprietary and Confidential.
//

#import <Foundation/Foundation.h>

/*!
 * A VLC position.
 */
extern const int TYPE_VLC;

/*!
 * An AUX position.
 */
extern const int TYPE_AUX;

/*!
 * @class Position
 * @brief The Position class. 
 * @discussion The (x,y,z) Position of the mobile, relative to the venue’s coordinate system. Note that z is for future use.
 * <img src="location.png">
 */
@interface Position : NSObject {

}

/*!
 * @brief The position type (TYPE_VLC or TYPE_AUX)
 */
@property (nonatomic, readwrite) int type;

/*!
 * @brief The id of the map containing the position.
 */
@property (nonatomic, readwrite) short mapId;

/*!
 * @brief The position x in meters, relative to the (0,0) corner of the map
 */
@property (nonatomic, readwrite) float x;

/*!
 * @brief The position y in meters, relative to the (0,0) corner of the map
 */
@property (nonatomic, readwrite) float y;

/*!
 * @brief The position z in meters, relative to the ceiling. For future use.
 */
@property (nonatomic, readwrite) float z;

/*!
 * @brief The time at which the position was determined in Epoch timestamp with milliseconds
 */
@property (nonatomic, readwrite) uint64_t timestamp;


/*!
 * @brief Initializer
 * @param type The type (TYPE_VLC or TYPE_AUX).
 * @param mapId The id of the map containing the position. For future use.
 * @param x The position x in meters, relative to the (0,0) corner of the map
 * @param y The position y in meters, relative to the (0,0) corner of the map
 * @param z The position z in meters, relative to the ceiling. For future use.
 * @param timestamp The time at which the position was determined in Epoch timestamp with milliseconds
 * @return the object
 */
-(id)initPosition:(int)type mapId:(short)mapId x:(float)x y:(float)y z:(float)z timestamp:(uint64_t)timestamp;

/*!
 * @brief Initialize from another Position
 * @param loc the position
 * @return the object
 */
-(id)initWithPosition:(Position*)loc;

/*!
 * @brief copies all data from another Position
 * @param loc the position
 */
-(void)setPosition:(Position*)loc;


/*!
 * @brief returns a human-readable description of the contents of the object
 * @return the string
 */
-(NSString*)toString;


/*!
 * @brief returns the current system time (Epoch time with milliseconds)
 * @return the timestamp
 */
+(uint64_t)getSystemTimestamp;


@end

