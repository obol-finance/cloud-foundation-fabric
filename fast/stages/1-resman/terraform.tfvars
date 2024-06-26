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
        "roles/compute.viewer",
        "roles/iap.admin",
        "roles/cloudbuild.workerPoolEditor",
        "roles/artifactregistry.admin",
        "roles/oauthconfig.editor",
        "roles/pubsub.admin",
        "roles/iam.serviceAccountUser",
        "roles/iap.tunnelResourceAccessor",
        "roles/iam.workloadIdentityPoolAdmin",
        "roles/monitoring.alertPolicyEditor",
        "roles/monitoring.editor",
        # TODO (Or): this is grants too high permissions
        "roles/editor"
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
