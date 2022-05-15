output "ec2_ips" {
  value = ["${aws_eip.publicip.*.public_ip}"]
}

resource "local_file" "eips" {
    content  = join("\n", "${aws_eip.publicip.*.public_ip}")
    filename = "info/eips.txt"
}