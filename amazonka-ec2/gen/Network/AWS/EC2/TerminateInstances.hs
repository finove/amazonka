{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.EC2.TerminateInstances
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

-- | Shuts down one or more instances. This operation is idempotent; if you
-- terminate an instance more than once, each call succeeds.
--
-- Terminated instances remain visible after termination (for approximately
-- one hour).
--
-- By default, Amazon EC2 deletes all EBS volumes that were attached when
-- the instance launched. Volumes attached after instance launch continue
-- running.
--
-- You can stop, start, and terminate EBS-backed instances. You can only
-- terminate instance store-backed instances. What happens to an instance
-- differs if you stop it or terminate it. For example, when you stop an
-- instance, the root device and any other devices attached to the instance
-- persist. When you terminate an instance, the root device and any other
-- devices attached during the instance launch are automatically deleted.
-- For more information about the differences between stopping and
-- terminating instances, see
-- <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html Instance Lifecycle>
-- in the /Amazon Elastic Compute Cloud User Guide/.
--
-- For more information about troubleshooting, see
-- <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesShuttingDown.html Troubleshooting Terminating Your Instance>
-- in the /Amazon Elastic Compute Cloud User Guide/.
--
-- <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-TerminateInstances.html>
module Network.AWS.EC2.TerminateInstances
    (
    -- * Request
      TerminateInstances
    -- ** Request constructor
    , terminateInstances
    -- ** Request lenses
    , tiDryRun
    , tiInstanceIds

    -- * Response
    , TerminateInstancesResponse
    -- ** Response constructor
    , terminateInstancesResponse
    -- ** Response lenses
    , tirTerminatingInstances
    , tirStatusCode
    ) where

import Network.AWS.EC2.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'terminateInstances' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'tiDryRun'
--
-- * 'tiInstanceIds'
data TerminateInstances = TerminateInstances'{_tiDryRun :: Maybe Bool, _tiInstanceIds :: [Text]} deriving (Eq, Read, Show)

-- | 'TerminateInstances' smart constructor.
terminateInstances :: TerminateInstances
terminateInstances = TerminateInstances'{_tiDryRun = Nothing, _tiInstanceIds = mempty};

-- | Checks whether you have the required permissions for the action, without
-- actually making the request, and provides an error response. If you have
-- the required permissions, the error response is @DryRunOperation@.
-- Otherwise, it is @UnauthorizedOperation@.
tiDryRun :: Lens' TerminateInstances (Maybe Bool)
tiDryRun = lens _tiDryRun (\ s a -> s{_tiDryRun = a});

-- | One or more instance IDs.
tiInstanceIds :: Lens' TerminateInstances [Text]
tiInstanceIds = lens _tiInstanceIds (\ s a -> s{_tiInstanceIds = a});

instance AWSRequest TerminateInstances where
        type Sv TerminateInstances = EC2
        type Rs TerminateInstances =
             TerminateInstancesResponse
        request = post
        response
          = receiveXML
              (\ s h x ->
                 TerminateInstancesResponse' <$>
                   (may (parseXMLList "item") x) <*>
                     (pure (fromEnum s)))

instance ToHeaders TerminateInstances where
        toHeaders = const mempty

instance ToPath TerminateInstances where
        toPath = const "/"

instance ToQuery TerminateInstances where
        toQuery TerminateInstances'{..}
          = mconcat
              ["Action" =: ("TerminateInstances" :: ByteString),
               "Version" =: ("2015-04-15" :: ByteString),
               "DryRun" =: _tiDryRun,
               toQueryList "InstanceId" _tiInstanceIds]

-- | /See:/ 'terminateInstancesResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'tirTerminatingInstances'
--
-- * 'tirStatusCode'
data TerminateInstancesResponse = TerminateInstancesResponse'{_tirTerminatingInstances :: Maybe [InstanceStateChange], _tirStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'TerminateInstancesResponse' smart constructor.
terminateInstancesResponse :: Int -> TerminateInstancesResponse
terminateInstancesResponse pStatusCode = TerminateInstancesResponse'{_tirTerminatingInstances = Nothing, _tirStatusCode = pStatusCode};

-- | Information about one or more terminated instances.
tirTerminatingInstances :: Lens' TerminateInstancesResponse [InstanceStateChange]
tirTerminatingInstances = lens _tirTerminatingInstances (\ s a -> s{_tirTerminatingInstances = a}) . _Default;

-- | FIXME: Undocumented member.
tirStatusCode :: Lens' TerminateInstancesResponse Int
tirStatusCode = lens _tirStatusCode (\ s a -> s{_tirStatusCode = a});
