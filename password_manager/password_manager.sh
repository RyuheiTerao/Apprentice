#!/bin/bash

echo パスワードマネージャーへようこそ!
echo -n サービス名を入力してください：
read serviceName

echo -n ユーザー名を入力してください：
read userName

echo -n パスワードを入力してください：
read password

echo

echo $serviceName:$userName:$password>>password_db.txt

echo Thank you!
