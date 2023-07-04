outputs_location = "~/fast-config"

psa_ranges = {
  dev = {
    ranges = {
      google-managed-services-dev-spoke-0 = "10.12.0.0/16"
    },
    routes = {
      export = true
      import = true
    }
  },
  prod = {
    ranges = {
      google-managed-services-prod-spoke-0 = "10.12.0.0/16"
    },
    routes = {
      export = true
      import = true
    }
  }
}


regions = {
  primary = "us-central1"
  secondary = "us-west1"
}