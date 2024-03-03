# Azure blog

This is to hold the infrastructure for an Azure web blog project.

## Set up Azure CLI

1. Download the CLI.
2. Log in with `az login`.
3. Set the subscription with `az account set --subscription "<SUBSCRIPTION_ID>"`.
4. Create a service principal with `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"`. This will output a set of authentication credentials.
5. Set the env variables for client ID, secret, tenant, and subscription ID.

```bash
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_ID>"
```

