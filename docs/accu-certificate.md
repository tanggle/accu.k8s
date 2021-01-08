1. Generate a CA certificate Private Key
```bash
openssl genrsa -out ca.key 4096
```

2. Generate the CA Certificate
```bash
openssl req -x509 -new -nodes -sha512 -days 3650 -subj "/C=KR/ST=/L=/O=SK holdings C&C/OU=/CN=AccuInsight+ Kubernetes" -key ca.key -out ca.crt
```

3. Generate a Server Certificate
```bash
openssl genrsa -out server.key 4096
```

4. Generate a Certificate Signing Request
```bash
cat > san.cnf <<EOF
[req]
distinguished_name = req_distinguished_name
req_extensions     = req_ext
[req_distinguished_name]
C  = KR
ST =
L  =
O  = SK holdings C&C
OU =
CN = accuinsight.io
[req_ext]
subjectAltName = @alt_names
[alt_names]
DNS.1 = *.accuinsight.io
DNS.2 = gcr.io
DNS.3 = *.gcr.io
DNS.4 = quay.io
DNS.5 = *.quay.io
DNS.6 = docker.io
DNS.7 = *.docker.io
EOF
```
```bash
openssl req -sha512 -new -subj "/C=KR/ST=/L=/O=SK holding C&C/OU=/CN=accuinsight.io" -key server.key -out server.csr -config san.cnf
```

> Check a Certificate Signing Request (CSR):
>
> openssl req -text -noout -verify -in server.csr

5. Sign
```bash
openssl x509 -req -sha512 -days 3650 -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt -extensions req_ext -extfile san.cnf
```

> Check a Certificate (CRT):
>
> openssl x509 -in server.crt -text -noout

