{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.SNS.ListSubscriptions
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

-- | Returns a list of the requester\'s subscriptions. Each call returns a
-- limited list of subscriptions, up to 100. If there are more
-- subscriptions, a @NextToken@ is also returned. Use the @NextToken@
-- parameter in a new @ListSubscriptions@ call to get further results.
--
-- <http://docs.aws.amazon.com/sns/latest/api/API_ListSubscriptions.html>
module Network.AWS.SNS.ListSubscriptions
    (
    -- * Request
      ListSubscriptions
    -- ** Request constructor
    , listSubscriptions
    -- ** Request lenses
    , lsNextToken

    -- * Response
    , ListSubscriptionsResponse
    -- ** Response constructor
    , listSubscriptionsResponse
    -- ** Response lenses
    , lsrNextToken
    , lsrSubscriptions
    , lsrStatusCode
    ) where

import Network.AWS.Pager
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response
import Network.AWS.SNS.Types

-- | Input for ListSubscriptions action.
--
-- /See:/ 'listSubscriptions' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lsNextToken'
newtype ListSubscriptions = ListSubscriptions'{_lsNextToken :: Maybe Text} deriving (Eq, Read, Show)

-- | 'ListSubscriptions' smart constructor.
listSubscriptions :: ListSubscriptions
listSubscriptions = ListSubscriptions'{_lsNextToken = Nothing};

-- | Token returned by the previous @ListSubscriptions@ request.
lsNextToken :: Lens' ListSubscriptions (Maybe Text)
lsNextToken = lens _lsNextToken (\ s a -> s{_lsNextToken = a});

instance AWSPager ListSubscriptions where
        page rq rs
          | stop (rs ^. lsrNextToken) = Nothing
          | stop (rs ^. lsrSubscriptions) = Nothing
          | otherwise =
            Just $ rq & lsNextToken .~ rs ^. lsrNextToken

instance AWSRequest ListSubscriptions where
        type Sv ListSubscriptions = SNS
        type Rs ListSubscriptions = ListSubscriptionsResponse
        request = post
        response
          = receiveXMLWrapper "ListSubscriptionsResult"
              (\ s h x ->
                 ListSubscriptionsResponse' <$>
                   (x .@? "NextToken") <*>
                     (x .@? "Subscriptions" .!@ mempty >>=
                        may (parseXMLList "member"))
                     <*> (pure (fromEnum s)))

instance ToHeaders ListSubscriptions where
        toHeaders = const mempty

instance ToPath ListSubscriptions where
        toPath = const "/"

instance ToQuery ListSubscriptions where
        toQuery ListSubscriptions'{..}
          = mconcat
              ["Action" =: ("ListSubscriptions" :: ByteString),
               "Version" =: ("2010-03-31" :: ByteString),
               "NextToken" =: _lsNextToken]

-- | Response for ListSubscriptions action
--
-- /See:/ 'listSubscriptionsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lsrNextToken'
--
-- * 'lsrSubscriptions'
--
-- * 'lsrStatusCode'
data ListSubscriptionsResponse = ListSubscriptionsResponse'{_lsrNextToken :: Maybe Text, _lsrSubscriptions :: Maybe [Subscription], _lsrStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'ListSubscriptionsResponse' smart constructor.
listSubscriptionsResponse :: Int -> ListSubscriptionsResponse
listSubscriptionsResponse pStatusCode = ListSubscriptionsResponse'{_lsrNextToken = Nothing, _lsrSubscriptions = Nothing, _lsrStatusCode = pStatusCode};

-- | Token to pass along to the next @ListSubscriptions@ request. This
-- element is returned if there are more subscriptions to retrieve.
lsrNextToken :: Lens' ListSubscriptionsResponse (Maybe Text)
lsrNextToken = lens _lsrNextToken (\ s a -> s{_lsrNextToken = a});

-- | A list of subscriptions.
lsrSubscriptions :: Lens' ListSubscriptionsResponse [Subscription]
lsrSubscriptions = lens _lsrSubscriptions (\ s a -> s{_lsrSubscriptions = a}) . _Default;

-- | FIXME: Undocumented member.
lsrStatusCode :: Lens' ListSubscriptionsResponse Int
lsrStatusCode = lens _lsrStatusCode (\ s a -> s{_lsrStatusCode = a});
