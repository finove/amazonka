{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.ElasticTranscoder.UpdatePipelineStatus
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

-- | The UpdatePipelineStatus operation pauses or reactivates a pipeline, so
-- that the pipeline stops or restarts the processing of jobs.
--
-- Changing the pipeline status is useful if you want to cancel one or more
-- jobs. You can\'t cancel jobs after Elastic Transcoder has started
-- processing them; if you pause the pipeline to which you submitted the
-- jobs, you have more time to get the job IDs for the jobs that you want
-- to cancel, and to send a CancelJob request.
--
-- <http://docs.aws.amazon.com/elastictranscoder/latest/developerguide/UpdatePipelineStatus.html>
module Network.AWS.ElasticTranscoder.UpdatePipelineStatus
    (
    -- * Request
      UpdatePipelineStatus
    -- ** Request constructor
    , updatePipelineStatus
    -- ** Request lenses
    , upsId
    , upsStatus

    -- * Response
    , UpdatePipelineStatusResponse
    -- ** Response constructor
    , updatePipelineStatusResponse
    -- ** Response lenses
    , upsrPipeline
    , upsrStatusCode
    ) where

import Network.AWS.ElasticTranscoder.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | The @UpdatePipelineStatusRequest@ structure.
--
-- /See:/ 'updatePipelineStatus' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'upsId'
--
-- * 'upsStatus'
data UpdatePipelineStatus = UpdatePipelineStatus'{_upsId :: Text, _upsStatus :: Text} deriving (Eq, Read, Show)

-- | 'UpdatePipelineStatus' smart constructor.
updatePipelineStatus :: Text -> Text -> UpdatePipelineStatus
updatePipelineStatus pId pStatus = UpdatePipelineStatus'{_upsId = pId, _upsStatus = pStatus};

-- | The identifier of the pipeline to update.
upsId :: Lens' UpdatePipelineStatus Text
upsId = lens _upsId (\ s a -> s{_upsId = a});

-- | The desired status of the pipeline:
--
-- -   @Active@: The pipeline is processing jobs.
-- -   @Paused@: The pipeline is not currently processing jobs.
upsStatus :: Lens' UpdatePipelineStatus Text
upsStatus = lens _upsStatus (\ s a -> s{_upsStatus = a});

instance AWSRequest UpdatePipelineStatus where
        type Sv UpdatePipelineStatus = ElasticTranscoder
        type Rs UpdatePipelineStatus =
             UpdatePipelineStatusResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 UpdatePipelineStatusResponse' <$>
                   (x .?> "Pipeline") <*> (pure (fromEnum s)))

instance ToHeaders UpdatePipelineStatus where
        toHeaders = const mempty

instance ToJSON UpdatePipelineStatus where
        toJSON UpdatePipelineStatus'{..}
          = object ["Status" .= _upsStatus]

instance ToPath UpdatePipelineStatus where
        toPath UpdatePipelineStatus'{..}
          = mconcat
              ["/2012-09-25/pipelines/", toText _upsId, "/status"]

instance ToQuery UpdatePipelineStatus where
        toQuery = const mempty

-- | When you update status for a pipeline, Elastic Transcoder returns the
-- values that you specified in the request.
--
-- /See:/ 'updatePipelineStatusResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'upsrPipeline'
--
-- * 'upsrStatusCode'
data UpdatePipelineStatusResponse = UpdatePipelineStatusResponse'{_upsrPipeline :: Maybe Pipeline, _upsrStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'UpdatePipelineStatusResponse' smart constructor.
updatePipelineStatusResponse :: Int -> UpdatePipelineStatusResponse
updatePipelineStatusResponse pStatusCode = UpdatePipelineStatusResponse'{_upsrPipeline = Nothing, _upsrStatusCode = pStatusCode};

-- | A section of the response body that provides information about the
-- pipeline.
upsrPipeline :: Lens' UpdatePipelineStatusResponse (Maybe Pipeline)
upsrPipeline = lens _upsrPipeline (\ s a -> s{_upsrPipeline = a});

-- | FIXME: Undocumented member.
upsrStatusCode :: Lens' UpdatePipelineStatusResponse Int
upsrStatusCode = lens _upsrStatusCode (\ s a -> s{_upsrStatusCode = a});
