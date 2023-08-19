# dataproc 에서 VM을 프로비저닝하면 다음과 같은 컴포넌트가 설치됨

1. Hadoop: Dataproc는 Hadoop 분산 파일 시스템(HDFS)을 포함하여 Hadoop 생태계의 주요 컴포넌트를 지원합니다. 예를 들어, MapReduce, YARN, Hive, Pig 등이 있습니다.

2. Spark: Dataproc는 Spark를 기본적으로 지원합니다. Spark는 대규모 데이터 처리 및 분석에 매우 유용한 분산 컴퓨팅 프레임워크입니다.

3. Hive: Hive는 Hadoop에서 대규모 데이터를 분석하기 위한 데이터 웨어하우징 솔루션입니다. Dataproc에서는 Hive가 설치되어 있으며, SQL 기반 쿼리 작성을 지원합니다.

4. Pig: Pig는 Hadoop에서 대규모 데이터를 분석하기 위한 플랫폼으로, Dataproc에서는 Pig가 설치되어 있습니다.

5. HBase: HBase는 분산형 NoSQL 데이터베이스이며, Dataproc에서는 HBase가 설치되어 있습니다.

6. Zeppelin: Zeppelin은 웹 기반 노트북 환경에서 다양한 프로그래밍 언어를 지원하는 데이터 분석 및 시각화 도구입니다. Dataproc에서는 Zeppelin이 설치되어 있습니다.

7. Scala: Scala는 Java 가상 머신에서 실행되는 함수형 프로그래밍 언어이며, Spark와 같은 분산 컴퓨팅 프레임워크에서 많이 사용됩니다. Dataproc에서는 Scala가 설치되어 있습니다.

8. Python: Python은 간결하고 직관적인 문법을 가진 인터프리터 언어로, 데이터 처리 및 분석 작업에 많이 사용됩니다. Dataproc에서는 Python 2.x와 Python 3.x 모두 설치되어 있습니다.

9. Presto: Presto는 대용량 데이터 처리를 위한 오픈소스 분산 SQL 쿼리 엔진입니다. Dataproc에서는 Presto가 설치되어 있습니다.

10. Jupyter: Jupyter는 웹 기반 노트북 환경에서 다양한 프로그래밍 언어를 지원하는 데이터 분석 및 시각화 도구입니다. Dataproc에서는 Jupyter가 설치되어 있으며, Python, R, Scala 등 다양한 언어를 지원합니다.

11. Mahout: Mahout은 Apache Hadoop에서 대규모 머신러닝 분석을 위한 라이브러리입니다. Dataproc에서는 Mahout이 설치되어 있습니다.

12. Flink: Flink는 스트리밍 데이터 처리와 배치 데이터 처리를 모두 지원하는 오픈소스 분산 데이터 처리 엔진입니다. Dataproc에서는 Flink가 설치되어 있습니다.

13. TensorFlow: TensorFlow는 구글에서 개발한 딥러닝 프레임워크입니다. Dataproc에서는 TensorFlow가 설치되어 있으며, GPU 가속도를 사용할 수 있습니다.

14. BigDL: BigDL은 인텔에서 개발한 딥러닝 프레임워크로, Spark 상에서 실행됩니다. Dataproc에서는 BigDL이 설치되어 있습니다.

15. Hive: Hive는 Hadoop에서 SQL 기반 데이터 웨어하우스 시스템을 구축할 수 있는 데이터 분석 도구입니다. Dataproc에서는 Hive가 설치되어 있습니다.

16. Sqoop: Sqoop은 RDBMS와 Hadoop 간의 데이터 이전을 지원하는 도구입니다. Dataproc에서는 Sqoop이 설치되어 있습니다.

17. Oozie: Oozie는 Hadoop 작업을 스케줄링하고 관리하는 워크플로우 엔진입니다. Dataproc에서는 Oozie가 설치되어 있습니다.

18. HBase: HBase는 Hadoop에서 대규모 데이터의 분산 저장을 위한 NoSQL 데이터베이스입니다. Dataproc에서는 HBase가 설치되어 있습니다.

---

Terraform을 사용하여 Dataproc 클러스터를 프로비저닝하는 코드는 다음과 같습니다.

terraform
Copy code
provider "google" {
  project = "<your-project-id>"
  region  = "us-central1"
}

resource "google_dataproc_cluster" "example" {
  name          = "example-cluster"
  project       = "<your-project-id>"
  region        = "us-central1"
  cluster_name  = "example-cluster"
  master_config {
    num_instances = 1
    machine_type  = "n1-standard-4"
  }
  worker_config {
    num_instances = 2
    machine_type  = "n1-standard-4"
  }
  initialization_action {
    executable_file = "gs://<your-bucket-name>/init-actions/setup.sh"
  }
  lifecycle {
    ignore_changes = [
      initialization_action,
      worker_config[0].num_instances,
      worker_config[1].num_instances,
    ]
  }
}

output "cluster_endpoint" {
  value = google_dataproc_cluster.example.endpoint
}
위 코드에서 <your-project-id>와 <your-bucket-name>을 자신의 프로젝트 ID와 Google Cloud Storage 버킷 이름으로 바꿔주어야 합니다.

위 코드는 Dataproc 클러스터를 생성하고, 마스터 노드와 워커 노드를 설정하며, 클러스터 초기화 스크립트를 실행하는 등의 기능을 포함하고 있습니다. output 블록에서는 클러스터의 엔드포인트를 출력합니다.

참고로, Dataproc 클러스터는 생성 및 삭제 시간이 다소 걸리기 때문에, Terraform apply 시간이 오래 걸릴 수 있습니다.




이상훈
이어서 말해줘
!

2 / 2

Dataproc 클러스터를 프로비저닝하는 Terraform 코드를 계속해서 설명해드리겠습니다.

위 코드에서 provider 블록에서는 google 공급자를 사용하도록 지정합니다. project와 region 변수는 Google Cloud 프로젝트 ID와 지역을 설정합니다.

google_dataproc_cluster 리소스 블록에서는 name과 cluster_name 변수를 사용하여 Dataproc 클러스터의 이름을 설정합니다. project와 region 변수를 이용하여 클러스터가 생성될 프로젝트 ID와 지역을 지정합니다.

master_config 블록에서는 마스터 노드의 구성을 설정합니다. num_instances 변수는 마스터 노드 인스턴스의 수를 설정하며, machine_type 변수는 인스턴스에 할당할 머신 유형을 설정합니다.

worker_config 블록에서는 워커 노드의 구성을 설정합니다. num_instances 변수는 워커 노드 인스턴스의 수를 설정하며, machine_type 변수는 인스턴스에 할당할 머신 유형을 설정합니다.

initialization_action 블록에서는 클러스터가 시작될 때 실행할 초기화 스크립트를 지정합니다. 위 코드에서는 gs://<your-bucket-name>/init-actions/setup.sh 스크립트를 실행하도록 지정하였습니다.

lifecycle 블록에서는 클러스터 구성이 변경되어도 재배포를 방지합니다.

마지막으로, output 블록에서는 google_dataproc_cluster 리소스에서 반환된 endpoint 속성을 출력합니다. 이 엔드포인트는 클러스터에 연

