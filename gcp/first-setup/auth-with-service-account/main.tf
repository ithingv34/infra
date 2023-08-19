terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "3.85.0"
      }
    }
}

provider "google" {
    project = "diesel-well-381307"
    region = "us-central1"
    zone = "us-central1-f"
    # key file의 경로를 설정한다.
    credentials = "C:/Users/l2t/Desktop/temp/gcp_key/key.json"
}

resource "google_storage_bucket" "gcs1" {
    name = "bucket-terraform-29292"
}