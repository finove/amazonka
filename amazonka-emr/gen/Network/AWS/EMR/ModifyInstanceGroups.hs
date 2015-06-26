{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.EMR.ModifyInstanceGroups
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

-- | ModifyInstanceGroups modifies the number of nodes and configuration
-- settings of an instance group. The input parameters include the new
-- target instance count for the group and the instance group ID. The call
-- will either succeed or fail atomically.
--
-- <http://docs.aws.amazon.com/ElasticMapReduce/latest/API/API_ModifyInstanceGroups.html>
module Network.AWS.EMR.ModifyInstanceGroups
    (
    -- * Request
      ModifyInstanceGroups
    -- ** Request constructor
    , modifyInstanceGroups
    -- ** Request lenses
    , migInstanceGroups

    -- * Response
    , ModifyInstanceGroupsResponse
    -- ** Response constructor
    , modifyInstanceGroupsResponse
    ) where

import Network.AWS.EMR.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | Change the size of some instance groups.
--
-- /See:/ 'modifyInstanceGroups' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'migInstanceGroups'
newtype ModifyInstanceGroups = ModifyInstanceGroups'{_migInstanceGroups :: Maybe [InstanceGroupModifyConfig]} deriving (Eq, Read, Show)

-- | 'ModifyInstanceGroups' smart constructor.
modifyInstanceGroups :: ModifyInstanceGroups
modifyInstanceGroups = ModifyInstanceGroups'{_migInstanceGroups = Nothing};

-- | Instance groups to change.
migInstanceGroups :: Lens' ModifyInstanceGroups [InstanceGroupModifyConfig]
migInstanceGroups = lens _migInstanceGroups (\ s a -> s{_migInstanceGroups = a}) . _Default;

instance AWSRequest ModifyInstanceGroups where
        type Sv ModifyInstanceGroups = EMR
        type Rs ModifyInstanceGroups =
             ModifyInstanceGroupsResponse
        request = postJSON
        response = receiveNull ModifyInstanceGroupsResponse'

instance ToHeaders ModifyInstanceGroups where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("ElasticMapReduce.ModifyInstanceGroups" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ModifyInstanceGroups where
        toJSON ModifyInstanceGroups'{..}
          = object ["InstanceGroups" .= _migInstanceGroups]

instance ToPath ModifyInstanceGroups where
        toPath = const "/"

instance ToQuery ModifyInstanceGroups where
        toQuery = const mempty

-- | /See:/ 'modifyInstanceGroupsResponse' smart constructor.
data ModifyInstanceGroupsResponse = ModifyInstanceGroupsResponse' deriving (Eq, Read, Show)

-- | 'ModifyInstanceGroupsResponse' smart constructor.
modifyInstanceGroupsResponse :: ModifyInstanceGroupsResponse
modifyInstanceGroupsResponse = ModifyInstanceGroupsResponse';
