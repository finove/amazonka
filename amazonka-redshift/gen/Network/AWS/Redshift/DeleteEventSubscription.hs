{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.Redshift.DeleteEventSubscription
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

-- | Deletes an Amazon Redshift event notification subscription.
--
-- <http://docs.aws.amazon.com/redshift/latest/APIReference/API_DeleteEventSubscription.html>
module Network.AWS.Redshift.DeleteEventSubscription
    (
    -- * Request
      DeleteEventSubscription
    -- ** Request constructor
    , deleteEventSubscription
    -- ** Request lenses
    , desSubscriptionName

    -- * Response
    , DeleteEventSubscriptionResponse
    -- ** Response constructor
    , deleteEventSubscriptionResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Redshift.Types
import Network.AWS.Request
import Network.AWS.Response

-- |
--
-- /See:/ 'deleteEventSubscription' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'desSubscriptionName'
newtype DeleteEventSubscription = DeleteEventSubscription'{_desSubscriptionName :: Text} deriving (Eq, Read, Show)

-- | 'DeleteEventSubscription' smart constructor.
deleteEventSubscription :: Text -> DeleteEventSubscription
deleteEventSubscription pSubscriptionName = DeleteEventSubscription'{_desSubscriptionName = pSubscriptionName};

-- | The name of the Amazon Redshift event notification subscription to be
-- deleted.
desSubscriptionName :: Lens' DeleteEventSubscription Text
desSubscriptionName = lens _desSubscriptionName (\ s a -> s{_desSubscriptionName = a});

instance AWSRequest DeleteEventSubscription where
        type Sv DeleteEventSubscription = Redshift
        type Rs DeleteEventSubscription =
             DeleteEventSubscriptionResponse
        request = post
        response
          = receiveNull DeleteEventSubscriptionResponse'

instance ToHeaders DeleteEventSubscription where
        toHeaders = const mempty

instance ToPath DeleteEventSubscription where
        toPath = const "/"

instance ToQuery DeleteEventSubscription where
        toQuery DeleteEventSubscription'{..}
          = mconcat
              ["Action" =:
                 ("DeleteEventSubscription" :: ByteString),
               "Version" =: ("2012-12-01" :: ByteString),
               "SubscriptionName" =: _desSubscriptionName]

-- | /See:/ 'deleteEventSubscriptionResponse' smart constructor.
data DeleteEventSubscriptionResponse = DeleteEventSubscriptionResponse' deriving (Eq, Read, Show)

-- | 'DeleteEventSubscriptionResponse' smart constructor.
deleteEventSubscriptionResponse :: DeleteEventSubscriptionResponse
deleteEventSubscriptionResponse = DeleteEventSubscriptionResponse';
