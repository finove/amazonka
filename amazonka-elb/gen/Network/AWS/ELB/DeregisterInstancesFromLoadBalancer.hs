{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.ELB.DeregisterInstancesFromLoadBalancer
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

-- | Deregisters the specified instances from the specified load balancer.
-- After the instance is deregistered, it no longer receives traffic from
-- the load balancer.
--
-- You can use DescribeLoadBalancers to verify that the instance is
-- deregistered from the load balancer.
--
-- For more information, see
-- <http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/US_DeReg_Reg_Instances.html Deregister and Register Amazon EC2 Instances>
-- in the /Elastic Load Balancing Developer Guide/.
--
-- <http://docs.aws.amazon.com/ElasticLoadBalancing/latest/APIReference/API_DeregisterInstancesFromLoadBalancer.html>
module Network.AWS.ELB.DeregisterInstancesFromLoadBalancer
    (
    -- * Request
      DeregisterInstancesFromLoadBalancer
    -- ** Request constructor
    , deregisterInstancesFromLoadBalancer
    -- ** Request lenses
    , diflbLoadBalancerName
    , diflbInstances

    -- * Response
    , DeregisterInstancesFromLoadBalancerResponse
    -- ** Response constructor
    , deregisterInstancesFromLoadBalancerResponse
    -- ** Response lenses
    , diflbrInstances
    , diflbrStatusCode
    ) where

import Network.AWS.ELB.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'deregisterInstancesFromLoadBalancer' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'diflbLoadBalancerName'
--
-- * 'diflbInstances'
data DeregisterInstancesFromLoadBalancer = DeregisterInstancesFromLoadBalancer'{_diflbLoadBalancerName :: Text, _diflbInstances :: [Instance]} deriving (Eq, Read, Show)

-- | 'DeregisterInstancesFromLoadBalancer' smart constructor.
deregisterInstancesFromLoadBalancer :: Text -> DeregisterInstancesFromLoadBalancer
deregisterInstancesFromLoadBalancer pLoadBalancerName = DeregisterInstancesFromLoadBalancer'{_diflbLoadBalancerName = pLoadBalancerName, _diflbInstances = mempty};

-- | The name of the load balancer.
diflbLoadBalancerName :: Lens' DeregisterInstancesFromLoadBalancer Text
diflbLoadBalancerName = lens _diflbLoadBalancerName (\ s a -> s{_diflbLoadBalancerName = a});

-- | The IDs of the instances.
diflbInstances :: Lens' DeregisterInstancesFromLoadBalancer [Instance]
diflbInstances = lens _diflbInstances (\ s a -> s{_diflbInstances = a});

instance AWSRequest
         DeregisterInstancesFromLoadBalancer where
        type Sv DeregisterInstancesFromLoadBalancer = ELB
        type Rs DeregisterInstancesFromLoadBalancer =
             DeregisterInstancesFromLoadBalancerResponse
        request = post
        response
          = receiveXMLWrapper
              "DeregisterInstancesFromLoadBalancerResult"
              (\ s h x ->
                 DeregisterInstancesFromLoadBalancerResponse' <$>
                   (x .@? "Instances" .!@ mempty >>=
                      may (parseXMLList "member"))
                     <*> (pure (fromEnum s)))

instance ToHeaders
         DeregisterInstancesFromLoadBalancer where
        toHeaders = const mempty

instance ToPath DeregisterInstancesFromLoadBalancer
         where
        toPath = const "/"

instance ToQuery DeregisterInstancesFromLoadBalancer
         where
        toQuery DeregisterInstancesFromLoadBalancer'{..}
          = mconcat
              ["Action" =:
                 ("DeregisterInstancesFromLoadBalancer" ::
                    ByteString),
               "Version" =: ("2012-06-01" :: ByteString),
               "LoadBalancerName" =: _diflbLoadBalancerName,
               "Instances" =: toQueryList "member" _diflbInstances]

-- | /See:/ 'deregisterInstancesFromLoadBalancerResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'diflbrInstances'
--
-- * 'diflbrStatusCode'
data DeregisterInstancesFromLoadBalancerResponse = DeregisterInstancesFromLoadBalancerResponse'{_diflbrInstances :: Maybe [Instance], _diflbrStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'DeregisterInstancesFromLoadBalancerResponse' smart constructor.
deregisterInstancesFromLoadBalancerResponse :: Int -> DeregisterInstancesFromLoadBalancerResponse
deregisterInstancesFromLoadBalancerResponse pStatusCode = DeregisterInstancesFromLoadBalancerResponse'{_diflbrInstances = Nothing, _diflbrStatusCode = pStatusCode};

-- | The remaining instances registered with the load balancer.
diflbrInstances :: Lens' DeregisterInstancesFromLoadBalancerResponse [Instance]
diflbrInstances = lens _diflbrInstances (\ s a -> s{_diflbrInstances = a}) . _Default;

-- | FIXME: Undocumented member.
diflbrStatusCode :: Lens' DeregisterInstancesFromLoadBalancerResponse Int
diflbrStatusCode = lens _diflbrStatusCode (\ s a -> s{_diflbrStatusCode = a});
