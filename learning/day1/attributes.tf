provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAR7GL3JBVCPS3JYOJ"
  secret_key = "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"
}

resource "aws_eip" "myeip" {
  vpc      = true
}

/* this block would show all the output attributes
output "eip" {
  value = aws_eip.myeip
}
*/

/* this block would show only the public_ip of elastic ip  */
output "peip" {
  value = aws_eip.myeip.public_ip
}




resource "aws_s3_bucket" "mys3" {
  bucket = "cartoonnetwork"
}


/* 
output "mys3bucket" {
  value = aws_s3_bucket.mys3
}
*/
