
## Animation
* Original speed : 0.01 sec/frame



## case01 : Laminar Natural Convection

### Parameters

```
$SPEED = 0.0 ![m/s] Flow Speed
$HEAT = 1000 ![W/m^2] Heat Flux
$HTC = 250 ![W/m^2] Heat Transfer Coefficient
$AMBIENT = 25 ![C] External Temperature
```

## case02 : Turbulent Natural Convection

### Parameters

```
$SPEED = 0.0 ![m/s] Flow Speed
```

```
! k-epsilon model
$BLT = 0.008 !Boundary Layer Thickness
$KE = 0.003 !Kinetic Energy
$KDR = 0.0001 !Kinetic Dissipation Rate
$KEclip = 0.000006 ! KE Clip of Material
$KEcmu = 0.09 ! KE Cmu of Material
```

## case03 : Turbulent Flow Convection

### Parameters

```
$SPEED = 0.001 ![m/s] Flow Speed
```


## case04 : Faster Turbulent Flow Convection

### Parameters

```
$SPEED = 0.01 ![m/s] Flow Speed
```


## case04 : Faster Turbulent Flow Convection

### Parameters

```
$SPEED = 0.05 ![m/s] Flow Speed
```
