module github.com/cilium/clustermesh-apiserver

go 1.14

replace (
	github.com/miekg/dns => github.com/cilium/dns v1.1.4-0.20190417235132-8e25ec9a0ff3
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	k8s.io/client-go => github.com/cilium/client-go v0.0.0-20200813235008-6b28ea7c1c4e
)

require (
	github.com/cilium/cilium v1.8.3
	github.com/google/gops v0.3.6
	github.com/sirupsen/logrus v1.4.2
	github.com/spf13/cobra v1.0.0
	golang.org/x/sys v0.0.0-20200420163511-1957bb5e6d1f
	k8s.io/api v0.18.8
	k8s.io/apimachinery v0.18.8
	k8s.io/client-go v0.18.8
)
