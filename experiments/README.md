## Smart City Experiments

This folder contains the helm charts for the smart cities devices.

### Install

```sh
helm upgrade --install battery-device smart-city --values smart-city/values/battery-device-values.yaml
helm upgrade --install ev-charging-device smart-city --values smart-city/values/ev-charging-device-values.yaml
helm upgrade --install parking-spot-device smart-city --values smart-city/values/parking-spot-device-values.yaml
helm upgrade --install pole-air-quality-observed-device smart-city --values smart-city/values/pole-air-quality-observed-device-values.yaml
helm upgrade --install pole-weather-observed-device smart-city --values smart-city/values/pole-weather-observed-device-values.yaml
helm upgrade --install streetlight-device smart-city --values smart-city/values/streetlight-device-values.yaml
```

### Uninstall

```sh
helm uninstall battery-device
helm uninstall ev-charging-device
helm uninstall parking-spot-device
helm uninstall pole-air-quality-observed-device
helm uninstall pole-weather-observed-device
helm uninstall streetlight-device
```

### Simulate Install

```sh
helm install experiments smart-city --values smart-city/values/battery-device-values.yaml --dry-run > output.yaml
```
