# AWS SSO for Lens

### Configure aws profile

Use this template but replace: `sso_account_id`, `sso_start_url`

```
[profile master]
sso_session = master
sso_account_id = 535002847494
sso_role_name = AdminAccess
region = us-east-1
[sso-session master]
sso_start_url = https://d-9067cb5889.awsapps.com/start/#
sso_region = us-east-1
sso_registration_scopes = sso:account:access
```

Start sso session

```
aws sso login --profile master
```

Open Lens tools and select the kubernetes context