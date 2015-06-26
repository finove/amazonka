{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.CloudHSM.CreateHAPG
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

-- | Creates a high-availability partition group. A high-availability
-- partition group is a group of partitions that spans multiple physical
-- HSMs.
--
-- <http://docs.aws.amazon.com/cloudhsm/latest/dg/API_CreateHAPG.html>
module Network.AWS.CloudHSM.CreateHAPG
    (
    -- * Request
      CreateHAPG
    -- ** Request constructor
    , createHAPG
    -- ** Request lenses
    , chLabel

    -- * Response
    , CreateHAPGResponse
    -- ** Response constructor
    , createHAPGResponse
    -- ** Response lenses
    , chrHAPGARN
    , chrStatusCode
    ) where

import Network.AWS.CloudHSM.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | Contains the inputs for the CreateHapgRequest action.
--
-- /See:/ 'createHAPG' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'chLabel'
newtype CreateHAPG = CreateHAPG'{_chLabel :: Text} deriving (Eq, Read, Show)

-- | 'CreateHAPG' smart constructor.
createHAPG :: Text -> CreateHAPG
createHAPG pLabel = CreateHAPG'{_chLabel = pLabel};

-- | The label of the new high-availability partition group.
chLabel :: Lens' CreateHAPG Text
chLabel = lens _chLabel (\ s a -> s{_chLabel = a});

instance AWSRequest CreateHAPG where
        type Sv CreateHAPG = CloudHSM
        type Rs CreateHAPG = CreateHAPGResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 CreateHAPGResponse' <$>
                   (x .?> "HapgArn") <*> (pure (fromEnum s)))

instance ToHeaders CreateHAPG where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("CloudHsmFrontendService.CreateHAPG" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON CreateHAPG where
        toJSON CreateHAPG'{..} = object ["Label" .= _chLabel]

instance ToPath CreateHAPG where
        toPath = const "/"

instance ToQuery CreateHAPG where
        toQuery = const mempty

-- | Contains the output of the CreateHAPartitionGroup action.
--
-- /See:/ 'createHAPGResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'chrHAPGARN'
--
-- * 'chrStatusCode'
data CreateHAPGResponse = CreateHAPGResponse'{_chrHAPGARN :: Maybe Text, _chrStatusCode :: Int} deriving (Eq, Read, Show)

-- | 'CreateHAPGResponse' smart constructor.
createHAPGResponse :: Int -> CreateHAPGResponse
createHAPGResponse pStatusCode = CreateHAPGResponse'{_chrHAPGARN = Nothing, _chrStatusCode = pStatusCode};

-- | The ARN of the high-availability partition group.
chrHAPGARN :: Lens' CreateHAPGResponse (Maybe Text)
chrHAPGARN = lens _chrHAPGARN (\ s a -> s{_chrHAPGARN = a});

-- | FIXME: Undocumented member.
chrStatusCode :: Lens' CreateHAPGResponse Int
chrStatusCode = lens _chrStatusCode (\ s a -> s{_chrStatusCode = a});
