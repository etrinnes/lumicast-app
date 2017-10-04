//
//  LumicastErrors.h
//  LumicastSdk
//
//  Created by Elizabeth Gene on 6/21/16.
//  Copyright © 2016 Qualcomm Technologies, Inc. All rights reserved.
//

#ifndef LumicastErrors_h
#define LumicastErrors_h

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString* const LumicastErrorDomain;

/*!
 * @enum Codes used in Lumicast NSError return parameters.
 * @constant LumicastErrorLights Error in lights map configuration
 * @constant LumicastErrorCodebook Error in codebook configuration
 * @constant LumicastErrorMobileConfig Error in mobile config configuration
 * @constant LumicastErrorMissingCID CID was not supplied
 * @constant LumicastErrorMissingEID EID was not supplied
 * @constant LumicastUnsupportedDevice Attempt to use an unsupported device
 * @constant LumicastUnsupportedFixture Attempt to use an unsupported fixture
 * @constant LumicastAuxPositioningNotConfigured Auxiliary positioning is not configured
 * @constant LumicastAuxPositioningNotSupported Auxiliary positioning is not supported by the device
 * @constant LumicastNotInitialized Lumicast must be initialized prior to calling this method
 * @constant LumicastSimOnly Lumicast Simulation Only SDK -- can not use initialize method must use initializeSimulationMode
 */
enum {
    LumicastErrorLights,
    LumicastErrorCodebook,
    LumicastErrorMobileConfig,
    LumicastErrorMissingCID,
    LumicastErrorMissingEID,
    LumicastUnsupportedDevice,
    LumicastUnsupportedFixture,
    LumicastAuxPositioningNotConfigured,
    LumicastAuxPositioningNotSupported,
    LumicastNotInitialized,
    LumicastSimOnly
};

#endif /* LumicastErrors_h */
