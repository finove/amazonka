{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.ElasticBeanstalk.DescribeApplications
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

-- | Returns the descriptions of existing applications.
--
-- <http://docs.aws.amazon.com/elasticbeanstalk/latest/api/API_DescribeApplications.html>
module Network.AWS.ElasticBeanstalk.DescribeApplications
    (
    -- * Request
      DescribeApplications
    -- ** Request constructor
    , describeApplications
    -- ** Request lenses
    , daApplicationNames

    -- * Response
    , DescribeApplicationsResponse
    -- ** Response constructor
    , describeApplicationsResponse
    -- ** Response lenses
    , darApplications
    , darStatusCode
    ) where

import Network.AWS.ElasticBeanstalk.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | This documentation target is not reported in the API reference.
--
-- /See:/ 'describeApplications' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'daApplicationNames'
newtype DescribeApplications = DescribeApplications'{_daApplicationNames :: Maybe [Text]} deriving (Eq, Read, Show)

-- | 'DescribeApplications' smart constructor.
describeApplications :: DescribeApplications
describeApplications = DescribeApplications'{_daApplicationNames = Nothing};

-- | If specified, AWS Elastic Beanstalk restricts the returned descriptions
-- to only include those with the specified names.
daApplicationNames :: Lens' DescribeApplications [Text]
daApplicationNames = lens _daApplicationNames (\ s a -> s{_daApplicationNames = a}) . _Default;

instance AWSRequest DescribeApplications where
        type Sv DescribeApplications = ElasticBeanstalk
        type Rs DescribeApplications =
             DescribeApplicationsResponse
        request = post
        response
          = receiveXMLWrapper "DescribeApplicationsResult"
              (\ s h x ->
                 DescribeApplicationsResponse' <$>
                   (x .@? "Applications" .!@ mempty >>=
                      may (parseXMLList "member"))
                     <*> (pure (fromEnum s)))

instance ToHeaders DescribeApplications where
        toHeaders = const mempty

instance ToPath DescribeApplications where
        toPath = const "/"

instance ToQuery DescribeApplications where
        toQuery DescribeApplications'{..}
          = mconcat
              ["Action" =: ("DescribeApplications" :: ByteString),
               "Version" =: ("2010-12-01" :: ByteString),
               "ApplicationNames" =:
                 toQuery
                   (toQueryList "member" <$> _daApplicationNames)]

-- | Result message containing a list of application descriptions.
--
-- /See:/ 'describeApplicationsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'darApplications'
--
-- * 'darStatusCode'
data DescribeApplicationsResponse = DescribeApplicationsResponse'{_darApplications :: Maybe [ApplicationDescription], _darStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'DescribeApplicationsResponse' smart constructor.
describeApplicationsResponse :: Int -> DescribeApplicationsResponse
describeApplicationsResponse pStatusCode = DescribeApplicationsResponse'{_darApplications = Nothing, _darStatusCode = pStatusCode};

-- | This parameter contains a list of ApplicationDescription.
darApplications :: Lens' DescribeApplicationsResponse [ApplicationDescription]
darApplications = lens _darApplications (\ s a -> s{_darApplications = a}) . _Default;

-- | FIXME: Undocumented member.
darStatusCode :: Lens' DescribeApplicationsResponse Int
darStatusCode = lens _darStatusCode (\ s a -> s{_darStatusCode = a});
