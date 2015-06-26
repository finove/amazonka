{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.DirectConnect.ConfirmPublicVirtualInterface
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

-- | Accept ownership of a public virtual interface created by another
-- customer.
--
-- After the virtual interface owner calls this function, the specified
-- virtual interface will be created and made available for handling
-- traffic.
--
-- <http://docs.aws.amazon.com/directconnect/latest/APIReference/API_ConfirmPublicVirtualInterface.html>
module Network.AWS.DirectConnect.ConfirmPublicVirtualInterface
    (
    -- * Request
      ConfirmPublicVirtualInterface
    -- ** Request constructor
    , confirmPublicVirtualInterface
    -- ** Request lenses
    , conVirtualInterfaceId

    -- * Response
    , ConfirmPublicVirtualInterfaceResponse
    -- ** Response constructor
    , confirmPublicVirtualInterfaceResponse
    -- ** Response lenses
    , conVirtualInterfaceState
    , conStatusCode
    ) where

import Network.AWS.DirectConnect.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | Container for the parameters to the ConfirmPublicVirtualInterface
-- operation.
--
-- /See:/ 'confirmPublicVirtualInterface' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'conVirtualInterfaceId'
newtype ConfirmPublicVirtualInterface = ConfirmPublicVirtualInterface'{_conVirtualInterfaceId :: Text} deriving (Eq, Read, Show)

-- | 'ConfirmPublicVirtualInterface' smart constructor.
confirmPublicVirtualInterface :: Text -> ConfirmPublicVirtualInterface
confirmPublicVirtualInterface pVirtualInterfaceId = ConfirmPublicVirtualInterface'{_conVirtualInterfaceId = pVirtualInterfaceId};

-- | FIXME: Undocumented member.
conVirtualInterfaceId :: Lens' ConfirmPublicVirtualInterface Text
conVirtualInterfaceId = lens _conVirtualInterfaceId (\ s a -> s{_conVirtualInterfaceId = a});

instance AWSRequest ConfirmPublicVirtualInterface
         where
        type Sv ConfirmPublicVirtualInterface = DirectConnect
        type Rs ConfirmPublicVirtualInterface =
             ConfirmPublicVirtualInterfaceResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ConfirmPublicVirtualInterfaceResponse' <$>
                   (x .?> "virtualInterfaceState") <*>
                     (pure (fromEnum s)))

instance ToHeaders ConfirmPublicVirtualInterface
         where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("OvertureService.ConfirmPublicVirtualInterface" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ConfirmPublicVirtualInterface where
        toJSON ConfirmPublicVirtualInterface'{..}
          = object
              ["virtualInterfaceId" .= _conVirtualInterfaceId]

instance ToPath ConfirmPublicVirtualInterface where
        toPath = const "/"

instance ToQuery ConfirmPublicVirtualInterface where
        toQuery = const mempty

-- | The response received when ConfirmPublicVirtualInterface is called.
--
-- /See:/ 'confirmPublicVirtualInterfaceResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'conVirtualInterfaceState'
--
-- * 'conStatusCode'
data ConfirmPublicVirtualInterfaceResponse = ConfirmPublicVirtualInterfaceResponse'{_conVirtualInterfaceState :: Maybe VirtualInterfaceState, _conStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'ConfirmPublicVirtualInterfaceResponse' smart constructor.
confirmPublicVirtualInterfaceResponse :: Int -> ConfirmPublicVirtualInterfaceResponse
confirmPublicVirtualInterfaceResponse pStatusCode = ConfirmPublicVirtualInterfaceResponse'{_conVirtualInterfaceState = Nothing, _conStatusCode = pStatusCode};

-- | FIXME: Undocumented member.
conVirtualInterfaceState :: Lens' ConfirmPublicVirtualInterfaceResponse (Maybe VirtualInterfaceState)
conVirtualInterfaceState = lens _conVirtualInterfaceState (\ s a -> s{_conVirtualInterfaceState = a});

-- | FIXME: Undocumented member.
conStatusCode :: Lens' ConfirmPublicVirtualInterfaceResponse Int
conStatusCode = lens _conStatusCode (\ s a -> s{_conStatusCode = a});
