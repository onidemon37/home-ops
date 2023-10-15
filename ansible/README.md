# Openssl

``` shell
openssl req -x509 \
  -sha256 -days 356 \
  -nodes \
  -newkey rsa:2048 \
  -subj "/CN=ninhu.xyz/C=US/L=Milton Keynes" \
  -keyout rootCA.key -out rootCA.crt
```
