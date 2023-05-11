# use `gcloud beta billing accounts list`
# if you have too many accounts, check the Cloud Console :)
billing_account = {
  id = "010235-396372-5DC925"
}

# use `gcloud organizations list`
organization = {
  domain      = "obol.app"
  id          = 1068395049087
  customer_id = "C01zw5x4f"
}

outputs_location = "~/fast-config"

# use something unique and no longer than 9 characters
prefix = "nyx"

fast_features = {
  data_platform   = true
  gke             = false
  project_factory = true
  sandbox         = true
  teams           = true
}

locations = {
  bq      = "US"
  gcs     = "US"
  logging = "global"
  pubsub  = []
}
