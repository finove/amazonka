{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.EMR.ListBootstrapActions
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

-- | Provides information about the bootstrap actions associated with a
-- cluster.
--
-- <http://docs.aws.amazon.com/ElasticMapReduce/latest/API/API_ListBootstrapActions.html>
module Network.AWS.EMR.ListBootstrapActions
    (
    -- * Request
      ListBootstrapActions
    -- ** Request constructor
    , listBootstrapActions
    -- ** Request lenses
    , lbaMarker
    , lbaClusterId

    -- * Response
    , ListBootstrapActionsResponse
    -- ** Response constructor
    , listBootstrapActionsResponse
    -- ** Response lenses
    , lbarBootstrapActions
    , lbarMarker
    , lbarStatusCode
    ) where

import Network.AWS.EMR.Types
import Network.AWS.Pager
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | This input determines which bootstrap actions to retrieve.
--
-- /See:/ 'listBootstrapActions' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lbaMarker'
--
-- * 'lbaClusterId'
data ListBootstrapActions = ListBootstrapActions'{_lbaMarker :: Maybe Text, _lbaClusterId :: Text} deriving (Eq, Read, Show)

-- | 'ListBootstrapActions' smart constructor.
listBootstrapActions :: Text -> ListBootstrapActions
listBootstrapActions pClusterId = ListBootstrapActions'{_lbaMarker = Nothing, _lbaClusterId = pClusterId};

-- | The pagination token that indicates the next set of results to retrieve
-- .
lbaMarker :: Lens' ListBootstrapActions (Maybe Text)
lbaMarker = lens _lbaMarker (\ s a -> s{_lbaMarker = a});

-- | The cluster identifier for the bootstrap actions to list .
lbaClusterId :: Lens' ListBootstrapActions Text
lbaClusterId = lens _lbaClusterId (\ s a -> s{_lbaClusterId = a});

instance AWSPager ListBootstrapActions where
        page rq rs
          | stop (rs ^. lbarMarker) = Nothing
          | stop (rs ^. lbarBootstrapActions) = Nothing
          | otherwise =
            Just $ rq & lbaMarker .~ rs ^. lbarMarker

instance AWSRequest ListBootstrapActions where
        type Sv ListBootstrapActions = EMR
        type Rs ListBootstrapActions =
             ListBootstrapActionsResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ListBootstrapActionsResponse' <$>
                   (x .?> "BootstrapActions" .!@ mempty) <*>
                     (x .?> "Marker")
                     <*> (pure (fromEnum s)))

instance ToHeaders ListBootstrapActions where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("ElasticMapReduce.ListBootstrapActions" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListBootstrapActions where
        toJSON ListBootstrapActions'{..}
          = object
              ["Marker" .= _lbaMarker,
               "ClusterId" .= _lbaClusterId]

instance ToPath ListBootstrapActions where
        toPath = const "/"

instance ToQuery ListBootstrapActions where
        toQuery = const mempty

-- | This output contains the boostrap actions detail .
--
-- /See:/ 'listBootstrapActionsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lbarBootstrapActions'
--
-- * 'lbarMarker'
--
-- * 'lbarStatusCode'
data ListBootstrapActionsResponse = ListBootstrapActionsResponse'{_lbarBootstrapActions :: Maybe [Command], _lbarMarker :: Maybe Text, _lbarStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'ListBootstrapActionsResponse' smart constructor.
listBootstrapActionsResponse :: Int -> ListBootstrapActionsResponse
listBootstrapActionsResponse pStatusCode = ListBootstrapActionsResponse'{_lbarBootstrapActions = Nothing, _lbarMarker = Nothing, _lbarStatusCode = pStatusCode};

-- | The bootstrap actions associated with the cluster .
lbarBootstrapActions :: Lens' ListBootstrapActionsResponse [Command]
lbarBootstrapActions = lens _lbarBootstrapActions (\ s a -> s{_lbarBootstrapActions = a}) . _Default;

-- | The pagination token that indicates the next set of results to retrieve
-- .
lbarMarker :: Lens' ListBootstrapActionsResponse (Maybe Text)
lbarMarker = lens _lbarMarker (\ s a -> s{_lbarMarker = a});

-- | FIXME: Undocumented member.
lbarStatusCode :: Lens' ListBootstrapActionsResponse Int
lbarStatusCode = lens _lbarStatusCode (\ s a -> s{_lbarStatusCode = a});
