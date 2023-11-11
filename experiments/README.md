## Smart City Experiments

This folder contains the helm charts for the smart cities devices.

### Install

```sh
helm upgrade --install small-city-battery-device smart-city --values smart-city/values/battery-device-values.yaml
```

### Uninstall

```sh
helm uninstall small-city-battery-device
```

### Simulate Install

```sh
helm install experiments smart-city --values smart-city/values/battery-device-values.yaml --dry-run > output.yaml
```
