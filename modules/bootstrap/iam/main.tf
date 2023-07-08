resource "aws_iam_group" "local_group" {
  for_each = var.local_group_policy

  name = each.key
}

resource "aws_iam_group_policy_attachment" "local_group_attachment" {
  for_each = var.local_group_policy

  group = aws_iam_group.local_group[each.key].name
  policy_arn = each.value
}

resource "aws_iam_user" "admin_user" {
  for_each = toset(var.admin_names)
  name = each.value
}

resource "aws_iam_user" "read_user" {
  for_each = toset(var.read_names)
  name = each.value
}

resource "aws_iam_group_membership" "admin_group" {
  for_each = aws_iam_user.admin_user

  name = "admin-group-${each.value.name}"
  group = aws_iam_group.local_group["admin-group"].name
  users = [each.value.name]
}

resource "aws_iam_group_membership" "read_group" {
  for_each = aws_iam_user.read_user

  name = "readonly-group-${each.value.name}"
  group = aws_iam_group.local_group["readonly-group"].name
  users = [each.value.name]
}
