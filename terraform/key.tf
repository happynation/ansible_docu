resource "aws_key_pair" "jenkins_terra" {
  key_name   = "jenkins_terra"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}