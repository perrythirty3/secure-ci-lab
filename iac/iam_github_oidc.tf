data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "gh_oidc_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::\:oidc-provider/token.actions.githubusercontent.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:perrythirty3/secure-ci-lab:*"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "gh_actions_ci" {
  name               = "GhActions-ReadSecrets"
  assume_role_policy = data.aws_iam_policy_document.gh_oidc_trust.json
}

resource "aws_secretsmanager_secret" "app" {
  name = "secure-ci/api_key"
}

data "aws_iam_policy_document" "read_secret" {
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [aws_secretsmanager_secret.app.arn]
  }
}

resource "aws_iam_policy" "read_secret" {
  name   = "ReadSecureCiSecret"
  policy = data.aws_iam_policy_document.read_secret.json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.gh_actions_ci.name
  policy_arn = aws_iam_policy.read_secret.arn
}