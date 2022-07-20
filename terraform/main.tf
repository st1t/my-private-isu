# localesに登録しているものは全て個々の事情に応じて修正してOK
# AMIを変えれば過去のISUCON環境も作れる。 https://github.com/matsuu/aws-isucon#ami
locals {
  app_name      = "${local.github_user}-isucon11-q" # あらゆるリソースのタグに利用している。好きな名前に修正してOK
  cidr_vpc      = "10.0"                             # Networkの第1,2オクテットまでを指定。既存のVPCとCIDRを被せたくない時に修正すると良い
  subnet_name   = "${local.app_name}-public-a"       # EC2のsubnet。末尾のa,c,dを変えればそれぞれのAZに構築される
  github_user   = "st1t"                             # GitHubに公開されている公開鍵を使ってAWSのキーペアに利用。GitHubに複数の鍵が登録している場合はどの鍵が利用されているか注意
  github_users  = "kikumoto TanigUhey"               # GitHubのユーザー名。これを利用して/home/${os_login_user}/.ssh/authorized_keysを設定
  os_login_user = "ubuntu"                           # authorized_keysを設定するOSのユーザー名

  game_instance_count = "3"                     # 競技者用EC2インスタンスの台数
  game_instance_ami   = "ami-0796be4f4814fc3d5" # 競技者用EC2インスタンスのAMI
  game_instance_type  = "c6i.large"             # 競技者用EC2インスタンスタイプ。公式推奨はc4.large
  game_spot_price     = "0.1"                   # 競技者用EC2スポットインスタンス料金。同一インスタンスタイプでもAZによって価格が異なるので注意

  bench_instance_count = "1"                     # ベンマーク用EC2インスタンスの台数
  bench_instance_ami   = "ami-0796be4f4814fc3d5" # ベンチマーク用EC2インスタンスのAMI
  bench_instance_type  = "c6i.xlarge"            # ベンチマーク用EC2インスタンスタイプ。公式推奨はc5.xlarge
  bench_spot_price     = "0.1"                   # ベンチマーク用EC2スポットインスタンスの最高価格。
}

data "http" "checkip" {
  url = "https://checkip.amazonaws.com/"
}

data "http" "public_key" {
  url = "https://github.com/${local.github_user}.keys"
}

module "my-private-isu" {
  source        = "./modules/my-private-isu"
  app_name      = local.app_name
  cidr_vpc      = local.cidr_vpc
  subnet_name   = local.subnet_name
  github_users  = local.github_users
  os_login_user = local.os_login_user
  my_ip         = "${chomp(data.http.checkip.body)}/32" # EC2のセキュリティグループに追加するIP
  public_key    = chomp(data.http.public_key.body)

  game_instance_count = local.game_instance_count
  game_instance_ami   = local.game_instance_ami
  game_instance_type  = local.game_instance_type
  game_spot_price     = local.game_spot_price

  bench_instance_count = local.bench_instance_count
  bench_instance_ami   = local.bench_instance_ami
  bench_instance_type  = local.bench_instance_type
  bench_spot_price     = local.bench_spot_price
}
