resource "aws_iam_group" "my_developers" {
  name = var.user[0]
  path = "/"
}

resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  group = aws_iam_group.my_developers.name
  policy = file("policydeveloper.json")
}

resource "aws_iam_group" "my_testers" {
  name = var.user[1]
  path = "/"
}

resource "aws_iam_group_policy" "my_tester_policy" {
  name  = "my_tester_policy"
  group = aws_iam_group.my_testers.name
  policy = file("policytester.json")
}

resource "aws_iam_group" "my_production" {
  name = var.user[2]
  path = "/"
}

resource "aws_iam_group_policy" "my_production_policy" {
  name  = "my_production_policy"
  group = aws_iam_group.my_production.name
  policy = file("policyproduction.json")
}
