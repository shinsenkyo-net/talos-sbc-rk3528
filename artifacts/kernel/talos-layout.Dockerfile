# syntax=docker/dockerfile:1
# Repackage the raw `kernel-radxa-e24c` bldr output into the layout the Talos
# imager expects from PKG_KERNEL (sidero-talos Dockerfile: /boot/vmlinuz,
# /usr/lib/modules, /usr/share/spdx/kernel.spdx.json).
# Built by .github/workflows/kernel.yml; was a hand-run /tmp file until 2026-11-16.
ARG RAW_KERNEL
FROM ${RAW_KERNEL} AS src

FROM scratch
COPY --from=src /rootfs/boot/ /boot/
COPY --from=src /rootfs/certs/ /certs/
COPY --from=src /rootfs/lib/modules/ /usr/lib/modules/
COPY --from=src /rootfs/artifacts/ /artifacts/
COPY <<'SPDX' /usr/share/spdx/kernel.spdx.json
{"SPDXVersion":"SPDX-2.3","SPDXID":"SPDXRef-DOCUMENT","name":"talos-kernel-rk3528","documentNamespace":"https://github.com/shinsenkyo-net/talos-sbc-rk3528/spdx/kernel-rk3528","creationInfo":{"created":"2026-07-23T00:00:00Z","creators":["Tool: custom-kernel-build"]},"packages":[]}
SPDX
