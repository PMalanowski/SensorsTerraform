resource "aws_sfn_state_machine" "iot_state_machine" {
  name     = "iot_sensor_analysis"
  role_arn = var.lab_role_arn  # używamy tej samej LabRole

  definition = jsonencode({
  "Comment": "State Machine uruchamiająca równolegle lambdy do obliczania średniej temperatury dla każdej lokalizacji",
  "StartAt": "GetGroupedData",
  "States": {
    "GetGroupedData": {
      "Type": "Task",
      "Resource": aws_lambda_function.distributor.arn,
      "Next": "CalculateAvgTemp"
    },
    "CalculateAvgTemp": {
      "Type": "Parallel",
      "Branches": [
        {
          "StartAt": "AvgTempForGroup0",
          "States": {
            "AvgTempForGroup0": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[0]",
              "End": true
            }
          }
        },
        {
          "StartAt": "AvgTempForGroup1",
          "States": {
            "AvgTempForGroup1": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[1]",
              "End": true
            }
          }
        },
        {
          "StartAt": "AvgTempForGroup2",
          "States": {
            "AvgTempForGroup2": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[2]",
              "End": true
            }
          }
        },
        {
          "StartAt": "AvgTempForGroup3",
          "States": {
            "AvgTempForGroup3": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[3]",
              "End": true
            }
          }
        },
        {
          "StartAt": "AvgTempForGroup4",
          "States": {
            "AvgTempForGroup4": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[4]",
              "End": true
            }
          }
        },
        {
          "StartAt": "AvgTempForGroup5",
          "States": {
            "AvgTempForGroup5": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[5]",
              "End": true
            }
          }
        },
        {
          "StartAt": "AvgTempForGroup6",
          "States": {
            "AvgTempForGroup6": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[6]",
              "End": true
            }
          }
        },
        {
          "StartAt": "AvgTempForGroup7",
          "States": {
            "AvgTempForGroup7": {
              "Type": "Task",
              "Resource": aws_lambda_function.processor.arn,
              "InputPath": "$.grouped_data[7]",
              "End": true
            }
          }
        }
      ],
      "End": true
    }
  }
})
}
