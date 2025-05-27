# 概要
React + Vite ( + Tailwind )を使ったドキュメントページをGithubPage 上へデプロイするまでの流れを記録したものです。
shell コマンドによって基本的には基礎となる設定は完了するはずです。

## 自分自身でスクリプトを使用して、セットアップ (React - Vite + Tailwind) 🛠️

1. **ダウンロードシェルコマンドスクリプト:** 
  このスクリプトで、React-ViteをベースとしたTailwindを適用するwebアプリケーションのテンプレートを作成します。
  さらに、GitHubPageへのデプロイも兼ねた設定も行います。
   ```bash
    setup-react-vite.sh
   ```
2. **パーミッション付与用のコマンド:** 
   ```bash
    chmod +x setup-react-vite.sh
   ```
3. **セットアップ用コマンドの実行(名前はお好みで)**
    必ず、フロントエンドのフォルダ名と、作るレポジトリの名前、Githubのユーザー名を入れてください
    ```bash
    ./setup-react-vite.sh <FrontEndName> <Repo_Name> <GitHub_UserName>
   ```
4. **ローカルでテスト**
    作成し終わったら、以下コマンドでローカル実行してみてください。
    localhost:5173/<Repo_Name>でアクセスできるはずです。
    ```bash
    npm run dev
   ```


## デプロイ
1. **レポジトリ作成と初期コミット:** 
   ```bash
    git init
    git add .
    git commit -m "Initial commit"
    git remote add origin https://github.com/USER_NAME/REPO_NAME.git
    git branch -M main 
    git push -u origin main
   ```
2. **Reactアプリケーションフォルダへ移動:** 
   ```bash
    cd <Your_App_Folder>
   ```
3. **GitHubPage用にビルドとデプロイ**
    事前にbuildも行われて、distフォルダの中身のみがデプロイされずはずです
    ```bash
    npm run deploy
   ```
4. **GitHubPageの確認**
   以下URLを確認するか、
   Settings > Pages > Visit Site で アプリケーションが正常に表示されるか確認してみてください
    (https://<USERNAME>.github.io/<REPONAME>/)
