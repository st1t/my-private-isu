# localesに登録しているものは全て個々の事情に応じて修正してOK
locals {
  github_userid = "st1t" # EC2インスタンスの公開鍵に利用。GitHubに複数の鍵が登録している場合はどの鍵が利用されているか注意
  app_name      = "my-private-isu" # あらゆるリソースのタグに利用している。好きな名前に修正してOK
  cidr_vpc      = "10.0" # Networkの第1,2オクテットまでを指定。既存のVPCとCIDRを被せたくない時に修正すると良い
  instance_type = "t3.medium" # EC2インスタンスタイプ
}

data http checkip {
  url = "https://checkip.amazonaws.com/"
}

data http public_key {
  url = "https://github.com/${local.github_userid}.keys"
}

module "my-private-isu" {
  source        = "./modules/my-private-isu"
  app_name      = local.app_name
  cidr_vpc      = local.cidr_vpc
  my_ip         = "${chomp(data.http.checkip.body)}/32"
  public_key    = chomp(data.http.public_key.body)
  instance_type = local.instance_type
}
