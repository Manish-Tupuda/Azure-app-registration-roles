provider "azuread" {
  version           = "=2.9.0"
 // client_id         = "*******"
 //client_secret     = "******"
  tenant_id         = "******"
}

 //type = "webapp/api"
 
   
/* 
resource "azuread_application_app_role" "old_api_read_approle" {
  application_object_id = azuread_application.old_api.id
  allowed_member_types  = ["User", "Application"]
  description           = "Can read and make payments"
  display_name          = "reader"
  is_enabled            = true
  value                 = "reader"

}
*/

resource "azuread_application" "new_api" {
   display_name                       = "dwerty_api"
    //available_to_other_tenants = false
    //oauth2_allow_implicit_flow = true
   // type                       = "webapp/api"
  identifier_uris            = ["api://test5apimanagement.azure-api.net/APIgate"]


 //sign_in_audience = "AzureADMultipleOrgs"
 
  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    oauth2_permission_scope {
        
  admin_consent_description  = "Allow the application to access the commit payment methods"
  admin_consent_display_name = "creator"
  enabled                 = true
  id      = "96183846-204b-4b43-82e1-5d2222eb4b9a"
  type                       = "User"
  user_consent_description  = "Allow the application to access the commit payment methods"
  user_consent_display_name  = "readers"
  value                      = "Task.readers"
}
  }
app_role {

   id = "1b19509b-32b1-4e9f-b71d-4992aa991966"
  allowed_member_types  = ["User", "Application"]
  description           = "Can reade payments"
  display_name          = "readers"
  enabled            = true
  value                 = "Task.reader"
 }



        required_resource_access {
        resource_app_id = "495235c9-b464-4b68-9e84-e61c7f7d6c9f"
        resource_access {
            id   = "1b19509b-32b1-4e9f-b71d-4992aa991966"
            type = "Role"
        }
    }
    web{

     redirect_uris   =["https://oauth.pstmn.io/v1/browser-callback"]
    
    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
    }
}
/*resource "azuread_application_oauth2_permission" "payment_apis_payment_read_scope" {
  application_object_id      = azuread_application.new_api.id
  admin_consent_description  = "Allow the application to access the commit payment methods"
  admin_consent_display_name = "reader"
  is_enabled                 = true
  type                       = "User"
  value                      = "reader"
  user_consent_description  = "Allow the application to access the commit payment methods"
  user_consent_display_name  = "readers"
}
*/

resource "azuread_service_principal" "payment_sp" {
  application_id               = azuread_application.new_api.application_id
  app_role_assignment_required = false
  tags = [ "payment", "api"]
}
/*
resource "azuread_application_password" "booking_api_pwd" {
  application_object_id = azuread_application.new_api.id
  display_name        = "My managed password"
  // value                 = "4jU7Q~bGIcM-Z2N4LgJy0B~gypLpu~2136jAC"
  end_date              = "2099-01-01T01:02:03Z"
}
*/
