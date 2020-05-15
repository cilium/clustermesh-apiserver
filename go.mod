module github.com/cilium/clustermesh-apiserver

go 1.14

replace (
	github.com/miekg/dns => github.com/cilium/dns v1.1.4-0.20190417235132-8e25ec9a0ff3
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	k8s.io/client-go => github.com/cilium/client-go v0.0.0-20200326103132-fe7bd31c2794
)

require (
	github.com/cilium/cilium v1.7.0-rc2.0.20200414081415-afc48b73b65a
	github.com/google/gops v0.3.6
	github.com/sirupsen/logrus v1.4.2
	github.com/spf13/cobra v0.0.5
	golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5
	k8s.io/api v0.18.0
	k8s.io/apimachinery v0.18.0
	k8s.io/client-go v0.18.0
)
