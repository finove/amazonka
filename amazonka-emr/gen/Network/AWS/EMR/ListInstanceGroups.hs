{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.EMR.ListInstanceGroups
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

-- | Provides all available details about the instance groups in a cluster.
--
-- <http://docs.aws.amazon.com/ElasticMapReduce/latest/API/API_ListInstanceGroups.html>
module Network.AWS.EMR.ListInstanceGroups
    (
    -- * Request
      ListInstanceGroups
    -- ** Request constructor
    , listInstanceGroups
    -- ** Request lenses
    , ligMarker
    , ligClusterId

    -- * Response
    , ListInstanceGroupsResponse
    -- ** Response constructor
    , listInstanceGroupsResponse
    -- ** Response lenses
    , ligrMarker
    , ligrInstanceGroups
    , ligrStatusCode
    ) where

import Network.AWS.EMR.Types
import Network.AWS.Pager
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | This input determines which instance groups to retrieve.
--
-- /See:/ 'listInstanceGroups' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ligMarker'
--
-- * 'ligClusterId'
data ListInstanceGroups = ListInstanceGroups'{_ligMarker :: Maybe Text, _ligClusterId :: Text} deriving (Eq, Read, Show)

-- | 'ListInstanceGroups' smart constructor.
listInstanceGroups :: Text -> ListInstanceGroups
listInstanceGroups pClusterId = ListInstanceGroups'{_ligMarker = Nothing, _ligClusterId = pClusterId};

-- | The pagination token that indicates the next set of results to retrieve.
ligMarker :: Lens' ListInstanceGroups (Maybe Text)
ligMarker = lens _ligMarker (\ s a -> s{_ligMarker = a});

-- | The identifier of the cluster for which to list the instance groups.
ligClusterId :: Lens' ListInstanceGroups Text
ligClusterId = lens _ligClusterId (\ s a -> s{_ligClusterId = a});

instance AWSPager ListInstanceGroups where
        page rq rs
          | stop (rs ^. ligrMarker) = Nothing
          | stop (rs ^. ligrInstanceGroups) = Nothing
          | otherwise =
            Just $ rq & ligMarker .~ rs ^. ligrMarker

instance AWSRequest ListInstanceGroups where
        type Sv ListInstanceGroups = EMR
        type Rs ListInstanceGroups =
             ListInstanceGroupsResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ListInstanceGroupsResponse' <$>
                   (x .?> "Marker") <*>
                     (x .?> "InstanceGroups" .!@ mempty)
                     <*> (pure (fromEnum s)))

instance ToHeaders ListInstanceGroups where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("ElasticMapReduce.ListInstanceGroups" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListInstanceGroups where
        toJSON ListInstanceGroups'{..}
          = object
              ["Marker" .= _ligMarker,
               "ClusterId" .= _ligClusterId]

instance ToPath ListInstanceGroups where
        toPath = const "/"

instance ToQuery ListInstanceGroups where
        toQuery = const mempty

-- | This input determines which instance groups to retrieve.
--
-- /See:/ 'listInstanceGroupsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ligrMarker'
--
-- * 'ligrInstanceGroups'
--
-- * 'ligrStatusCode'
data ListInstanceGroupsResponse = ListInstanceGroupsResponse'{_ligrMarker :: Maybe Text, _ligrInstanceGroups :: Maybe [InstanceGroup], _ligrStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'ListInstanceGroupsResponse' smart constructor.
listInstanceGroupsResponse :: Int -> ListInstanceGroupsResponse
listInstanceGroupsResponse pStatusCode = ListInstanceGroupsResponse'{_ligrMarker = Nothing, _ligrInstanceGroups = Nothing, _ligrStatusCode = pStatusCode};

-- | The pagination token that indicates the next set of results to retrieve.
ligrMarker :: Lens' ListInstanceGroupsResponse (Maybe Text)
ligrMarker = lens _ligrMarker (\ s a -> s{_ligrMarker = a});

-- | The list of instance groups for the cluster and given filters.
ligrInstanceGroups :: Lens' ListInstanceGroupsResponse [InstanceGroup]
ligrInstanceGroups = lens _ligrInstanceGroups (\ s a -> s{_ligrInstanceGroups = a}) . _Default;

-- | FIXME: Undocumented member.
ligrStatusCode :: Lens' ListInstanceGroupsResponse Int
ligrStatusCode = lens _ligrStatusCode (\ s a -> s{_ligrStatusCode = a});
