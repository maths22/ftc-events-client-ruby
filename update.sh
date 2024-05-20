# java -jar /Users/jburroughs/.m2/repository/org/openapitools/openapi-generator-cli/5.0.0-SNAPSHOT/openapi-generator-cli-5.0.0-SNAPSHOT.jar generate -i https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json -g ruby -c config.json 
# curl https://localhost:5001/swagger/v2.0/swagger.json > apispec.json
swagger-codegen generate -i https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json -l ruby -c config.json 
# rm apispec.json

sed "s/@scheme = 'http'/@scheme = 'https'/g" lib/ftc_events_client/configuration.rb > .tmpsedfile && mv .tmpsedfile lib/ftc_events_client/configuration.rb
sed "s/@host = 'localhost'/@host = 'ftc-api.firstinspires.org'/g" lib/ftc_events_client/configuration.rb > .tmpsedfile && mv .tmpsedfile lib/ftc_events_client/configuration.rb 
sed "s/@base_path = '.*'/@base_path = nil/g" lib/ftc_events_client/configuration.rb > .tmpsedfile && mv .tmpsedfile lib/ftc_events_client/configuration.rb 
