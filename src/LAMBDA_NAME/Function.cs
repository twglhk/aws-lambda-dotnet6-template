using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Amazon.Lambda.APIGatewayEvents;
using Amazon.Lambda.Core;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

// change LAMBDA_NAME to the name of your lambda
namespace WardGames.Zooports.Lambda.LAMBDA_NAME
{
    /// <summary>
    /// Function class for the lambda
    /// </summary>
    public class Function
    {
        /// <summary>
        /// LambdaContext를 저장하는 property
        /// </summary>
        public static ILambdaContext? LambdaContext { get; private set; }

        /// <summary>
        /// DynamoDb 사용을 위한 client
        /// </summary>
        // private IAmazonDynamoDB _dyanmoDBClient;

        /// <summary>
        /// default constructor
        /// </summary>
        public Function() 
        { 
            // _dyanmoDBClient = new AmazonDynamoDBClient();
        }

        /// <summary>
        /// Function handler for the lambda
        /// </summary>
        /// <param name="request">APIGatewayProxy로 들어오는 요청</param>
        /// <param name="context">Lambda관련 유용한 기능을 사용할 수 있는 context</param>
        /// <returns>APIGatewayProxy 요청에 대한 응답</returns>
        public async Task<APIGatewayProxyResponse> FunctionHandler(APIGatewayProxyRequest request, ILambdaContext context)
        {
            LambdaContext = context;
            
            return new APIGatewayProxyResponse
            {
                Body = null,
                StatusCode = 200,
            };
        }
    }
}
