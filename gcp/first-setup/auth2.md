# Google Cloud Shell을 통한 인증

1. GCP Console에 접속하여 terraform 인프라를 설정할 프로젝트를 선택한다.
2. cloud shell에 접속한다.
<br>
   <img src="./../img/setup/5.png">
   <img src="./../img/setup/6.png">
<br>
3. terraform 버전을 확인한다.
    ```
    terraform version
    ```
    <img src="./../img/setup/7.png">

4. vi 파일을 열어 main.tf 파일을 생성한다.
   ```
    mkdir gcs && cd gcs

    # vi main.tf

    terraform {
        required_providers {
        google = {
            source = "hashicorp/google"
            version = "3.85.0"
        }
        }
    }

    provider "google" {
        project = "PROJECT_ID" 
        region = "REGION_NAME"
        zone = "ZONE_NAME"
    }

    resource "google_storage_bucket" "MY_BUCEKT" {
        name = "MY_GCS_BUCKET"
        location = "LOCATION" 
    }

    # wq!
   ```
<img src="./../img/setup/22.png">

1. terraform 명령어로 GCS 생성
```terraform   
terraform init
terraform plan
terraform apply
```
<img src="./../img/setup/24.png">
<img src="./../img/setup/25.png">
1. 생성된 버킷 확인
    <img src="./../img/setup/23.ng">