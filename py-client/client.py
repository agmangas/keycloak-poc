import logging
import os
import pprint

import coloredlogs
import jwt
import requests
from oic.oic import Client
from oic.oic.message import RegistrationResponse
from oic.utils.authn.client import CLIENT_AUTHN_METHOD
from requests.auth import HTTPBasicAuth

_logger = logging.getLogger(__name__)

CLIENT_ID = os.environ.get("CLIENT_ID", "poc-client-default")
CLIENT_SECRET = os.environ.get("CLIENT_SECRET", "E8zLtm1XfMqzON9EYLF6X93VuxhO3xKi")

# Provider Well-Known Configuration Endpoint
CONFIG_ENDPOINT = os.environ.get(
    "CONFIG_ENDPOINT",
    "http://localhost:8080/realms/poc-realm/.well-known/openid-configuration",
)

USER_NAME = os.environ.get("USER_NAME", "theuser")
USER_PASS = os.environ.get("USER_PASS", "thepassword")

API_ENDPOINT = os.environ.get("API_URL", "http://localhost:3000/api/protected")


def main():
    _logger.info("OIDC client Proof-of-Concept")

    client = Client(client_authn_method=CLIENT_AUTHN_METHOD)

    provider_info = requests.get(CONFIG_ENDPOINT).json()
    _logger.debug("Provider info:\n%s", pprint.pformat(provider_info))
    client.handle_provider_config(provider_info, provider_info["issuer"])

    reg_resp_kwargs = {"client_id": CLIENT_ID, "client_secret": CLIENT_SECRET}
    _logger.debug("Client config:\n%s", pprint.pformat(reg_resp_kwargs))
    client_reg = RegistrationResponse(**reg_resp_kwargs)
    client.store_registration_info(client_reg)

    # A POST request to the Token Endpoint
    # (https://openid.net/specs/openid-connect-core-1_0.html#TokenEndpoint)
    # which is the first authentication step in the Resource Owner Password Flow
    # (https://oauth.net/2/grant-types/password/)
    # (https://auth0.com/docs/get-started/authentication-and-authorization-flow/resource-owner-password-flow)

    token_data = {
        "grant_type": "password",
        "username": USER_NAME,
        "password": USER_PASS,
        "scope": "openid",
    }

    token_resp = requests.post(
        client.token_endpoint,
        data=token_data,
        auth=HTTPBasicAuth(CLIENT_ID, CLIENT_SECRET),
    )

    token_resp_body = token_resp.json()
    access_token = token_resp_body["access_token"]
    id_token = token_resp_body["id_token"]

    _logger.info("Token response:\n%s", pprint.pformat(token_resp_body))

    _logger.info(
        "ID token:\n%s",
        pprint.pformat(jwt.decode(id_token, options={"verify_signature": False})),
    )

    api_resp = requests.get(
        API_ENDPOINT, headers={"Authorization": f"Bearer {access_token}"}
    )

    api_resp.raise_for_status()

    _logger.info("API request OK: %s", api_resp.json())

    # https://openid.net/specs/openid-connect-core-1_0.html#RefreshingAccessToken

    refresh_data = {
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "grant_type": "refresh_token",
        "scope": "openid profile",
        "refresh_token": token_resp_body["refresh_token"],
    }

    refresh_resp = requests.post(client.token_endpoint, data=refresh_data)
    refresh_resp.raise_for_status()
    refresh_resp_body = refresh_resp.json()

    _logger.info("Refresh token response:\n%s", pprint.pformat(refresh_resp_body))


if __name__ == "__main__":
    coloredlogs.install(level=logging.DEBUG)
    main()
