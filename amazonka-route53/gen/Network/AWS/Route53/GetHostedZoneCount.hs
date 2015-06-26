{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.Route53.GetHostedZoneCount
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | To retrieve a count of all your hosted zones, send a @GET@ request to
-- the @2013-04-01\/hostedzonecount@ resource.
--
-- <http://docs.aws.amazon.com/Route53/latest/APIReference/API_GetHostedZoneCount.html>
module Network.AWS.Route53.GetHostedZoneCount
    (
    -- * Request
      GetHostedZoneCount
    -- ** Request constructor
    , getHostedZoneCount

    -- * Response
    , GetHostedZoneCountResponse
    -- ** Response constructor
    , getHostedZoneCountResponse
    -- ** Response lenses
    , ghzcrHostedZoneCount
    , ghzcrStatusCode
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response
import Network.AWS.Route53.Types

-- | To retrieve a count of all your hosted zones, send a @GET@ request to
-- the @2013-04-01\/hostedzonecount@ resource.
--
-- /See:/ 'getHostedZoneCount' smart constructor.
data GetHostedZoneCount = GetHostedZoneCount' deriving (Eq, Read, Show)

-- | 'GetHostedZoneCount' smart constructor.
getHostedZoneCount :: GetHostedZoneCount
getHostedZoneCount = GetHostedZoneCount';

instance AWSRequest GetHostedZoneCount where
        type Sv GetHostedZoneCount = Route53
        type Rs GetHostedZoneCount =
             GetHostedZoneCountResponse
        request = get
        response
          = receiveXML
              (\ s h x ->
                 GetHostedZoneCountResponse' <$>
                   (x .@ "HostedZoneCount") <*> (pure (fromEnum s)))

instance ToHeaders GetHostedZoneCount where
        toHeaders = const mempty

instance ToPath GetHostedZoneCount where
        toPath = const "/2013-04-01/hostedzonecount"

instance ToQuery GetHostedZoneCount where
        toQuery = const mempty

-- | A complex type that contains the count of hosted zones associated with
-- the current AWS account.
--
-- /See:/ 'getHostedZoneCountResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ghzcrHostedZoneCount'
--
-- * 'ghzcrStatusCode'
data GetHostedZoneCountResponse = GetHostedZoneCountResponse'{_ghzcrHostedZoneCount :: Integer, _ghzcrStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'GetHostedZoneCountResponse' smart constructor.
getHostedZoneCountResponse :: Integer -> Int -> GetHostedZoneCountResponse
getHostedZoneCountResponse pHostedZoneCount pStatusCode = GetHostedZoneCountResponse'{_ghzcrHostedZoneCount = pHostedZoneCount, _ghzcrStatusCode = pStatusCode};

-- | The number of hosted zones associated with the current AWS account.
ghzcrHostedZoneCount :: Lens' GetHostedZoneCountResponse Integer
ghzcrHostedZoneCount = lens _ghzcrHostedZoneCount (\ s a -> s{_ghzcrHostedZoneCount = a});

-- | FIXME: Undocumented member.
ghzcrStatusCode :: Lens' GetHostedZoneCountResponse Int
ghzcrStatusCode = lens _ghzcrStatusCode (\ s a -> s{_ghzcrStatusCode = a});
