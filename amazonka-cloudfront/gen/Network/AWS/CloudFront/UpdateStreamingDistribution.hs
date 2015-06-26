{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.CloudFront.UpdateStreamingDistribution
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

-- | Update a streaming distribution.
--
-- <http://docs.aws.amazon.com/AmazonCloudFront/latest/APIReference/UpdateStreamingDistribution.html>
module Network.AWS.CloudFront.UpdateStreamingDistribution
    (
    -- * Request
      UpdateStreamingDistribution
    -- ** Request constructor
    , updateStreamingDistribution
    -- ** Request lenses
    , usdIfMatch
    , usdStreamingDistributionConfig
    , usdId

    -- * Response
    , UpdateStreamingDistributionResponse
    -- ** Response constructor
    , updateStreamingDistributionResponse
    -- ** Response lenses
    , usdrETag
    , usdrStreamingDistribution
    , usdrStatusCode
    ) where

import Network.AWS.CloudFront.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | The request to update a streaming distribution.
--
-- /See:/ 'updateStreamingDistribution' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'usdIfMatch'
--
-- * 'usdStreamingDistributionConfig'
--
-- * 'usdId'
data UpdateStreamingDistribution = UpdateStreamingDistribution'{_usdIfMatch :: Maybe Text, _usdStreamingDistributionConfig :: StreamingDistributionConfig, _usdId :: Text} deriving (Eq, Read, Show)

-- | 'UpdateStreamingDistribution' smart constructor.
updateStreamingDistribution :: StreamingDistributionConfig -> Text -> UpdateStreamingDistribution
updateStreamingDistribution pStreamingDistributionConfig pId = UpdateStreamingDistribution'{_usdIfMatch = Nothing, _usdStreamingDistributionConfig = pStreamingDistributionConfig, _usdId = pId};

-- | The value of the ETag header you received when retrieving the streaming
-- distribution\'s configuration. For example: E2QWRUHAPOMQZL.
usdIfMatch :: Lens' UpdateStreamingDistribution (Maybe Text)
usdIfMatch = lens _usdIfMatch (\ s a -> s{_usdIfMatch = a});

-- | The streaming distribution\'s configuration information.
usdStreamingDistributionConfig :: Lens' UpdateStreamingDistribution StreamingDistributionConfig
usdStreamingDistributionConfig = lens _usdStreamingDistributionConfig (\ s a -> s{_usdStreamingDistributionConfig = a});

-- | The streaming distribution\'s id.
usdId :: Lens' UpdateStreamingDistribution Text
usdId = lens _usdId (\ s a -> s{_usdId = a});

instance AWSRequest UpdateStreamingDistribution where
        type Sv UpdateStreamingDistribution = CloudFront
        type Rs UpdateStreamingDistribution =
             UpdateStreamingDistributionResponse
        request = putXML
        response
          = receiveXML
              (\ s h x ->
                 UpdateStreamingDistributionResponse' <$>
                   (h .#? "ETag") <*> (x .@? "StreamingDistribution")
                     <*> (pure (fromEnum s)))

instance ToElement UpdateStreamingDistribution where
        toElement
          = mkElement
              "{http://cloudfront.amazonaws.com/doc/2014-11-06/}StreamingDistributionConfig"
              .
              _usdStreamingDistributionConfig

instance ToHeaders UpdateStreamingDistribution where
        toHeaders UpdateStreamingDistribution'{..}
          = mconcat ["If-Match" =# _usdIfMatch]

instance ToPath UpdateStreamingDistribution where
        toPath UpdateStreamingDistribution'{..}
          = mconcat
              ["/2014-11-06/streaming-distribution/",
               toText _usdId, "/config"]

instance ToQuery UpdateStreamingDistribution where
        toQuery = const mempty

-- | The returned result of the corresponding request.
--
-- /See:/ 'updateStreamingDistributionResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'usdrETag'
--
-- * 'usdrStreamingDistribution'
--
-- * 'usdrStatusCode'
data UpdateStreamingDistributionResponse = UpdateStreamingDistributionResponse'{_usdrETag :: Maybe Text, _usdrStreamingDistribution :: Maybe StreamingDistribution, _usdrStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'UpdateStreamingDistributionResponse' smart constructor.
updateStreamingDistributionResponse :: Int -> UpdateStreamingDistributionResponse
updateStreamingDistributionResponse pStatusCode = UpdateStreamingDistributionResponse'{_usdrETag = Nothing, _usdrStreamingDistribution = Nothing, _usdrStatusCode = pStatusCode};

-- | The current version of the configuration. For example: E2QWRUHAPOMQZL.
usdrETag :: Lens' UpdateStreamingDistributionResponse (Maybe Text)
usdrETag = lens _usdrETag (\ s a -> s{_usdrETag = a});

-- | The streaming distribution\'s information.
usdrStreamingDistribution :: Lens' UpdateStreamingDistributionResponse (Maybe StreamingDistribution)
usdrStreamingDistribution = lens _usdrStreamingDistribution (\ s a -> s{_usdrStreamingDistribution = a});

-- | FIXME: Undocumented member.
usdrStatusCode :: Lens' UpdateStreamingDistributionResponse Int
usdrStatusCode = lens _usdrStatusCode (\ s a -> s{_usdrStatusCode = a});
