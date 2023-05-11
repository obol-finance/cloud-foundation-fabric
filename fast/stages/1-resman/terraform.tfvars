outputs_location = "~/fast-config"

team_folders = {
  application = {
    descriptive_name = "Application"
    group_iam = {
      "gcp-application@obol.app" = ["roles/run.invoker", "roles/cloudbuild.builds.viewer"]
      "gcp-application-devops@obol.app" = [
        "roles/composer.admin",
        "roles/cloudbuild.builds.editor",
        "roles/run.admin",
        "roles/cloudfunctions.admin",
        "roles/cloudsql.admin",
        "roles/storage.objectAdmin",
        "roles/secretmanager.admin",
        "roles/source.admin",
        "roles/iam.serviceAccountAdmin",
        "roles/resourcemanager.projectIamAdmin"
      ]
    }
    impersonation_groups = [
    ]
  }
}


locations = {
  bq  = "US"
  gcs = "US"
}
