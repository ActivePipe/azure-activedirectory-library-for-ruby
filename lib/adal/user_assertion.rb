#-------------------------------------------------------------------------------
# # Copyright (c) Microsoft Open Technologies, Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#   http://www.apache.org/licenses/LICENSE-2.0
#
# THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS
# OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
# ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A
# PARTICULAR PURPOSE, MERCHANTABILITY OR NON-INFRINGEMENT.
#
# See the Apache License, Version 2.0 for the specific language
# governing permissions and limitations under the License.
#-------------------------------------------------------------------------------

require_relative './token_request'

module ADAL
  # An assertion and its representation type, stored as a JWT for
  # the on-behalf-of flow.
  class UserAssertion
    attr_reader :assertion
    attr_reader :assertion_type

    ##
    # Creates a new UserAssertion.
    #
    # @param String assertion
    #   An OAuth assertion representing the user.
    # @optional AssertionType assertion_type
    #   The type of the assertion being made. Currently only JWT_BEARER is
    #   supported.
    def initialize(
      assertion, assertion_type = ADAL::TokenRequest::GrantType::JWT_BEARER)
      @assertion = assertion
      @assertion_type = assertion_type
    end

    ##
    # The relevant OAuth access token request parameters for this object.
    #
    # @return Hash
    def request_params
      { grant_type: assertion_type,
        assertion: assertion,
        requested_token_use: :on_behalf_of,
        scope: :openid }
    end
  end
end