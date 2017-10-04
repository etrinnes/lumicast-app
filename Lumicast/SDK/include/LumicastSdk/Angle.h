//
//  Angle.h
//  LumicastSdk
//
//  Created by Elizabeth Gene on 12/12/14.
//  Copyright (c) 2015 Qualcomm Technologies, Inc. All rights reserved.
//  Qualcomm Technologies Proprietary and Confidential.
//

/*!
 * @class Angle
 * @brief The angle class. 
 * @discussion The orientation of the mobile in the X-Y plane in degrees or radians, relative to the Y-axis of the venue’s coordinate system.
 * <img src="angle.png">
 */
@interface Angle : NSObject
{
}

/*!
 * @brief The angle in radians.
 */
@property (nonatomic, getter=getAngleInRadians, setter=setAngle:) float radians;

/*!
 * @brief The time at which the orientation was determined in Epoch timestamp with milliseconds
 */
@property (nonatomic, readonly) uint64_t timestamp;


/*!
 * @brief Initialize with an angle
 * @param angle The angle in radians
 * @param timestamp The time at which the orientation was determined in Epoch timestamp with milliseconds
 * @return The object
 */
- (id) initWithAngle:(float)angle timestamp:(uint64_t)timestamp;

/*!
 * @brief Get the angle in degrees
 * @return the angle in degrees
 */
-(float)getAngleInDegrees;

/*!
 * @brief Return a string containing a human readable description of the object contents
 * @return the string
 */
-(NSString*)toString;



@end
