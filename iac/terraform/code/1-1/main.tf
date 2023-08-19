provider "local" {
  # Configuration options

}

resource "local_file" "foo" {
  content  = "Hello world"
  filename = "${path.module}/foo.txt"
}

# 추가
data "local_file" "bar" {
  filename = "${path.module}/bar.txt"
}

# 결과를 확인하고 싶은 경우
# file_bar라는 이름의 object가 생성됨
output "file_bar" {
  value = data.local_file.bar
}