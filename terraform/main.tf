# localesに登録しているものは全て個々の事情に応じて修正してOK
locals {
  github_userid       = "st1t" # EC2インスタンスの公開鍵に利用。GitHubに複数の鍵が登録している場合はどの鍵が利用されているか注意
  app_name            = "${local.github_userid}-private-isu" # あらゆるリソースのタグに利用している。好きな名前に修正してOK
  cidr_vpc            = "10.0" # Networkの第1,2オクテットまでを指定。既存のVPCとCIDRを被せたくない時に修正すると良い
  game_instance_type  = "c6i.large" # 競技者用EC2インスタンスタイプ。公式推奨はc4.large
  game_spot_price     = "0.1" # 競技者用EC2スポットインスタンス料金。同一インスタンスタイプでもAZによって価格が異なるので注意
  bench_instance_type = "c6i.xlarge" # ベンチマーク用EC2インスタンスタイプ。公式推奨はc5.xlarge
  bench_spot_price    = "0.1" # ベンチマーク用EC2スポットインスタンスの最高価格。
  subnet_name         = "${local.app_name}-public-a" # EC2のsubnet。末尾のa,c,dを変えればそれぞれのAZに構築される
}

data http checkip {
  url = "https://checkip.amazonaws.com/"
}

data http public_key {
  url = "https://github.com/${local.github_userid}.keys"
}

module "my-private-isu" {
  source              = "./modules/my-private-isu"
  app_name            = local.app_name
  cidr_vpc            = local.cidr_vpc
  my_ip               = "${chomp(data.http.checkip.body)}/32"
  public_key          = chomp(data.http.public_key.body)
  game_instance_type  = local.game_instance_type
  game_spot_price     = local.game_spot_price
  bench_instance_type = local.bench_instance_type
  bench_spot_price    = local.bench_spot_price
  subnet_name         = local.subnet_name
}
