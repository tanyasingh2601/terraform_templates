#AWS Instance
resource "aws_instance" "exampleEBS" {
    ami = "ami-03d315ad33b9d49c4"
    instance_type = "t2.micro"
    availability_zone = var.aws_zone
  
  lifecycle {
    ignore_changes = [ami]
  }
}

#EBS Volume and Attachment

resource "aws_ebs_volume" "exampleEBS" {
  availability_zone = var.aws_zone
  size              = 40
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.exampleEBS.id
  instance_id = aws_instance.exampleEBS.id
}

#Cloudwatch Metric

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name                = "cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2" 
  period                    = "120" #seconds
  statistic                 = "Average"
  threshold                 = "80" 
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
        InstanceId = aws_instance.exampleEBS.id
      }
}
