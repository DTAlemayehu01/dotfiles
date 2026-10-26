# openconnect-saml --server vpn.colorado.edu
# https://gist.github.com/rijans/de0d7cbf428309d1b41cb4c234198e90#modern-sso--saml-authentication-okta-azure-ad-entra-id
# Step 1: Authenticate in your normal user session (launches your desktop browser)
eval $(openconnect --authenticate --server vpn.colorado.edu)

# Step 2: Establish the tunnel interface using the received session token
if [ -n "$COOKIE" ]; then
    echo "$COOKIE" | sudo openconnect --cookie-on-stdin "$CONNECT_URL" \
        --servercert "$FINGERPRINT" --resolve "$RESOLVE"
else
    echo "Authentication failed or was cancelled."
fi
