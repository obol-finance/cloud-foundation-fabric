outputs_location = "~/fast-config"

team_folders = {
  application = {
    descriptive_name = "Application"
    group_iam = {
      "gcp-application-devops@obol.app" = [
        "roles/composer.admin",
        "roles/cloudbuild.builds.editor",
        "roles/run.admin",
        "roles/cloudfunctions.admin",
        "roles/cloudsql.admin",
        "roles/storage.admin",
        "roles/secretmanager.admin",
        "roles/source.admin",
        "roles/iam.serviceAccountAdmin",
        "roles/resourcemanager.projectIamAdmin",
        "roles/compute.instanceAdmin",
        "roles/iap.admin",
        "roles/cloudbuild.workerPoolEditor",
        "roles/artifactregistry.admin",
        "roles/oauthconfig.editor",
        "roles/pubsub.admin"
      ]
    }
    impersonation_groups = [
    ]
  }
}

custom_roles = {

}


locations = {
  bq  = "US"
  gcs = "US"
}
