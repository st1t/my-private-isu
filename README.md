# my-private-isu

[達人が教えるWebパフォーマンスチューニング](https://gihyo.jp/book/2022/978-4-297-12846-3)で出てくる[catatsuy/private-isu](https://github.com/catatsuy/private-isu)にterraformを加えたもの  
なお、fork-private-isuディレクトリはcatatsuy/private-isuを自分のリポジトリにフォークしたものなので注意

# terraform

stateファイルの管理はローカルにしているので、永続化したい場合はterraform cloudやS3を指定するなどすること

```shell
$ cd terraform/
$ terraform init
$ terraform apply
```

# ssh login

作成したEC2のPublic IPはterraform outputで確認できる。  
GitHubに登録している公開鍵のペアの秘密鍵を利用すればログインできる。

```shell
$ terraform output
ec2-01-public-ip = "54.168.88.47"
$ ssh -i ${GitHubに登録した公開鍵のペアの秘密鍵} ubuntu@54.168.88.47
```