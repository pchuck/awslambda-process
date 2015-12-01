
package net.ultrametrics.awslambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class LambdaSumFunction {
  public String myHandler(int a, int b, Context context) {
    LambdaLogger logger = context.getLogger();
    logger.log("received : " + a + ", " + b);
    int sum = a + b;
    return String.valueOf(sum);
  }
}

