FROM alpine:3.8 as build
RUN apk add --update --no-cache ca-certificates git

WORKDIR /

RUN apk add --update -t deps curl tar gzip bash openssl
RUN  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v1.11.5/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && \
     chmod +x /usr/local/bin/kubectl


# The image we keep
FROM docker:stable

RUN apk add --update --no-cache git ca-certificates bash gettext curl jq
ADD ./wait_dind.sh /usr/local/bin/wait_dind.sh

COPY --from=build /usr/local/bin/helm /bin/helm
COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl

ENTRYPOINT ["/bin/helm"]
