# my-private-isu

[達人が教えるWebパフォーマンスチューニング](https://gihyo.jp/book/2022/978-4-297-12846-3)で出てくる[catatsuy/private-isu](https://github.com/catatsuy/private-isu)にterraformを加えたもの  
なお、fork-private-isuディレクトリはcatatsuy/private-isuを自分のリポジトリにフォークしたものなので注意

# terraform

stateファイルの管理はローカルにしているので、永続化したい場合はterraform cloudやS3を指定するなどすること

```shell
$ cd terraform/
$ vim main.tf # localsに定義されているgithub_useridを修正。その他項目の修正は任意。
$ terraform init
$ terraform apply
```

# ssh login

作成したEC2のPublic IPはterraform outputで確認できる。  
GitHubに登録している公開鍵のペアの秘密鍵を利用すればログインできる。

```shell
$ terraform output
bench_01_instance_id = "i-05ef1ab8c5b1af67b"
bench_01_public_ip = "3.113.17.36"
game_01_instance_id = "i-0eba157c55480b38e"
game_01_public_ip = "52.194.255.167"
$
# 競技者用
$ ssh -i ${GitHubに登録した公開鍵のペアの秘密鍵} ubuntu@52.194.255.167
# ベンチマーク用
$ ssh -i ${GitHubに登録した公開鍵のペアの秘密鍵} ubuntu@3.113.17.36
```

# リソースを使ってない時

## 短期間

EC2インスタンスを停止しておく  
Public IPは費用の観点から固定にしていないので注意

### 停止
```shell
$ ./stop-instance.sh 
{
    "StoppingInstances": [
        {
            "CurrentState": {
                "Code": 64,
                "Name": "stopping"
            },
            "InstanceId": "i-068127bf49c91b3c2",
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
$ 
```

### 起動

```shell
$ ./start-instance.sh
EC2インスタンスを起動中...
EC2 instance IP: "18.181.169.69"
$
$ ssh ubuntu@18.181.169.69
```

## 長期間

無駄に動かし続けるとお金がかかるので、全てのリソースを削除する

```shell
$ terraform destroy
```