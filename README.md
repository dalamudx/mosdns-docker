# mosdns
Fork 自 [IrineSistiana/mosdns-docker](https://github.com/IrineSistiana/mosdns-docker)
主程序项目[irinesistiana/mosdns](https://github.com/IrineSistiana/mosdns)

## 支持架构
  - `amd64`,`x86`,`armv6`,`armv7`,`arm64`,`ppc64le`,`riscv64`,`s390x`

## 镜像地址
- https://hub.docker.com/r/dalamudx/mosdns

## 使用说明
- 本镜像为了能够灵活处理一些个人需求，不会自动更新`app`或`supervisor.d`目录下文件，这意味着如果需要一些新支持的功能，需要手动更新`app`或`supervisor.d`目录下文件跟仓库保持一致
- 基于上面所述更新逻辑，你可以自定义服务和脚本，但随仓库更新`app`或`supervisor.d`目录时，请根据更新历史中的文件变动说明(总是与上一个发布版本相对比)自行`diff`文件内容，以保持本地自定义设置，切勿简单替换，而造成本地配置丢失

## 更新历史
- 2025-01-02 自编译mosdns，实现部分自动化需求功能