local wind = _.Float(4, 30,2);
local power_actual = 2000;
local power = 1 / (1 +  std.exp(-1 * (wind-15)/2 + _.Float(-0.3, 0.3, 2))) * power_actual;
{
    type: "DataManagementDemo",
    Power: {
        Active: {
            value: power_actual,
            unit: "W",
        },
        Curve: {
            value: power,
            unit: "W",
        },
        Mean: {
            value: _.Int(1200, 1600),
            unit: "W",
        },
        Max: {
            value: _.Int(1500, 2500),
            unit: "W",
        },
        Min: {
            value: _.Int(800, 1000),
            unit: "W",
        }
    },
     Rotation: {
        Speed: {
            value: _.Int(0, 200),
            unit: "rpm",
        },
        Max: {
            value: _.Int(0, 1000),
            unit: "°",
        },
        Mean: {
            value: _.Int(0, 200),
            unit: "°",
        }
    },
    Energy: {
        Produced: {
            value: _.Int(200, 1600),
            unit: "Wh",
        }
    },
    BatchId: var("batchId", "1")
}